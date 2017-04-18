Write-Host "Running Brian Mearns' Windows Setup..."

# Createdir for backups

. "$PSScriptRoot\util\resources.ps1"
. "$PSScriptRoot\util\env-vars.ps1"

Initialize-Backup

# Installs chocolatey
Write-Host "Installing chocolatey..."
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install stuff
choco install -y atom
choco install -y conemu
choco install -y googlechrome
choco install -y git
choco install -y ctags
choco install -y python2
choco install -y wget
choco install -y inkscape
choco install -y gimp
choco install -y vagrant
#
## Place GIT Bash's /usr/bin dir to the path
Ensure-At-Start-Of-Path -Element "C:\Program Files\Git\usr\bin"
#
# Copy git config
Install-Resource-File -ResourcePath "git\.gitconfig" -InstallPath "$HOME\.gitconfig" -name "gitconfig"
Install-Resource-File -ResourcePath "git\.gitignore-global" -InstallPath "$HOME\.gitignore-global" -name "gitignore-global"
#
## Copy Bash Stuff
