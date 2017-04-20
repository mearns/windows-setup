$ErrorActionPreference = "Stop"

. "$PSScriptRoot\util\backups.ps1"
. "$PSScriptRoot\util\manual-work.ps1"

Initialize-Backup
Init-Manual-Steps

. "$PSScriptRoot\bootstrap-01.ps1"
. "$PSScriptRoot\bootstrap-1password-stuff.ps1"
. "$PSScriptRoot\bootstrap-brownbag-stuff.ps1"
. "$PSScriptRoot\bootstrap-docker-stuff.ps1"
. "$PSScriptRoot\bootstrap-java-stuff.ps1"
. "$PSScriptRoot\bootstrap-node-stuff.ps1"
. "$PSScriptRoot\bootstrap-ssh-stuff.ps1"
. "$PSScriptRoot\bootstrap-vim-stuff.ps1"

Write-Host "Installation Completed, check NEXT-STEPS.md for some manual steps you should perform now" -ForegroundColor green
