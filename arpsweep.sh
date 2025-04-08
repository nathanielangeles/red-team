#!/bin/bash

# ARP Sweep Script using netdiscover

# Description:
# ARP Request: "Who has this IP?"
# ARP Reply: "Me! Here’s my MAC."
# ARP Scan: Systematically ask everyone on the network, "Do you exist?"

# Root Check
if [[ $EUID -ne 0 ]]; then
    echo "[*] This script must be run as root."
    exit 1
fi

# Configuration
COUNT=100  # Number of ARP requests to send

# Display available interfaces and their IP ranges
echo "-- Available Interfaces and Ranges --"
ip -4 -o addr show | awk '{print $2, $4}'
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
