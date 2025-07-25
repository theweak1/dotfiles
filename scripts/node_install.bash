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

# Function to append lines to a file if the marker is not present
append_lines_if_not_present() {
  local lines="$1"
  local file="$2"
  local marker="# N_PREFIX block" # Moved the marker definition here for clarity
  if ! grep -q "$marker" "$file"; then
    ech "$lines" >> "$file"
    ech "${GREEN} Lines were added to "$file" ${NC}\n"
  else
    ech "${GREEN} Lines are already present in "$file" ${NC}\n"
  fi
}

# Node versions are managed with `n`, which can be installed using
# the following command `curl -L https://bit.ly/n-install | N_PREFIX=$USER_HOME/.n bash -s  -- -yqn`
# See config.fish for N_PREFIX variable and addition to PATH.

if ! command -v "node" &> /dev/null; then
  ech "${RED} Node & NPM are not installed. Installing Node & NPM with n... ${NC}"
  curl -L https://bit.ly/n-install | N_PREFIX="$N_PREFIX" bash -s -- -yqn

  # Define the lines to be added to .bashrc
  bash_lines="
  # N_PREFIX block
  export N_PREFIX=\"$HOME/.n\"
  if [[ \":\$PATH:\" != *\":\$HOME/.n/bin:\"* ]]; then
    export PATH=\"\$HOME/.n/bin:\$PATH\"
  fi
  # N_PREFIX block
  "

  # Define the lines to be added to config.fish
  fish_lines="
  # N_PREFIX block
  set -x N_PREFIX \"$HOME/.n\"
  if not contains \"$HOME/.n/bin\" \$PATH
    set -a PATH \"$HOME/.n/bin\"
  end
  # N_PREFIX block
  "

  # Add lines to .bashrc
  append_lines_if_not_present "$bash_lines" "$HOME/.bashrc"

  # Add lines to config.fish
  append_lines_if_not_present "$fish_lines" "$HOME/.config/fish/config.fish"

  ech "${GREEN} node $(node --version) & NPM $(npm --version) installed successfully. ${NC} \n"
else
  ech "${GREEN} node $(node --version) & NPM $(npm --version) already installed. ${NC} \n"

  # Add lines to .bashrc
  append_lines_if_not_present "$bash_lines" "$HOME/.bashrc"

  # Add lines to config.fish
  append_lines_if_not_present "$fish_lines" "$HOME/.config/fish/config.fish"

fi

ech "\n ${YELLOW} <<< node setup finished. >>> ${NC} \n"

