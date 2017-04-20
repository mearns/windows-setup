. "$PSScriptRoot\util\install.ps1"
. "$PSScriptRoot\util\env-vars.ps1"

Choco-Install "atom"

$atomBinPath = "$Env:LOCALAPPDATA\atom\bin"
Ensure-On-Path -Element $atomBinPath -EnvType "User"

# Install Atom packages
# FIXME: This doesn't seem to be working from the same run that installs atom.
Apm-Install -Package docblockr
Apm-Install -Package editorconfig
Apm-Install -Package highlight-selected
Apm-Install -Package language-javascript-jsx
Apm-Install -Package language-markdown
Apm-Install -Package linter
Apm-Install -Package linter-eslint
Apm-Install -Package linter-markdown
Apm-Install -Package minimap
Apm-Install -Package revert-buffer

# Remove some packages I don't like, that some other setup scripts put there. (grumpycat)
Apm-Uninstall -Package jsformat

