[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/rafaelfiume/fiambre-vars/blob/master/LICENSE)
# fiambre-vars

It loads, in a local dev environment, the variables that [Salumeria](https://rafaelfiume.com/2013/04/07/dragons-unicorns-and-titans-an-agile-software-developer-tail/) projects needs to run.

### Defining the Environment Variables of a Project

Create a folder with the name of a project in the _projects_ directory (e.g. _prosciutto_). Add the following files:
 * `env.vars` => for plain environment variables
 * `hidden.env.vars` => for environment variables with sensitive information.

`hidden.env.vars` files are not stored in the repository, so they need to be added manually in each machine we want to load the variables defined using _fiambre-vars_.

### Loading the Vars in Windows

Open a PowerShell command-line shell, go to ${FIAMBRE_DIR} and type:

     λ → .\Load-Env-Vars.ps1 [project]

[project] is one of the folders under the _projects_ dir. For example `.\Load-Env-Vars.ps1 prosciutto`


### Development

Acceptance and unit tests are under the _test_ directory. To run them, in the project root directory, type:

     λ → Invoke-Pester

Checkout [Pester](https://github.com/pester/Pester) for more info.