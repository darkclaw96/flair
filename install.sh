#!/bin/bash

# Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)
fontdir="$HOME/.local/share/fonts"

# Update packages list and update system
apt update
apt upgrade -y

# Making .config and Moving config files and background to Pictures
cd $builddir
mkdir -p /home/$username/Pictures
cp .Xresources /home/$username
cp .Xnord /home/$username
cp -R dotconfig/* /home/$username/.config/
mv user-dirs.dirs /home/$username/.config
chown -R $username:$username /home/$username

# Set cron job to check for updates
echo "\n\tSetting up cron job for apt updates"
echo "#check for apt updates every 4 hrs" >> $builddir/aptupd
echo "* */4 * * * root apt update" >> $builddir/aptupd
cp $builddir/aptupd /etc/cron.d
if [ -f /etc/cron.d/aptupd ];
then
  echo -e "\tCron job created\n"
  rm $builddir/aptupd
else
  echo -e "\n\tCron job not created. Do it manually\n"
fi

# Installing Essential Programs
apt install bspwm sxhkd kitty xdo xdotool xserver-xorg-input-libinput xsecurelock rofi polybar picom \
            network-manager-gnome nitrogen pcmanfm unrar 7zip timeshift suckless-tools caffeine redshift-gtk \
            pavucontrol vlc pipewire easyeffects playerctl font-manager \
            lm-sensors htop lxpolkit x11-xserver-utils unzip wget \
            nala exa neofetch flameshot psmisc mangohud vim papirus-icon-theme \
            lxappearance yad w3m dunst libnotify-bin build-essential libpam0g-dev libxcb-xkb-dev -y

# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Installing fonts
cd $builddir
apt install fonts-font-awesome fonts-noto-color-emoji fonts-ipaexfont fonts-taml
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /home/$username/.fonts

echo -e "\n[*] Installing fonts..."
[[ ! -d "$fontdir" ]] && mkdir -p "$fontdir"
cp -rf $builddir/fonts/* "$fontdir"

# Reloading Font
fc-cache -vf
# Removing zip Files
rm ./FiraCode.zip

# Install Nordzy cursor
echo -e "\nInstalling Nordzy cursors... "
git clone https://github.com/alvatip/Nordzy-cursors
cd Nordzy-cursors
./install.sh
cd $builddir
rm -rf Nordzy-cursors

# Install brave-browser
echo -e "\nInstalling brave browser"
git clone https://github.com/djoma98/debian-brave
cd debian-brave
chmod +x install.sh
./install.sh
cd $builddir
rm -rf debian-brave

#
# Some source installs
#
mkdir $HOME/sourceinstalls

# Install bsp-layouts
curl https://raw.githubusercontent.com/phenax/bsp-layout/master/install.sh | bash -;

# Install ly loginmanager
cd $HOME/sourceinstalls
apt install build-essential libpam0g-dev libxcb-xkb-dev
wget https://ziglang.org/download/0.12.0/zig-linux-x86_64-0.12.0.tar.xz
tar xf zig-linux-x86_64-0.12.0.tar.xz
$ZIG=$HOME/sourceinstalls/zig-linux-x86_64-0.12.0/zig
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly
$ZIG build
$ZIG build installsystemd
systemctl enable ly.service
systemctl disable getty@tty2.service
echo -e "#\n# Configured by Installscript\n#\nanimate=true\nbigclock=true\nblank_box=true\nhide_borders=true\nblank_password=true" >> /etc/ly/config.ini

# Install webapp-manager
cd $HOME/sourceinstalls
git clone https://github.com/linuxmint/webapp-manager.git
cd webapp-manager
apt install gir1.2-xapp-1.0 python3 python3-bs4 python3-configobj \
  	python3-gi python3-pil python3-setproctitle python3-tldextract xapps-common
make
cp -R usr etc /
glib-compile-schemas /usr/share/glib-2.0/schemas
bash makepot
cd $builddir

