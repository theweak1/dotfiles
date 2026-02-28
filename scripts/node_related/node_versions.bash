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


#install node latest version
ech "\n ${YELLOW} <<< Installing node LTS  >>> ${NC} \n"
n i lts

ech "\n ${YELLOW} <<< Installing node 19.9.0  >>> ${NC} \n"
n i 19

ech "\n ${YELLOW} << setting up to use node LTS  >>> ${NC} \n"
n lts

ech "\n ${YELLOW} <<< node version installed finished. >>>${NC} \n"
