#!/usr/bin/env bash

set -eo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR/.."
ENVIRONMENTS_DIR="${PROJECT_DIR}/environments"

ENVIRONMENT=$1
if [ "$ENVIRONMENT" != "development" ] &&  [ "$ENVIRONMENT" != "stage" ] && [ "$ENVIRONMENT" != "production" ]; then
    echo "$ENVIRONMENT is invalid, supported build environments are development, stage, or production"
    exit 1
fi


echo "Building for $ENVIRONMENT"
env-cmd -f ./environments/.$ENVIRONMENT.env npm run-script build