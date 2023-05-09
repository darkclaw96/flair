#!/bin/bash

# Set the location
location="cologne"

# Parse the command line arguments
while getopts ":af" opt; do
  case $opt in
    a)
      format=false
      ;;
    f)
      format=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      format=true
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      format=true
      ;;
  esac
done

# If no flag is provided or an invalid flag is provided, print the unformatted weather information
if [ "$format" = false ]; then
  curl -s "wttr.in/$location"
else
  # Get the formatted weather information from wttr.in
  weather=$(curl -s "wttr.in/$location?format=%c\n%C\n%t\n%w" -H "Accept-Language: en" --compressed)

# Parse the formatted output using awk and extract the values of the desired fields
  icon=$(echo "$weather" | sed -n 1p)
  condition=$(echo "$weather" | sed -n 2p)
  temperature=$(echo "$weather" | sed -n 3p)
  wind=$(echo "$weather" | sed -n 4p)

  echo -e "$icon $condition $temperature $wind"
fi

