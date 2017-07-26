#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'

# Include the mock testing library
# source lib/mock.sh

# Include the user library for testing it
source ./functions.sh

########################################
#
#    Tests
#
########################################

@test "load_env_vars() should set environment variables defined for a project" {
    #mock_cmd 'get_vars_file' 'm_get_vars_file'
    mock_cmd 'read_vars' 'm_read_vars'

    local projectName=prosciutto

    run load_env_vars $projectName

    assert_success
    assert_line --index 0 "Loading $projectName environment variables..."
    assert_line --index 1 "Added FIRST_ENV_VAR=the/first"
}

@test "read_vars() should return the vars defined for a project" {
    local varsFile=$ENV_VARS_FILE
    add_content $varsFile "FIRST_ENV_VAR=the/first"
    add_content $varsFile "SECOND_ENV_VAR=the_second"

    local vars=$(read_vars $varsFile)

    assert_equal "$vars" "FIRST_ENV_VAR=the/first SECOND_ENV_VAR=the_second"
}

@test "read_vars() should ignore leading, trailing and intermediate whitespace" {
    local varsFile=$ENV_VARS_FILE
    add_content $varsFile "FIRST_ENV_VAR  =  the/first"

    local vars=$(read_vars $varsFile)

    assert_equal "$vars" "FIRST_ENV_VAR=the/first"
}

@test "read_vars() should ignore comments (a line starting with #)" {
    local varsFile=$ENV_VARS_FILE
    add_content $varsFile "# This is a comment in a vars.file"

    local vars=$(read_vars $varsFile)

    assert_equal "$vars" ""
}

@test "get_vars_file() should return the path to the env.vars file of a project" {
    local project="prosciutto"

    local pathToVarsFile=$(get_vars_file $project)

    assert_equal $pathToVarsFile "$FIAMBRE_DIR/projects/$project/env.vars"
}

@test "get_hidden_vars_file() should return the path to the hidden.env.vars file of a project" {
    local project="prosciutto"

    local pathToVarsFile=$(get_hidden_vars_file $project)

    assert_equal $pathToVarsFile "$FIAMBRE_DIR/projects/$project/hidden.env.vars"
}

########################################
#
#    Setup and Teardown
#
########################################

setup() {
    setupEnv
}

teardown() {
    teardownEnv
}

setupEnv() {
    export FIAMBRE_DIR="$(pwd)" # Relative to ../test.sh
    export A_PROJECT_DIR=$(mktemp -d)
    export ENV_VARS_FILE=$A_PROJECT_DIR/env.vars
    touch $ENV_VARS_FILE
}

teardownEnv() {
  if [ $BATS_TEST_COMPLETED ]; then
    rm -rf $A_PROJECT_DIR
  else
    echo "** Did not delete $A_PROJECT_DIR, as test failed **"
  fi
}

########################################
#
#    Helpers
#
########################################

add_content() {
    filename=$1
    content=$2
    echo $content >> $filename
}

########################################
#
#    Mocks -> Heavily inspired on https://oper.io/?p=bash_mock_objects_commands
#
########################################

mock_cmd() {
    local command="${1:-}"
    local override="${2:-}"
    unset ${command}
    eval "${command}() { ${override} \${@}; }"
}

m_read_vars() {
    echo "FIRST_ENV_VAR=the/first SECOND_ENV_VAR=the_second"
}

m_get_vars_file() {
    echo "/a/mocked/path/to/a/project/env.vars"
}