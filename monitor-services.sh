#!/usr/bin/env bash

# Function to check if a PID is running
is_pid_running() {
    kill -0 $1 2>/dev/null
}

# Folder containing the PID files
pid_folder="/seafile/pids"

# Check interval in seconds
check_interval=5

while sleep "$check_interval"; do
    # Check all files in the folder
    for pid_file in "$pid_folder"/*; do
        if [ -f "$pid_file" ]; then
            pid=$(cat "$pid_file")
            # Check if the PID is still running
            if ! is_pid_running $pid; then
                echo "The PID from the file $pid_file no longer exists. Exiting the script."
                exit 1
            fi
        fi
    done

    # Add optional additional commands for the loop here
done
