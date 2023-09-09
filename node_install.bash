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

# Install Global NPM Packages
npm install --global npm@latest
# Install and setup commitizen
npm install --global commitizen
npm install --global cz-conventional-changelog
#Install P(rocess) M(anager)2 [pm2]
npm install --global pm2
npm install --global typescript
npm install --global trash-cli

echo "Global NPM Packages Installed:"
npm list --global --depth=0
