#!/bin/bash
status=$(playerctl status 2>/dev/null)

if [[ -n $status ]]; then
    if [ $status == "Playing" ]; then
        echo ""
    elif [ $status == "Paused" ]; then
        echo ""
    fi
else
    echo ""
fi
