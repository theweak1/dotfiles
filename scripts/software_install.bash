#!/usr/bin/env bash

echo -e "\n<<< Starting $0 >>>\n"

# Check if bat is installed
echo -e "\n<<< Checking if bat is installed. >>>\n"
if ! command -v "bat" &>/dev/null; then
  echo "bat is not installed. Installing..."
  BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

  wget -O  bat_amd64.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-musl_${BAT_VERSION}_amd64.deb"

  sudo dpkg -i bat_amd64.deb
  rm bat_amd64.deb
else
  # Get the latest version from GitHub
  BAT_VERSION=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

  # Get the version installed on the machine
  INSTALLED_VERSION=$(bat --version | awk '{print $2}')

  # Compare the two versions
  if [ "$BAT_VERSION" == "$INSTALLED_VERSION" ]; then
    echo "You have the latest version of bat installed."
  else
    echo "A newer version of bat is available. Latest version: $BAT_VERSION, Installed version: $INSTALLED_VERSION"

    # Ask the user if they want to update with "yes" as the default option
    read -p "Do you want to update to the latest version? (Y/n) " choice

    case "$choice" in
    n | N)
      echo "Update cancelled."
      ;;
    y | Y | "")
      # Update the software
      echo "Updating to the latest version..."
      wget -O bat_amd64.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat-musl_${BAT_VERSION}_amd64.deb"

      sudo dpkg -i bat_amd64.deb
      rm bat_amd64.deb
      ;;
    *)
      echo "Invalid choice."
      ;;
    esac
  fi
fi

# Check if pip3 is installed
echo -e "\n<<< Checking if pip3 is installed. >>>\n"
if ! command -v "pip3" &>/dev/null; then
  echo "pip3 is not installed. Installing..."
  sudo apt install python3-pip -y
else
  echo "pip3 is already installed."
fi

# Check if exa is already installed
echo -e "\n<<< Checking if exa is installed. >>>\n"
if command -v "exa" &>/dev/null; then
  echo "exa is already installed."
else
  echo "exa is not installed. Attempting to install with apt..."

  # Try to install exa using apt
  if sudo apt install exa -y; then
    echo "exa is installed via apt."
  else
    echo "exa cannot be installed with apt. Proceeding with Cargo installation..."

    # Check if Rust and Cargo are installed
    if ! command -v "cargo" &>/dev/null; then
      echo "Installing Rust and Cargo..."
      sudo apt update
      sudo apt install rustc cargo -y
    fi

    # Install exa using Cargo
    echo "Installing exa..."
    cargo install exa

    # Add Cargo bin directory to PATH (if not already added)
    if ! grep -q "$HOME/.cargo/bin" "$HOME/.bashrc"; then
      echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>"$HOME/.bashrc"
      source "$HOME/.bashrc"
    fi
  fi
fi

# Check if tree is installed
echo -e "\n<<< Checking if tree is installed. >>>\n"
if ! command -v "tree" &>/dev/null; then
  echo "tree is not installed. Installing..."
  sudo apt install tree -y
else
  echo "tree is already installed."
fi

# Check if fzf is installed
echo -e "\n<<< Checking if fzf is installed. >>>\n"
if ! command -v "fzf" &> /dev/null; then
  echo "fzf is not installed. Installing..."
  sudo apt install fzf -y
else
  echo "fzf is already installed."
fi

# Check if go is installed
echo -e "\n<<< Checking if go is installed. >>>\n"
if ! command -v "go" &> /dev/null; then
  echo "go is not installed. Installing..."

  go_version="1.21.3"  # Update this to the latest version
  download_url="https://golang.org/dl/go${go_version}.linux-amd64.tar.gz"

  # Download and install Go
  wget $download_url -O /tmp/go.tar.gz
  sudo tar -C /usr/local -xzf /tmp/go.tar.gz

else
  echo "go is already installed."
fi

# Check if shellcheck is installed
echo -e "\n<<< Checking if shellcheck is installed. >>>\n"
if ! command -v "shellcheck" &> /dev/null; then
  echo "shellcheck is not installed. Installing..."
  sudo apt install shellcheck -y
else
  echo "shellcheck is already installed."
fi

# Check if gpt4readability is installed
echo -e "\n<<< Checking if gpt4readability is installed. >>> \n"
if ! command -v "gpt4readability" &>/dev/null; then
  echo "gpt4readability is not installed. Installing..."
  pip install GPT4Readability==0.1.4
else
  echo "gpt4readability is already installed."
fi

echo -e "\n<<< software install finished. >>>\n"
