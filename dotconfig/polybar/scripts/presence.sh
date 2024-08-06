#!/bin/bash

# Define an associative array mapping IP addresses to letters
declare -A ip_list
ip_list[192.168.178.20]=""
ip_list[192.168.178.40]=""
ip_list[192.168.178.84]=""
ip_list[192.168.178.90]=" "
ip_list[192.168.178.91]=" "

# Initialize the variable to store the results
active_ips=""

# Loop through the IP addresses
for ip in "${!ip_list[@]}"; do
  if ping -c 1 "$ip" > /dev/null; then
    active_ips+="${ip_list[$ip]}"  # Append the corresponding letter
  fi
done

echo $active_ips
