Write-Host "Running Brian Mearns' Windows Setup..."

# Installs chocolatey
Write-Host "Installing chocolatey..."
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install stuff
choco install -y vim
choco install -y atom
choco install -y conemu
choco install -y googlechrome
choco install -y git
choco install -y jdk7
choco install -y jdk8
choco install -y ctags
choco install -y python2
choco install -y wget
# choco install unxutils    # Use git bash utils, instead, to avoid mixing things up.

# Clone Vimfiles
Write-Host "Cloneing Vimfiles..."
Set-Variable vimInstallClear -Value $TRUE
Set-Variable vimfilesDirectory -Value "$HOME\vimfiles"
If (Test-Path "$vimfilesDirectory")
{
    Write-Host "Vimfiles directory already exists. Get it out of the way before trying again. ($vimfilesDirectory)" -ForegroundColor Red
    Set-Variable vimInstallClear -Value $FALSE
}
if (Test-Path "$HOME\vim_rc")
{
    Write-Host "vim_rc directory already exists. Get it out of the way before trying again. ($HOME\vim_rc)" -ForegroundColor Red
    Set-Variable vimInstallClear -Value $FALSE
}

if (-Not ($vimInstallClear))
{
    Exit 1
}
git clone https://github.com/mearns/vimfiles.git "$vimfilesDirectory"
Push-Location -path "$vimfilesDirectory"
git submodule init
git submodule update
git remote set-url origin "git@github.com:mearns/vimfiles.git"
Pop-Location
Write-Host "Copying Vimrc Files..."
Copy-Item -Path $PSScriptRoot\..\resources\vim\vim_rc -Destination $HOME -Recurse
Copy-Item -Path $PSScriptRoot\..\resources\vim\.vimrc -Destination "$HOME"
Copy-Item -Path $PSScriptRoot\..\resources\vim\_vimrc -Destination "$HOME"
