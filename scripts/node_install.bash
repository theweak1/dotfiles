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

echo -e "\n<<< node setup finished. >>>\n"
