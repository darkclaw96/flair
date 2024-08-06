#!/bin/bash
pkgls(){
    apt list --upgradable | grep -v Listing | cut -d/ -f1
}

upgrade(){
    kitty sh -c "sudo nala upgrade -y"
}

case "$1" in
    -p)
        # Use yad to display the list of updates and prompt for confirmation
        update_selection=$(echo -e "$(pkgls)" | yad --text-info \
            --title "Available Updates" \
            --width=300 --height=200 \
            --button="Update ($(pkgls|wc -l)):0" --button="Cancel:1")

        # Check if the "Update" button was clicked
        if [ "$?" -eq 0 ]; then
            upgrade
        fi
        ;;
    -u)
        upgrade
        ;;
esac

# Get package count

count=$(apt list --upgradable 2> /dev/null | grep -c upgradable)
echo -e "$count\n" > $HOME/.config/polybar/scripts/updates

polybar-msg action "#ipc-apt.hook.0"

# Show/hide module based on count
if [ $count -eq 0 ]; then
    polybar-msg action "#ipc-apt.module_hide" > /dev/null
else
    polybar-msg action "#ipc-apt.module_show" > /dev/null
fi
