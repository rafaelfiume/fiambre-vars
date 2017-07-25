#!/bin/bash

load_env_vars() {
    local projectName=$1
    printf "Loading $projectName environment variables...\n"
    local envVarsPath=$(get_vars_file $projectName)
    local envVars=$(read_vars $envVarsPath)
    for var in $envVars
    do
        echo "Added $var"
        export $var
    done
}

read_vars() {
    local path=$1
    local vars=""
    while read -r line || [[ -n "$line" ]]; do
        vars="$vars $line"
    done < "$path"
    echo $vars
}

get_vars_file() {
    local projectName=$1
    echo "$(pwd)/projects/$projectName/env.vars"
}

get_hidden_vars_file() {
    local projectName=$1
    echo "$(pwd)/projects/$projectName/hidden.env.vars"
}
