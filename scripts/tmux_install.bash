#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"
# Check if Tmux is installed
echo -e "\n<<< Checking if tmux is installed. >>>\n"
if ! command -v "tmux" &> /dev/null; then
  echo "tmux is not installed. Installing..."
  sudo apt install tmux -y
else
  echo "tmux is already installed."
fi

# Check if TMP is installed
echo -e "\n<<< Checking if TMP is installed. >>>\n"
if [ -d ~/.tmux/plugins/tpm ]; then
  echo "TPM is already installed."
else
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "TPM installed successfully."
fi

# Check if tmuxifier is installed
echo -e "\n<<< Checking if tmuxifier is installed. >>>\n"
if [ -d ~/.tmuxifier ]; then
  echo "tmuxifier is already installed."
else
  git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

  #define a marker for the block of text
  marker='# Tmuxifier initializer'

  # Add tmuxifier bin to PATH in .bashrc if it's not already there
  if ! grep -q "${marker}" ~/.bashrc; then
    echo -e "\n${marker}\nexport PATH=\$HOME/.tmuxifier/bin:\$PATH\"" >> ~/.bashrc
    echo -e '\neval "$(tmuxifier init -)"' >> ~/.bashrc
    echo -e "\n tmuxifier bin was added to PATH in .bashrc"
  else
    echo "tmuxifier bin is already in .bashrc"
  fi

  # Add tmuxifier bin to PATH in config.fish if its not already there
  if ! grep -q "${marker}" ~/.config/fish/config.fish; then
    echo -e "\n${marker}\nset -gx TMUXIFIER \"\$HOME/.tmuxifier/" >> ~/.config/fish/config.gish
    echo -e "\nset  PATH \"\$TMUXIFIER/bin\" \$PATH\"" >> ~/.config/fish/config.fish
    echo -e "\n tmuxifier bin was added to PATH in config.fish"
  else
    echo "tmuxifier bin is already in config.fish"
  fi
fi

echo -e "\n<<< tmux setup finished. >>>\n"

