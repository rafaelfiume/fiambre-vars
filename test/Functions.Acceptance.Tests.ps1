﻿$root = Split-Path -Parent $PSScriptRoot
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Acceptance.Tests\.', '.'
. "$root\$sut"

Describe "Load-Env-Vars" {
    Mock Write-Host
    Mock Set-Var-In-Dev-Environment

    It "should set environment variables defined for prosciutto project" {
        $projectName = "prosciutto"

        Load-Env-Vars $projectName

        Assert-MockCalled Write-Host -Scope It -Times 1 -ParameterFilter { $Object -eq "Loading $($projectName) environment variables..." }
        Assert-MockCalled Write-Host -Scope It -Times 1 -ParameterFilter { $Object -eq "Added SUPPLIER_STAGING_URL=http://sheltered-river-1312.herokuapp.com/salume/supplier" }
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Key -eq "SUPPLIER_STAGING_URL"}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Value -eq "http://sheltered-river-1312.herokuapp.com/salume/supplier"}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 0 -ParameterFilter { $Key -eq ""}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 0 -ParameterFilter { $Value -eq "myPassword"}
    }
}

Describe "Load-Env-Vars" {
    Mock Write-Host
    Mock Set-Var-In-Dev-Environment

    It "should check if project exists" {
        $projectName = "unknown"

        Load-Env-Vars $projectName

        Assert-MockCalled Write-Host -Scope It -Times 1 -ParameterFilter { $Object -eq "Loading $($projectName) environment variables..." }
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 0
    }

    It "should check if project is empty" {
        $projectName = " "

        Load-Env-Vars $projectName

        Assert-MockCalled Write-Host -Scope It -Times 1 -ParameterFilter { $Object -eq "Loading $($projectName) environment variables..." }
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 0
    }
}
