. .\Functions.ps1

Write-Host "Loading $($args[0]) environment variables..."
Load-Env-Vars($args[0])