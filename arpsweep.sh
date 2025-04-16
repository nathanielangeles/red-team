#!/bin/bash

# ARP Sweep Script using netdiscover

# Description:
# ARP Request: "Who has this IP?"
# ARP Reply: "Me! Here’s my MAC."
# ARP Scan: Systematically ask everyone on the network, "Do you exist?"

# Colors
W="\033[0;37m"
R="\033[0;31m"
G="\033[0;32m"
Y="\033[1;33m"
B="\033[1;34m"
BP="\033[1;35m"
NC="\033[0m"

# Configuration
COUNT=100 # Number of ARP requests to send

# Root check
if_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${R}[*] This script must be run as root."
        exit 1
    fi
}

# Display banner
banner() {
    echo -e "${BP}\t  ARP Sweep Script${W}"
}

arp_sweep_script() {
    # Display available interfaces and their IP ranges
    printf "+-----------+---------------------+\n"
    printf "| Interface | IP/Range            |\n"
    printf "+-----------+---------------------+\n"
    ip -4 -o addr show | awk '{printf "| %-9s | %-19s |\n", $2, $4}'
    printf "+-----------+---------------------+\n"
    echo

    # Ask for user input
    read -p "[*] Enter interface to use: " user_iface

    # Get default IP range from selected interface
    def_range=$(ip -4 -o addr show "$user_iface" | awk '{print $4}')
    read -p "[*] Enter IP range (Default: $def_range): " user_range
    user_range="${user_range:-$def_range}"

    # Run ARP scan with netdiscover
    echo -e "\n[*] Scanning on $user_iface with range $user_range..."
    netdiscover -i "$user_iface" -r "$user_range" -c "$COUNT" -PN
}

# Call funtions
main() {
    if_root
    banner
    arp_sweep_script
}

# Run
main
