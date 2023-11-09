#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

# Use whoami to get the current user and then find their home directory
USER=$(whoami)
USER_HOME=$(eval echo ~$USER)
N_PREFIX="$USER_HOME/.n"

# Node versions are managed with `n`, which can be installed using
# the following command `curl -L https://bit.ly/n-install | N_PREFIX=$USER_HOME/.n bash -s  -- -yqn`
# See config.fish for N_PREFIX variable and addition to PATH.

if ! command -v "node" &> /dev/null; then
  echo "Installing Node & NPM with n..."
  curl -L https://bit.ly/n-install | N_PREFIX="$N_PREFIX" bash -s -- -yqn

  # This is needed for "n"

  # Define a marker for the block of text
  marker="# N_PREFIX block"

  # Define the lines to be added to .bashrc
  bash_lines="
  $marker
  export N_PREFIX=\"$N_PREFIX\"
  if [[ \":\$PATH:\" != *\":\$N_PREFIX/bin:\"* ]]; then
    export PATH=\"\$N_PREFIX/bin:\$PATH\"
  fi
  $marker
  "

  # Define the lines to be added to config.fish
  fish_lines="
  $marker
  set -x N_PREFIX \"$N_PREFIX\"
  if not contains \"$N_PREFIX/bin\" \$PATH
    set -a PATH \"$N_PREFIX/bin\"
  end
  $marker
  "

  # Function to append lines to a file if the marker is not present
  append_lines_if_not_present() {
    local lines="$1"
    local file="$2"

    if ! grep -q "$marker" "$file"; then
      echo "$lines" >> "$file"
      echo "Lines were added to $file"
    else
      echo "Lines are already present in $file"
    fi
  }

  # Add lines to .bashrc
  append_lines_if_not_present "$bash_lines" "$USER_HOME/.bashrc"

  # Add lines to config.fish
  append_lines_if_not_present "$fish_lines" "$USER_HOME/.config/fish/config.fish"

else
  echo "node $(node --version) & NPM $(npm --version) already installed."
fi

echo -e "\n<<< node setup finished. >>>\n"

