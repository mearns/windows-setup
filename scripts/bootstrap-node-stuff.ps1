
choco install -y nvm
choco install -y jq # JSON CLI tool

# Install useful node versions with nvm
nvm install latest
nvm install v7.9.0 # Common
nvm install v6.10  # LTS
nvm use v7.9.0

npm install --global json # Another JSON CLI tool
