Write-Host "Running Brian Mearns' Windows Setup..."

# Createdir for backups

. "$PSScriptRoot\util\resources.ps1"
. "$PSScriptRoot\util\env-vars.ps1"
. "$PSScriptRoot\util\install.ps1"

Initialize-Backup

# Installs chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install stuff
Choco-Install "atom"
Choco-Install "conemu"
Choco-Install "googlechrome"
Choco-Install "hg"
Choco-Install "ctags"
Choco-Install "python2"
Choco-Install "wget"
Choco-Install "inkscape"
Choco-Install "gimp"
Choco-Install "vagrant"
Choco-Install "graphicsmagick"

### Git
Choco-Install "git"
# Place GIT Bash's /usr/bin dir to the path
Ensure-At-Start-Of-Path -Element "C:\Program Files\Git\usr\bin"

# Copy git config
Install-Resource-File -ResourcePath "git\.gitconfig" -InstallPath "$HOME\.gitconfig" -name "gitconfig"
Install-Resource-File -ResourcePath "git\.gitignore-global" -InstallPath "$HOME\.gitignore-global" -name "gitignore-global"

### Mercurial
choco install -y hg
Install-Resource-File -ResourcePath "git\.gitconfig" -InstallPath "$HOME\.gitconfig" -name "gitconfig"
Install-Resource-File -ResourcePath "git\.gitignore-global" -InstallPath "$HOME\.gitignore-global" -name "gitignore-global"

### Bashy stuff

# Copy Bash Stuff
Install-Resource-File -ResourcePath "bash\.allbashrc" -InstallPath "$HOME\.allbashrc" -name "allbashrc"
Install-Resource-File -ResourcePath "bash\.inputrc" -InstallPath "$HOME\.inputrc" -name "inputrc"
Install-Resource-File -ResourcePath "bash\.bash_profile" -InstallPath "$HOME\.bash_profile" -name "bash_profile"
Install-Resource-File -ResourcePath "bash\.bashrc" -InstallPath "$HOME\.bashrc" -name "bashrc"
