#!/usr/bin/env bash

# Function to check if a PID is running
is_pid_running() {
    kill -0 $1 2>/dev/null
}

# Folder containing the PID files
pid_folder="/seafile/pids"

# Check interval in seconds
check_interval=5

# Array to store the existing PIDs
declare -a pid_array

while sleep "$check_interval"; do
    # Update the array with the current PIDs
    for pid_file in "$pid_folder"/*; do
        if [ -f "$pid_file" ]; then
            pid=$(cat "$pid_file")
            # Check if the PID is already in the array before adding it
            if ! [[ " ${pid_array[@]} " =~ " $pid " ]]; then
                pid_array+=("$pid")
            fi
        fi
    done

    # Check if all PIDs in the array are still running
    for pid in "${pid_array[@]}"; do
        if ! is_pid_running $pid; then
            echo "The PID $pid no longer exists. Exiting the script."
            exit 1
        fi
    done
done
