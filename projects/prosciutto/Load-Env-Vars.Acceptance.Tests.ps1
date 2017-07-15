$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Acceptance.Tests\.', '.'
. "$here\$sut"

Describe "Load-Env-Vars" {
    Mock Set-Var-In-Dev-Environment
    It "should set environment variables defined for prosciutto project" {
        Load-Env-Vars
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Key -eq "SUPPLIER_STAGING_URL"}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Value -eq "http://sheltered-river-1312.herokuapp.com/salume/supplier"}
    }
}
