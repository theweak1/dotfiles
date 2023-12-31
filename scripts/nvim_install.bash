#!/usr/bin/env bash

FONT_NAME="CaskaydiaCove NF"
FONT_ZIP="CascadiaCode.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/$FONT_ZIP"

echo -e "\n<<< Running $0 >>>\n"

# Check if nvim is installed
echo -e "\n<<< Checking if nvim is installed. >>>\n"

if command -v "nvim" &> /dev/null; then
    echo "nvim is already installed."
    # Get installed version of nvim
    installed_version=$(nvim --version | head -n 1 | grep -Po '\d+\.\d+\.\d+')
    # Get the latest stable version of nvim from GitHub API
    latest_version=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | jq -r '.body' | grep -Po 'NVIM v\K[\d.]+')
    echo "Installed version: $installed_version"
    echo "Latest stable version: $latest_version"
    if [ "$installed_version" != "$latest_version" ]; then
        read -p "A newer version of nvim is available. Update? (y/n): " update_choice
        if [ "$update_choice" == "y" ]; then
            echo "Updating nvim to the latest version..."
            sudo apt install libfuse2 -y
            wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
            chmod +x nvim.appimage
            sudo mv nvim.appimage /usr/bin/nvim
        fi
    fi
else
    echo "nvim is not installed. Installing..."
    sudo apt install libfuse2 -y
    wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod +x nvim.appimage
    sudo mv nvim.appimage /usr/bin/nvim
fi




# Check if required dependencies are installed
echo -e "\n<<< Checking if dependencies are installed. >>>\n"
if ! command -v "clang" &> /dev/null || ! command -v "unzip" &> /dev/null; then
  echo "Installing dependencies..."
  sudo apt install clang unzip -y
fi

# Check if font is installed
echo -e "\n<<< Checking if the font required is installed. >>>\n"
if fc-list | grep -i "$FONT_NAME" &> /dev/null; then
  echo "Font $FONT_NAME is already installed."
else
  echo "Font $FONT_NAME is not installed. Downloading and installing..."

  # Create fonts directory if it doesn't exist
  FONT_DIR="/usr/share/fonts/$FONT_NAME"
  sudo mkdir -p "$FONT_DIR"

  # Download and unzip the font
  DOWNLOAD_DIR="$HOME/Downloads"
 sudo mkdir -p "$DOWNLOAD_DIR"
  wget -P "$DOWNLOAD_DIR" "$FONT_URL"
  sudo unzip "$DOWNLOAD_DIR/$FONT_ZIP" -d "$FONT_DIR"

  # Update font cache
  fc-cache -f -v

  echo "Font $FONT_NAME installed successfully."
fi

echo -e "\n<<< nvim setup finished. >>>\n"

