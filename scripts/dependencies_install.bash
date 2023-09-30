#!/bin/bash

apt update && apt upgrade -y

apt install -y sudo && 
    apt install -y git &&
    apt install -y unzip &&
    apt install -y wget &&
    apt install -y curl &&
    apt install -y python3 &&
    apt install -y pip &&
    apt install -y vim &&
    apt install -y fontconfig
