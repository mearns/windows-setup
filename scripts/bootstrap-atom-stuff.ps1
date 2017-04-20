. "$PSScriptRoot\util\install.ps1"
. "$PSScriptRoot\util\env-vars.ps1"

Choco-Install "atom"

$atomBinPath = "$Env:LOCALAPPDATA\atom\bin"
Ensure-On-Path -Element $atomBinPath -EnvType "User"

# Ensure it's on the local path for executing.
$env:PATH = "$atomBinPath;$env:PATH"

# Install Atom packages
apm install docblocker
apm install editorconfig
apm install highlight-selected
apm install language-javascript-jsx
apm install language-markdown
apm install linter
apm install linter-eslint
apm install linter-markdown
apm install minimap
apm install revert-buffer
