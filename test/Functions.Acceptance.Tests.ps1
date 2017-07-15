$root = Split-Path -Parent $PSScriptRoot
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Acceptance.Tests\.', '.'
. "$root\$sut"

Describe "Load-Env-Vars" {
    Mock Set-Var-In-Dev-Environment

    It "should set environment variables defined for prosciutto project" {
        $projectName = "prosciutto"

        Load-Env-Vars $projectName

        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Key -eq "SUPPLIER_STAGING_URL"}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Value -eq "http://sheltered-river-1312.herokuapp.com/salume/supplier"}
    }
}

Describe "Load-Env-Vars" {
    Mock Set-Var-In-Dev-Environment

    It "should check if project argument is valid" {
        $projectName = "unknown"

        Load-Env-Vars $projectName

        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 0
    }
}
