function Load-Env-Vars {
    Write-Host "Loading prosciutto environment variables..."
    $varsFilePath = Get-Vars-File -Project "prosciutto"
    $vars = Read-Vars -Path $varsFilePath
    foreach ($key in $vars.Keys) {
        $val = $vars.$key
        Set-Var-In-Dev-Environment -Key $key -Value $val
        Write-Host "Added $($key) = $($val)"
    }
}

function Read-Vars([string] $Path) {
    $vars = @{}
    Get-Content $path | ForEach-Object {$key,$value = $_.Split("="); $vars.Add($key, $value) }
    $vars
}

function Get-Vars-File([string] $Project) {
    Join-Path -Path (Get-Dir -Project $Project) -ChildPath "env.vars"
}

function Set-Var-In-Dev-Environment([string] $Key, [string] $Value) {
    [System.Environment]::SetEnvironmentVariable($Key, $Value, "User")
}

function Get-Dir([string] $Project) {
    $PSScriptRoot
}

Load-Env-Vars
