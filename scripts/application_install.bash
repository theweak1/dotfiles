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

#check if system is being run in WSL
if grep -qi microsoft /proc/version; then
    ech "${RED} System is running in WSL, applications cannot be installed. ${NC}"
    exit 0
fi

# Check if running in a desktop environment
if [[ -z "$XDG_CURRENT_DESKTOP" && -z "$DESKTOP_SESSION" && -z "$GNOME_DESKTOP_SESSION_ID" ]]; then
    ech "${RED} No desktop environment detected. Exiting. ${NC}"
    exit 0
fi

# Check if Spotify is already installed by looking for the desktop entry
ech "\n ${YELLOW} <<< Checking if Spotify is installed. >>> ${NC} \n"
if ! grep -q "spotify" /usr/share/applications/*; then
    ech "${RED} Spotify is not installed. Installing... ${NC}"
    
    # Import the Spotify repository GPG key
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    ech "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    
    # Update the list of available packages
    sudo apt-get update
    
    # Install Spotify
    sudo apt-get install spotify-client
    
    ech "${GREEN} spotify installed. ${NC}"
else
    ech "${GREEN} Spotify is already installed. ${NC} \n"
fi

# Check if Notion is already installed by looking for the desktop entry
ech "\n ${YELLOW} <<< Checking if Notion is installed. >>> ${NC} \n"
if ! grep -q "Notion" /usr/share/applications/*; then
    ech "${RED} Notion is not installed. Installing... ${NC}"
    
    # Update the list of available packages
    ech "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
    sudo apt update -y
    
    # Install Notion
    sudo apt install notion-app-enhanced -y
    
    ech "${GREEN} notion installed. ${NC}"
else
    ech "${GREEN} Notion is already installed. ${NC} \n"
fi

#Check if Discord is already installed by looking for the desktop entry
ech "\n ${YELLOW} <<< Checking if discord is installed. >>> ${NC} \n"
if ! grep -q "discord" /usr/share/applications/*; then
    ech "${RED} discord is not installed. Installing... ${NC}"
    
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
    
    ech "${GREEN} Discord installed. ${NC}"
else
    ech "${GREEN} Discord is already installed. ${NC} \n"
fi

# Check if WhatsApp is already installed by looking for the desktop entry
ech "\n${YELLOW} <<< Checking if whatsapp is installed. >>> ${NC} \n"
if ! grep -q "whatsapp" /usr/share/applications/*; then
    ech "${RED} whatsapp is not installed. Installing... ${NC}"
    
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
    
    ech "${GREEN} WhatsApp installed. ${NC}"
else
    ech "${GREEN} WhatsApp is already installed. ${NC} \n"
fi

# Check if Backdrop is already installed
ech "\n ${YELLOW} <<< Checking if backdrop is already installed. >>> ${NC} \n"
if ! command -v "backdrop" &>/dev/null; then
    ech "${RED} backdrop is not installed. Installing... ${NC}"
    BACKDROP_VERSION=$(curl -s "https://api.github.com/repos/JanMichaelSE/backdrop/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    
    wget -O backdrop.tar.gz "https://github.com/JanMichaelSE/backdrop/releases/download/v${BACKDROP_VERSION}/backdrop-gnome-desktop-v${BACKDROP_VERSION}.linux-amd64.tar.gz"
    
    tar -xzf backdrop.tar.gz
    mkdir -p $HOME/.backdrop/bin
    mv backdrop $HOME/.backdrop/bin
    rm backdrop.tar.gz
    
    ech "${GREEN} Backdrop installed. ${NC}"
else
    ech "${GREEN} Backdrop is already installed. ${NC}"
fi

# Check if Brave browser is installed
ech "\n ${YELLOW} <<< Checking if Brave browser is already installed. >>> ${NC} \n"
if ! command -v "brave-browser" &> /dev/null; then
    ech "${RED} Brave browser is not installed. Installing... ${NC}"
    
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    
    ech "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    
    sudo apt update
    
    sudo apt install brave-browser -y
    
    ech "${GREEN} Brave browser installed. ${NC}"
else
    ech "${GREEN} Brave browser is already installed ${NC}"
fi


ech "\n ${YELLOW} <<< application setup finished. >>> ${NC} \n"
