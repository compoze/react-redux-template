#!/usr/bin/env bash

set -eo pipefail

## declare functions
. ./scripts/get_environment_vars.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."

BUCKET_NAME=$1
ENV=$2

npm ci
get_environment_vars $ENV

echo "building $ENV with environments: $environments"
npm run build

S3_URL="s3://${BUCKET_NAME}.${ENV}"
echo "Deploying website to ${S3_URL}"

aws s3 sync --delete ./build "$S3_URL"
