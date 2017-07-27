[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/rafaelfiume/fiambre-vars/blob/master/LICENSE)
# fiambre-vars

If you have a [12-Factor App](https://12factor.net), you need a way to load its [app's config](https://12factor.net/config) in your development environment. This is what _fiambre-vars does_: it loads the enviroment variables that [Salumeria stack](https://rafaelfiume.com/2013/04/07/dragons-unicorns-and-titans-an-agile-software-developer-tail/) needs to run in a local machine.

## Defining the Environment Variables of a Project

Create a folder with the name of a project in the _projects_ directory (e.g. _prosciutto_). Add the following files:
 * `env.vars` => for plain environment variables
 * `hidden.env.vars` => for environment variables with sensitive information.

`hidden.env.vars` files are not stored in the repository, so they need to be added manually in each machine we want to load the variables defined using _fiambre-vars_.

## Linux or Mac OS X

### Loading the Vars in Bash

When in the ${FIAMBRE_DIR}, type:

     λ → source ./loadEnvVars.sh [project]

[project] is one of the folders under the _projects_ dir. For example:

     λ → ./loadEnvVars.sh prosciutto

When in another directory, type the same command relatively to ${FIAMBRE_DIR}, like:

     λ → source ../fiambre-vars/loadEnvVars.sh [project]

### Development

Acceptance and unit tests are under the _test_ folder. To run them, type in ${FIAMBRE_DIR}:

     λ → ./test.sh

Use [git submodule update](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to update bats projects.

Check [this](https://github.com/rafaelfiume/fiambre-vars/issues/2) out for more info.

## Windows

### Loading the Vars in Windows

Open a PowerShell command-line shell, go to ${FIAMBRE_DIR} and type:

     λ → .\Load-Env-Vars.ps1 [project]

### Development

Acceptance and unit tests are under the _test_ folder. To run them, type in ${FIAMBRE_DIR}:

     λ → Invoke-Pester

Check [this](https://github.com/rafaelfiume/fiambre-vars/issues/1) out for more info.