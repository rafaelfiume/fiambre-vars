#!/bin/bash

source functions.sh

main() {
    project=$1
    load_env_vars $project
}
main "$@"