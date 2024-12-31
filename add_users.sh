#!/bin/bash

:<<'FILE_INFO'

Title:	Add users to ec2
-----------------------------------
Author: Sarath Sontam
Date: 	2024-12-20
-----------------------------------

FILE_INFO

source /home/ubuntu/shell_scripts/log.sh

# Function to prompt for input and validate it
get_input() {
    local prompt="$1"
    local var
    while true; do
        read -p "$prompt" var
        if [[ -n "$var" ]]; then
            echo "$var"
            break
        else
            echo "Input cannot be empty. Please try again."
        fi
    done
}

# Prompt for details
username=$(get_input "Enter the username: ")
homedir=$(get_input "Enter the home directory (e.g., /home/$username): ")
shelltype=$(get_input "Enter the shell type (e.g., /bin/bash): ")
grep -qx $shelltype /etc/shells
if [[ $?=1 ]]
then
	shelltype="/bin/bash"
	log_message "$shelltype not exists in /etc/shells, resetting value to default value /bin/bash"
fi
comment=$(get_input "Enter a comment for the user: ")

# Confirm the details
echo -e "\nDetails provided:\nUsername: $username\nUser ID: $userid\nHome Directory: $homedir\nShell Type: $shelltype\nComment: $comment"
read -p "Are these details correct? (y/n): " confirm
if [[ "$confirm" != "y" ]]; then
    echo "Exiting script. Please re-run to add a user."
    exit 1
fi

# Create the user
sudo useradd -d "$homedir" -s "$shelltype" -c "$comment" "$username"

# Check if the user was created successfully
if [[ $? -eq 0 ]]; then
    echo "User $username has been successfully created."
    log_message "User $username has been successfully created."
else
    echo "Failed to create user. Please check the inputs and try again."
    log_message "Failed to create user. Please check the inputs and try again"
fi
