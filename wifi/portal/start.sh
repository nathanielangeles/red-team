#!/bin/bash

# WIP: Fake Wi-Fi Captive Portal Start Script.

# Colors:
W="\033[0;37m"
R="\033[0;31m"
G="\033[0;32m"
Y="\033[1;33m"
B="\033[1;34m"
BP="\033[1;35m"
NC="\033[0m"

# Start Apache service.
start_apache() {
    echo -e "${Y}[*] Starting Apache service..."
    sudo systemctl start apache2
    echo -e "${G}[+] Apache started."
}

# Enable Apache service on boot.
enable_apache() {
    echo -e "${Y}[*] Enabling Apache to start on boot..."
    sudo systemctl enable apache2
    echo -e "${G}[+] Apache enabled."
}

# Show status of Apache service.
apache_status() {
    systemctl status apache2 | grep Active
}

# Main function.
start_apache
enable_apache
apache_status