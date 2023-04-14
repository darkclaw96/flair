#!/bin/bash

# Set folder path for message collection
folder_path="$HOME/.config/hello-messages"

# Select a random file from folder
random_file=$(ls $folder_path | shuf -n 1)

# Select a random message from selected file
random_message=$(grep -v '^$' "$folder_path/$random_file" | shuf -n 1)

# Select a random color for the message
colors=$(tput colors)
if [[ $colors -ge 16 ]]; then
    random_color=$((0 + RANDOM % 16))
else
    random_color=9
fi

echo -e "\n\t$(tput setaf $random_color)${random_message}$(tput sgr0)\n"
