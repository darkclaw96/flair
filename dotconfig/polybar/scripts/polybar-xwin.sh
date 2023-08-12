#!/bin/bash

WM_NAME=$(xdotool getwindowfocus getwindowname)

if [ "$WM_NAME" != "LG3D" ]; then
	echo -e ${WM_NAME:0:$1}
else
	echo ""
fi
