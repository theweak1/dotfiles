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

N_PREFIX="$HOME/.n"

# Node versions are managed with `n`, which can be installed using
# the following command `curl -L https://bit.ly/n-install | N_PREFIX=$USER_HOME/.n bash -s  -- -yqn`
# See config.fish for N_PREFIX variable and addition to PATH.
# The PATH configuration is already in your dotfiles config - no need to append.

if ! command -v "node" &> /dev/null; then
  ech "${RED} Node & NPM are not installed. Installing Node & NPM with n... ${NC}"
  curl -L https://bit.ly/n-install | N_PREFIX="$N_PREFIX" bash -s -- -yqn

  ech "${GREEN} node $(node --version) & NPM $(npm --version) installed successfully. ${NC} \n"
  ech "${YELLOW}Note: N_PREFIX configuration is already in your dotfiles config.fish${NC}"
else
  ech "${GREEN} node $(node --version) & NPM $(npm --version) already installed. ${NC} \n"
  ech "${YELLOW}Note: N_PREFIX configuration is already in your dotfiles config.fish${NC}"
fi

ech "\n ${YELLOW} <<< node setup finished. >>> ${NC} \n"
