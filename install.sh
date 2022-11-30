#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)


# Update packages list and update system
apt update
apt upgrade -y

# Set cron job to check for updates
echo "\n\tSetting up cron job for apt updates"
echo "#check for apt updates every 10 mins" >> $builddir/aptupd
echo "*/10 * * * * root apt update" >> $builddir/aptupd
cp $builddir/aptupd /etc/cron.d
if [ -f /etc/cron.d/aptupd ];
then
  echo -e "\tCron job created\n"
  rm $builddir/aptupd
else
  echo -e "\n\tCron job not created. Do it manually\n"
fi

# Installing Essential Programs 
apt install bspwm sxhkd kitty rofi polybar picom pcmanfm nitrogen htop lxpolkit x11-xserver-utils unzip yad wget pulseaudio pavucontrol vlc nala exa neofetch flameshot psmisc mangohud vim lxappearance papirus-icon-theme lxappearance fonts-noto-color-emoji -y

# Install brave-browser
git clone https://github.com/djoma98/debian-brave
cd debian-brave
chmod +x install.sh
./install.sh
cd $builddir
rm -rf debian-brave
