. "$PSScriptRoot\util\install.ps1"
. "$PSScriptRoot\util\shell.ps1"

Choco-Install nvm

# Install useful node versions with nvm. Not on my path yet.
# TODO Catch errors.
Push-Location -path C:\ProgramData\nvm
$Env:NVM_HOME = "C:\ProgramData\nvm"
Run-Command-Or-Fail ".\nvm.exe install latest"
Run-Command-Or-Fail ".\nvm.exe install v7.9.0" # latest, atm
Run-Command-Or-Fail ".\nvm.exe install v6.10"  # latest LTS, atm
Run-Command-Or-Fail ".\nvm.exe use v7.9.0"
Pop-Location

# Version 6.10.0 doesn't install with node.exe, it installs with node64.exe for some reason. Make node.exe a symlink to it.
New-Item -Path C:\ProgramData\nvm\v6.10.0\node.exe -ItemType SymbolicLink -Value C:\ProgramData\nvm\v6.10.0\node64.exe

# nvm is updating the path, but not for this process, so we nede to point directly
# to the npm that nvm setup.
Choco-Install jq # JSON CLI tool

Write-Host "Installing npm package 'json'..."
$proc = Start-Process "C:\Program Files\nodejs\npm.cmd" -ArgumentList ("install", "--global", "json") -Wait -NoNewWindow -PassThru # Another JSON CLI tool
If ($proc.ExitCode -ne 0)
{
    $exitCode = $proc.ExitCode
    throw "Installation of npm package 'json' failed with exit code $exitCode."
}
Write-Host "...done"
