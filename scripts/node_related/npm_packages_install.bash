#!/usr/bin/env bash

# Color definitions
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[0;31m"
NC="\033[0m" # No Color

ech() {
    echo -e "$@"
}

ech "\n ${YELLOW} <<< Running $0 >>> ${NC} \n"

ech "\n ${YELLOW} <<< Installing Global NPM packages >>> ${NC} SSS\n"

# Function to install a global npm package if it's not already installed
install_global_package() {
    local package_name="$1"
    if ! npm ls -g "$package_name" &> /dev/null; then
        ech "Installing $package_name..."
        npm install --global "$package_name".
        
        ech "${GREEN} $package_name installed successfully. ${NC} \n"
    else
        ech "${GREEN} $package_name is already installed. ${NC}"
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
install_global_package "tree-sitter-cli"

ech "Global NPM Packages Installed:"
npm list --global --depth=0

ech "\n ${YELLOW} <<< global NPM packages installment finished. >>> ${NC} \n"
