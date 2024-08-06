#!/bin/bash
location="Cologne"

case $1 in
    -n)
        weather=$(curl -s "wttr.in/$location?format=%c%C\n%t(%f)\t%w")
        notify-send "Weather" "$weather"
        #echo -e "$weather" | yad --text-info --no-buttons --geometry=500x100-200+50 --justify=center --title="Weather" --fontname="FiraCode 24"
        ;;
    -f)
        bspc rule -a kitty -o state=floating rectangle=1280x720+300+200
        kitty sh -c "w3m wttr.in/$location"
        #w3m -dump wttr.in/$location | yad --text-info --geometry=1010x800 --title="Weather"
        ;;
    -t) # Get only the current temperature
        echo $(curl -s "wttr.in/$location?format=%t")
        ;;
    -i) # Get the weather condition emoji
        echo $(curl -s "wttr.in/$location?format=%c")
        ;;
    -m) # Print icon and temperature
        msg=$(curl -s "wttr.in/$location?format=%c+%t")
        echo $msg | sed -E -n 's/([^ ]+) +([-+][0-9]+)°C.*/\1\2/p'
        ;;
esac
