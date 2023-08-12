#!/bin/bash
# Needs sudo chmod a+x for $BrCur (or) run as sudo
# Might require an udev rule to prevent the permissions getting revoked
BrPath='/sys/class/backlight/intel_backlight/'
BrCur=`cat ${BrPath}brightness`
BrMax=`cat ${BrPath}max_brightness`
BrMin=$(( (BrMax + (100 - 1)) / 100))   # 100th max-brightness, rounded up to nearest integer
Steps=20                                # No. of steps from min to max.
BrStep=$(( (BrMax - BrMin) / Steps))

function percentage () {
    percent=$(($BrCur*100/$BrMax))
    echo "$percent"
}

if [ "$1" = "-h" ]; then
    echo "Usage: $0 [-g|-i|-d|-h]"
    echo "  -g    : Show graphical interface"
    echo "  -p    : Show current value as percentage"
    echo "  -i    : Increase brightness by one step"
    echo "  -d    : Decrease brightness by one step"
    echo "  -h    : Show this help message"
elif [ "$1" = "-i" ]; then
  BrNew=$(( BrCur + BrStep ))
  if [ $BrNew -gt $BrMax ]; then
    BrNew=$BrMax
  fi
  echo $BrNew > ${BrPath}brightness
  polybar-msg hook ipc-brightness 1
elif [ "$1" = "-d" ]; then
  BrNew=$(( BrCur - BrStep ))
  if [ $BrNew -lt $BrMin ]; then
    BrNew=$BrMin
  fi
  echo $BrNew > ${BrPath}brightness
  polybar-msg hook ipc-brightness 1
elif [ "$1" = "-g" ]; then
  yad --scale --min-value $BrMin --max-value $BrMax --value $BrCur \
      --step $BrStep \
      --print-partial --hide-value --title 'Set brightness' \
      --geometry=200x40-200+30 --fixed --sticky \
      --on-top --no-buttons \
      --close-on-unfocus| while read BrNew
                    do
                        echo "$BrNew" > ${BrPath}brightness
                        polybar-msg hook ipc-brightness 1
                    done
else
    percentage
fi
