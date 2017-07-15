function Load-Env-Vars {
    [CmdletBinding(DefaultParameterSetName="Project")]
    param(
        [Parameter(Mandatory=$true, Position=0, ParameterSetName="Project",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="The project name")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Project)

    $varsFilePath = Get-Vars-File -Project $Project
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
    Join-Path -Path $PSScriptRoot -ChildPath "projects\$($Project)\"
}


