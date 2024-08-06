#!/bin/bash
# Needs sudo chmod a+x for $BrCur (or) run as sudo
# Might require an udev rule to prevent the permissions getting revoked
BrPath='/sys/class/backlight/intel_backlight/'
ls $BrPath 2> /dev/null || exit 0
BrCur=`cat ${BrPath}brightness`
BrMax=`cat ${BrPath}max_brightness`
BrMin=$(( (BrMax + (100 - 1)) / 100))   # 100th max-brightness, rounded up to nearest integer
Steps=20                                # No. of steps from min to max.
BrStep=$(( (BrMax - BrMin) / Steps))

updatebar() {
        polybar-msg action "#ipc-brightness.hook.0"
}

case $1 in
    -i)
        #Increase brightness
        BrNew=$(( BrCur + BrStep ))
        if [ $BrNew -gt $BrMax ]; then
            BrNew=$BrMax
        fi
        echo $BrNew > ${BrPath}brightness
        updatebar
        ;;
    -d)
        #Decrease brightness
        BrNew=$(( BrCur - BrStep ))
        if [ $BrNew -lt $BrMin ]; then
            BrNew=$BrMin
        fi
        echo $BrNew > ${BrPath}brightness
        updatebar
        ;;
    -g)
        yad --scale --min-value $BrMin --max-value $BrMax --value $BrCur \
            --step $BrStep \
            --print-partial --hide-value --title 'Set brightness' \
            --geometry=200x40-200+30 --fixed --sticky \
            --on-top --no-buttons \
            --close-on-unfocus| while read BrNew
                do
                    echo "$BrNew" > ${BrPath}brightness
                    updatebar
                done
       ;;
   -p)
       percent=$(($BrCur*100/$BrMax))
       echo "$percent"
       ;;
   *)
       echo "Usage: $0 [-g|-p|-i|-d|-h]"
       echo "  -g    : Show graphical interface"
       echo "  -p    : Show current value as percentage"
       echo "  -i    : Increase brightness by one step"
       echo "  -d    : Decrease brightness by one step"
       echo "  -h    : Show this help message"
       ;;
esac
