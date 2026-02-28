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

# Run node related scripts
ech "${YELLOW} Running node related scripts... ${NC}"

# Run npm packages install if it exists
if [[ -f "$(dirname "$0")/node_related/node_versions.bash" ]]; then
    ech "${YELLOW} Running node version setup... ${NC}"
    "$(dirname "$0")/node_related/node_versions.bash"
else
    ech "${RED} node_versions.bash not found. ${NC}"
fi

# Run npm packages install if it exists
if [[ -f "$(dirname "$0")/node_related/npm_packages_install.bash" ]]; then
    ech "${YELLOW} Running npm packages install... ${NC}"
    "$(dirname "$0")/node_related/npm_packages_install.bash"
else
    ech "${RED} npm_packages_install.bash not found. ${NC}"
fi



ech "\n ${YELLOW} <<< node setup finished. >>> ${NC} \n"
