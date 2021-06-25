#!/usr/bin/env bash

set -eo pipefail

## declare functions
. ./scripts/init_environment.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."

ENV=$1

if [[ -z "${ENV}" ]]; then
    echo "no environment provided"
    exit 1
else
    echo "installing dependencies"
    npm ci
    echo "generating env variable file for $ENV"
    npm run compoze:environment -- -n $ENV -e Environment=$ENV
    echo "building component"
    npm run build
    echo "provisioning $ENV site"
    npm run provision "$ENV"
    echo "deploying "$ENV" site"
    npm run deploy "$ENV"
fi
