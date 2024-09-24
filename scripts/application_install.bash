#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

#check if system is being run in WSL
if [[ $(grep microsoft /proc/version) ]];then
  echo "System is running in WSL, applicatons cannot be installed"
else

    # Check if Spotify is already installed by looking for the desktop entry
    if ! grep -q "spotify" /usr/share/applications/*; then

        # Import the Spotify repository GPG key
        curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
        echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

        # Update the list of available packages
        sudo apt-get update

        # Install Spotify
        sudo apt-get install spotify-client

      else
        echo "Spotify is already installed."
    fi

    # Check if ksnip is already installed by looking for the desktop entry
    echo -e "\n<<< Checking if ksnip is installed. >>>\n"
    if ! grep -q "ksnip" /usr/share/applications/*; then
      echo "ksnip is not installed. Installing..."

        # Update the list of available packages
        sudo apt-get update -y

        # Install Flameshot
        sudo apt-get install ksnip -y

      else
        echo "ksnip is already installed."
    fi

    # Check if Notion is already installed by looking for the desktop entry
    echo -e "\n<<< Checking if Notion is installed. >>>\n"
    if ! grep -q "Notion" /usr/share/applications/*; then
      echo "Notion is not installed. Installing..."

        # Update the list of available packages
        echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
        sudo apt update -y

        # Install Notion
        sudo apt install notion-app-enhanced -y

      else
        echo "Notion is already installed."
    fi

    #Check if Discord is already installed by looking for the desktop entry
    echo -e "\n<<< Checking if discord is installed. >>>\n"
    if ! grep -q "discord" /usr/share/applications/*; then
      echo "discord is not installed. Installing..."

      # Define the URL of the DEB package
      URL="https://dl.discordapp.net/apps/linux/0.0.42/discord-0.0.42.deb"

      # Download the DEB package
      wget -O discord.deb "$URL"

      # Install the DEB package
      sudo dpkg -i discord.deb

      # Fix any potential missing dependencies
      sudo apt-get install -f

      # Clean up
      rm discord.deb

    else
      echo "Discord is already installed."
    fi

    # Check if WhatsApp is already installed by looking for the desktop entry
    echo -e "\n<<< Checking if whatsapp is installed. >>>\n"
    if ! grep -q "whatsapp" /usr/share/applications/*; then
      echo "whatsapp is not installed. Installing..."

      # Define the URL of the DEB package
      URL="https://zerkc.gitlab.io/whatsdesk/whatsdesk_0.3.9_amd64.deb"

      # Download the DEB package
      wget -O whatsapp.deb "$URL"

      # Install the DEB package
      sudo dpkg -i whatsapp.deb

      # Fix any potential missing dependencies
      sudo apt-get install -f

      # Clean up
      rm whatsapp.deb

    else
      echo "WhatsApp is already installed."
    fi

    # Check if Backdrop is already installed
    echo -e "\n<<< Checking if backdrop is already installed. >>>\n"
    if ! command -v "backdrop" &>/dev/null; then
      echo "backdrop is not installed. Installing..."
      BACKDROP_VERSION=$(curl -s "https://api.github.com/repos/JanMichaelSE/backdrop/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')

      wget -O backdrop.tar.gz "https://github.com/JanMichaelSE/backdrop/releases/download/v${BACKDROP_VERSION}/backdrop-gnome-desktop-v${BACKDROP_VERSION}.linux-amd64.tar.gz"

      tar -xzf backdrop.tar.gz
      mkdir -p $HOME/.backdrop/bin
      mv backdrop $HOME/.backdrop/bin
      rm backdrop.tar.gz
    else
      echo "Backdrop is already installed."
    fi

    # Check if Brave browser is installed
    echo -e "\n<<< Checing if Brave browser is already installed. >>>\n"
    if ! command -v "brave-browser" &> /dev/null; then
      echo "Brave browser is not installed. Installing..."

      sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

      echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

      sudo apt update

      sudo apt install brave-browser -y
    else
      echo "Brave browser is already installed"
    fi
fi
    echo -e "\n<<< application setup finished. >>>\n"
