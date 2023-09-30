#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

# Node versions are managed with `n`, which is can be installed using
# the following command `curl -L https://bit.ly/n-install | N_PREFIX=$HOME/.n bash -s  -- -yqn`
# See config.fish for N_PREFIX variable and addition to PATH.

if ! command -v "node" &> /dev/null; then
  echo "Installing Node & NPM with n..."
  curl -L https://bit.ly/n-install | N_PREFIX=$HOME/.n bash -s  -- -yqn

# This is needed for "n"
# Define a marker for the block of text
marker="# N_PREFIX block"

# Define the lines to be added to .bashrc
lines="
$marker
export N_PREFIX=\"$HOME/.n\"
if [[ \":\$PATH:\" != *\":\$N_PREFIX/bin:\"* ]]; then
    export PATH=\"\$N_PREFIX/bin:\$PATH\"
fi
$marker
"

# Check if the marker is already present in .bashrc, if not, append the lines
if ! grep -q "$marker" ~/.bashrc ; then
    echo "$lines" >> ~/.bashrc
    echo "Lines were added to .bashrc"
else
    echo "Lines are already present in .bashrc"
fi

else
  echo "node $(node --version) & NPM $(npm --version) already installed."
fi

