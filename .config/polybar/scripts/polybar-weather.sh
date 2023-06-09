#!/bin/bash

# Set the location
location="Cologne"

# Parse the command line arguments
while getopts ":sfti" opt; do
  case $opt in
    s)
      # Get the formatted weather information from wttr.in
      weather=$(curl -s "wttr.in/$location?format=%c\n%C\n%t\n%w" -H "Accept-Language: en" --compressed)
      icon=$(echo "$weather" | sed -n 1p)
      condition=$(echo "$weather" | sed -n 2p)
      temperature=$(echo "$weather" | sed -n 3p)
      wind=$(echo "$weather" | sed -n 4p)

      echo -e "$icon $condition\n$temperature\t$wind" | yad --text-info --no-buttons --geometry=200x40-200+30 --justify=center --title="Weather" --close-on-unfocus
      ;;
    f)
      w3m -dump wttr.in/$location |yad --text-info --no-buttons --geometry=1008x720 --title="Weather" --close-on-unfocus
      ;;
    t)
      # Get only the cuurent temperature
      curl -s "wttr.in/$location?format=%t" | awk '{print " " $1}'
      ;;
    i)
      # Get the weather condition emoji
      curl -s "wttr.in/$location?format=%c" | awk '{print " " $1}'
      ;;
  esac
done

