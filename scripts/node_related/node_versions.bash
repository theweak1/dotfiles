#!/usr/bin/env bash
#
echo -e "\n<<< Running $0 >>> \n"

#install node latest version
echo -e "\n<<< Installing node LTS  >>> \n"
n i lts

echo -e "\n<<< Installing node 19.9.0  >>> \n"
n i 19

echo -e "\n<<< setting up to use node LTS  >>> \n"
n lts

echo -e "\n<<< node version installed finished. >>>\n"
