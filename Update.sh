#!/bin/bash

# Function to check and update Pi-hole
update_pihole() {
    echo "Updating Pi-hole..."
    if pihole -g &> /dev/null; then
        echo "Pi-hole updated successfully."
        return 0
    else
        echo "Error: Failed to update Pi-hole."
        return 1
    fi
}

# Function to update the system
update_system() {
    echo "Updating system..."
    if sudo apt update && sudo apt upgrade -y; then
        echo "System updated successfully."
        return 0
    else
        echo "Error: Failed to update system."
        return 1
    fi
}

# Perform Pi-hole update
update_pihole

# Check if Pi-hole update was successful before updating the system
if [[ $? -eq 0 ]]; then
    update_system
fi
