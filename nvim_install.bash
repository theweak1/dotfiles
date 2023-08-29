#!/usr/bin/env bash

FONT_NAME="CaskaydiaCove NF"
FONT_ZIP="CascadiaCode.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/$FONT_ZIP"

NVCHAD_DIR="$HOME/.config/nvim"

echo "Running nvim_install.bash"

# Check if nvim is installed
if ! command -v "nvim" &> /dev/null; then
  echo "nvim is not installed. Installing..."
  sudo apt install libfuse2 -y
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod +x nvim.appimage
  sudo mv nvim.appimage /usr/bin/nvim
else
  echo "nvim is already installed."
fi

# Check if required dependencies are installed
if ! command -v "clang" &> /dev/null || ! command -v "unzip" &> /dev/null; then
  echo "Installing dependencies..."
  sudo apt install clang unzip -y
fi

# Check if font is installed
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

# Check if NVChad is already installed
if [ -d "$NVCHAD_DIR" ]; then
  echo "NVChad is already installed."
else
  echo "Installing NVChad..."
  git clone https://github.com/NvChad/NvChad "$NVCHAD_DIR" --depth 1
  echo "NVChad installed successfully."
fi

echo "nvim_install.bash finished."

