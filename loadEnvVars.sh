#!/bin/bash

FIAMBRE_DIR="$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
source $FIAMBRE_DIR/functions.sh

main() {
    project=$1
    load_env_vars $project
}
main "$@"