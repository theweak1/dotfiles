#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>>\n"

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

# Check if Flameshot is already installed by looking for the desktop entry
echo -e "\n<<< Checking if flameshot is installed. >>>\n"
if ! grep -q "flameshot" /usr/share/applications/*; then
    echo "flameshot is not installed. Installing..."

    # Update the list of available packages
    sudo apt-get update -y

    # Install Flameshot
    sudo apt-get install flameshot -y

else
    echo "Flameshot is already installed."
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

echo -e "\n<<< application setup finished. >>>\n"
