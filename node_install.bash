#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

# Node versions are managed with `n`, which is can be installed using
# the following command `curl -L https://bit.ly/n-install | N_PREFIX=$HOME/.n bash -s  -- -yqn`
# See config.fish for N_PREFIX variable and addition to PATH.

if ! command -v "node" &> /dev/null; then
  echo "Installing Node & NPM with n..."
  curl -L https://bit.ly/n-install | N_PREFIX=$HOME/.n bash -s  -- -yqn
else
  echo "node $(node --version) & NPM $(npm --version) already installed."
fi


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

echo "Global NPM Packages Installed:"
npm list --global --depth=0
