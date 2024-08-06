#!/bin/bash

winname=$(xdotool getwindowfocus getwindowname)

if [ "$winname" != "LG3D" ]; then
	echo $winname
	#echo -e ${winname:0:$1}
elif [ "$winname" == ""  ]; then
    echo ""
else
    echo "  ¯\_(ツ)_/¯  "
fi
