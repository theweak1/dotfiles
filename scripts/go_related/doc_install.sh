#!/usr/bin/env bash

echo -e "\n<<< Running $0 >>> \n"

#install Go documentation
echo "Checking if go documentation is installed..."

if ! command -v "godoc" &> /dev/null; then
	echo "go documentation is not installed. Installing..."
	sudo apt install golang-golang-x-tools
	
	go install golang.org/x/tools/cmd/godoc@latest

	echo "go documentation installed."
else
	echo "go documentation is already installed."
fi

echo -e "\n<<< Go documentation installment finished >>> \n"
