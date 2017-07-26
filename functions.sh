#!/bin/bash

load_env_vars() {
    local projectName=$1
    printf "Loading $projectName environment variables...\n"

    local envVarsPath=$(get_vars_file $projectName)
    if [ ! -f $envVarsPath ]; then
        printf "Cannot find path \'"$envVarsPath"\' because it does not exist."
        exit 1
    fi

    local envVars=$(read_vars "$envVarsPath")
    for var in $envVars
    do
        echo "Added $var"
        export $var
    done
}

read_vars() {
    local path=$1
    local vars=""
    lines=$(sed -e 's/ //g' -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' < $path)
    for l in $lines; do
        vars="$vars $l"
    done
    echo $vars
}

get_vars_file() {
    local projectName=$1
    echo "$(pwd)/projects/"$projectName"/env.vars"
}

get_hidden_vars_file() {
    local projectName=$1
    echo "$(pwd)/projects/"$projectName"/hidden.env.vars"
}
