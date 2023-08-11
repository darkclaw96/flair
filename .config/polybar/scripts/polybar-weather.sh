#!/bin/bash

# Set the location
location=""

# Get the formatted weather information from wttr.in
weather=$(curl -s "wttr.in/$location?format=%c\n%C\n%t\n%w" -H "Accept-Language: en" --compressed)
#if [[ $weather !=~ "^[Unknown]*" ]]; then # regex check to see if response was good
    icon=$(echo "$weather" | sed -n 1p)
    condition=$(echo "$weather" | sed -n 2p)
    temperature=$(echo "$weather" | sed -n 3p)
    wind=$(echo "$weather" | sed -n 4p)
#else
#    echo ""
#fi

# Parse the command line arguments
while getopts ":sftim" opt; do
  case $opt in
    s)
        echo -e "$icon $condition\n$temperature\t$wind" | yad --text-info --no-buttons --geometry=500x100-200+50 --justify=center --title="Weather" --fontname="FiraCode 24" --close-on-unfocus
      ;;
    f)
        w3m -dump wttr.in/$location | yad --text-info --geometry=1010x800 --title="Weather"
      ;;
    t)
        # Get only the cuurent temperature
        echo "$temperature" | awk -F "°" '{print $1}'
      ;;
    i)
        # Get the weather condition emoji
        echo $icon
      ;;
    m)
        # Print icon and temperature
        temp=$(echo "$temperature" | awk -F "°" '{print $1}') # remove °C to save space
        echo -e "${icon:0:1}$temp"
      ;;
     esac
done
