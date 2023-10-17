#!/usr/bin/env bash

# Function to install a global npm package if it's not already installed
install_global_package() {
  local package_name="$1"
  if ! npm ls -g "$package_name" &> /dev/null; then
    echo "Installing $package_name..."
    npm install --global "$package_name"
  else
    echo "$package_name is already installed."
  fi
}

# Install Global NPM Packages with conditions
install_global_package "npm@latest"
install_global_package "commitizen"
install_global_package "cz-conventional-changelog"
install_global_package "pm2"
install_global_package "typescript"
install_global_package "trash-cli"
install_global_package "vercel"
install_global_package "eslint"
install_global_package "@johnnymorganz/stylua-bin"
install_global_package "json-server"

echo "Global NPM Packages Installed:"
npm list --global --depth=0
