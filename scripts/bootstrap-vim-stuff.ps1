. "$PSScriptRoot\util\env-vars.ps1"
. "$PSScriptRoot\util\resources.ps1"

choco install -y vim

# Clone Vimfiles
Write-Host "Cloneing Vimfiles..."
$vimfilesDirectory = "$HOME\vimfiles"
Backup-Dir -Path $vimfilesDirectory -Name "vimfiles"

If (Test-Path $vimfilesDirectory)
{
  Remove-Item -Recurse -Force $vimfilesDirectory
}
git clone https://github.com/mearns/vimfiles.git $vimfilesDirectory
If ($LastExitCode -ne 0) {
    throw "Git command failed with exit code $LastExitCode."
}

Push-Location -path $vimfilesDirectory
git submodule init
If ($LastExitCode -ne 0) {
    throw "Git command failed with exit code $LastExitCode."
}
git submodule update
If ($LastExitCode -ne 0) {
    throw "Git command failed with exit code $LastExitCode."
}
git remote set-url origin "git@github.com:mearns/vimfiles.git"
If ($LastExitCode -ne 0) {
    throw "Git command failed with exit code $LastExitCode."
}
Pop-Location

Write-Host "Copying Vimrc Files..."
If (-Not (Test-Path "$HOME\vim_rc"))
{
  New-Item "$HOME\vim_rc" -Type directory
}
Install-Resource-File -ResourcePath "vim\vim_rc\_vimrc" -InstallPath "$HOME\vim_rc\_vimrc" -Name "Common VimRC"
Install-Resource-File -ResourcePath "vim\.vimrc" -InstallPath "$HOME\.vimrc", -Name ".vimrc"
Install-Resource-File -ResourcePath "vim\_vimrc" -InstallPath "$HOME\_vimrc", -Name "_vimrc"

# Set as default editor for things that look
Set-Env-Var -Name "EDITOR" -Value "gvim"
Set-Env-Var -Name "VISUAL" -Value "gvim"
