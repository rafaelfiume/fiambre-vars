#!./test/libs/bats/bin/bats

load 'libs/bats-support/load'
load 'libs/bats-assert/load'
load 'setup-teardown'

loadEnvVars=./loadEnvVars.sh

setup() {
    setupEnv
}

teardown() {
    teardownEnv
}

@test "should set environment variables defined for prosciutto project" {
    projectName=prosciutto

    run $loadEnvVars $projectName

    assert_success
    assert_line --index 0 "Loading $projectName environment variables..."
    assert_line --index 1 "Added SUPPLIER_STAGING_URL=http://sheltered-river-1312.herokuapp.com/salume/supplier"
}

@test "should check if project argument is valid" {
    projectName=unknown

    run $loadEnvVars $projectName

    #assert_failure
    assert_line --index 0 "Loading $projectName environment variables..."
    assert_line --index 1 "Cannot find path '$FIAMBRE_DIR/projects/unknown/env.vars' because it does not exist."
}
