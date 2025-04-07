#!/bin/bash

# arpsweep

# Here's how it works:
# ARP Request: "Who has this IP?"
# ARP Reply: "Me! Here’s my MAC."
# ARP Scan: Systematically ask everyone on the network, "Do you exist?"

# Check if root
if [[ $EUID -ne 0 ]]; then
	echo -e "[*] You must be root to run this."
	exit 1
fi

# Displays all the available interfaces and range.
# It will use the interface's range as the value if user did not provide one.
# Change the COUNT value if you want.
COUNT=100 # Change this line.

echo -e "-- Interfaces and Range --"
av_int=$(ip -4 -o addr show | awk '{print $2, $4}')
echo "$av_int"

echo -ne "\n[*] Enter which interface to use: "
read user_iface

def_range=$(ip -4 -o addr show "$user_iface" | awk '{print $4}')
echo -ne "[*] Enter IP range (Default: $def_range): "
read user_range
user_range="${user_range:-$def_range}"

# Running active scan using netdiscover.
echo ""
sudo netdiscover -i "$user_iface" -r "$user_range" -c "$COUNT" -PN
