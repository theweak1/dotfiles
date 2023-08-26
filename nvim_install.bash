#!/usr/bin/env bash

echo "Running nvim_install.bash"

if ! command -v "nvim" &> /dev/null; then
  echo "nvim is not installed. Installing..."
  sudo apt install libfuse2
  wget https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod +x nvim.appimage
  sudo mv nvim.appimage /usr/bin/nvim
else
  echo "nvim is already installed."
fi

echo "Installing NVChad..."

if ! command -v "clang" &> /dev/null || ! command -v "unzip" &> /dev/null; then
  echo "Install dependencies..."
  sudo apt install clang -y
  sudo apt install unzip -y
fi

echo "Copying NVChad"
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1

echo "Install Cascadia Font"

# Download and install font
font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/CascadiaCode.zip"
font_zip="CascadiaCode.zip"
font_folder="$HOME/.local/share/fonts"
font_target_folder="$font_folder/CaskaydiaCove NF"

echo "Creating font folder..."
mkdir -p "$font_target_folder"

echo "Downloading font..."
wget -O "$font_zip" "$font_url"

echo "Unzipping font..."
sudo unzip -o "$font_zip" -d "$font_target_folder"

echo "Cleaning up..."
rm "$font_zip"
echo "nvim_install.bash finished."
