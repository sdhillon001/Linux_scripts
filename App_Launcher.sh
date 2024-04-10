#!/bin/bash

# Function to launch an application and handle errors
launch_app() {
    app_name="$1"
    app_command="$2"

    # Check if the application executable exists
    if ! command -v "$app_command" &> /dev/null; then
        echo "Error: $app_name executable not found. Skipping launch."
        return
    fi

    # Launch the application
    echo "Launching $app_name..."
    if $app_command &> /dev/null; then
        echo "$app_name launched successfully."
    else
        echo "Error: Failed to launch $app_name."
    fi
}

# List of applications to launch
applications=("Spotify:spotify" "Discord:discord" "Outlook:outlook")  # Format: "Application Name:Command"

# Iterate through the list and launch applications
for app_info in "${applications[@]}"; do
    IFS=':' read -r app_name app_command <<< "$app_info"
    launch_app "$app_name" "$app_command"
done
