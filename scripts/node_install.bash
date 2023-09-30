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
bash_lines="
$marker
export N_PREFIX=\"$HOME/.n\"
if [[ \":\$PATH:\" != *\":\$N_PREFIX/bin:\"* ]]; then
  export PATH=\"\$N_PREFIX/bin:\$PATH\"
fi
$marker
"

# Define the lines to be added to config.fish
fish_lines="
$marker
set -x N_PREFIX \"$HOME/.n\"; contains \"$N_PREFIX/bin\" \$PATH; or set -a PATH \"$N_PREFIX/bin\"
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
append_lines_if_not_present "$bash_lines" ~/.bashrc

# Add lines to config.fish
append_lines_if_not_present "$fish_lines" ~/.config/fish/config.fish


else
  echo "node $(node --version) & NPM $(npm --version) already installed."
fi

