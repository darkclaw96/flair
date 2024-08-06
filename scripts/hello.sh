#!/bin/bash

# Set folder path for message collection
folder_path="$HOME/.config/hello-messages"

# Select a random file from folder
random_file=$(ls $folder_path | shuf -n 1)

# Select a random message from selected file
random_message=$(grep -v '^$' "$folder_path/$random_file" | shuf -n 1)

# Select a random color for the message
random_fg=$((0 + RANDOM % 32))

echo -e "\n\t$(tput setaf $random_fg)${random_message}$(tput sgr0)\n"

