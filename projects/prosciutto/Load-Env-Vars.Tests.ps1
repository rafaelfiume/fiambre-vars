$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Load-Env-Vars" {
    $firstKey = "FIRST_ENV_VAR"
    $firstValue = "C:\the\first"
    $secondkey = "SECOND_ENV_VAR"
    $secondValue = "the_second"

    $projectPath = "C:\a\path\to\a\project"

    Mock Get-Vars-File { return $projectPath }
    Mock Read-Vars { return @{ $firstKey = $firstValue; $secondKey = $secondValue} }
    Mock Set-Var-In-Dev-Environment

    It "should set environment variables defined for a project" {
        Load-Env-Vars

        Assert-MockCalled Read-Vars -Scope It -Times 1 -ParameterFilter { $Path -eq $projectPath}

        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Key -eq $firstKey}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Value -eq $firstValue}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Key -eq $secondKey}
        Assert-MockCalled Set-Var-In-Dev-Environment -Scope It -Times 1 -ParameterFilter { $Value -eq $secondValue}
    }
}

Describe "Read-Vars" {
    It "should return as map the vars defined in a file" {
        $varsFile = "TestDrive:\env.vars"
        Add-Content $varsFile "FIRST_ENV_VAR=C:\the\first"
        Add-Content $varsFile "SECOND_ENV_VAR=the_second"

        $vars = Read-Vars -Path $varsFile

        $vars."FIRST_ENV_VAR" | Should BeExactly "C:\the\first"
        $vars."SECOND_ENV_VAR" | Should BeExactly "the_second"
    }
}

Describe "Get-Vars-File" {
    It "should return the path to the env.vars file of a project" {
        $project = "prosciutto"

        $pathToVarsFile = Get-Vars-File -Project $project

        $expectedPath = Join-Path -Path $PSScriptRoot -ChildPath "env.vars"
        $pathToVarsFile | Should be $expectedPath
    }
}