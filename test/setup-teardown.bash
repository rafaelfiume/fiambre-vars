
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