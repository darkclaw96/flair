# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export DISPLAY=:0

# xsecurelock
export XSECURELOCK_BURNIN_MITIGATION=5
export XSECURELOCK_BURNIN_MITIGATION_DYNAMIC=1
export XSECURELOCK_DATETIME_FORMAT="%H:%M"
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=0
export XSECURELOCK_FONT="FiraCode 32"
export XSECURELOCK_PASSWORD_PROMPT=time
export XSECURELOCK_SHOW_DATETIME=1

# Gaming
export MANGOHUD=1
export ENABLE_VKBASALT=1

# Script variables
export DISP1="$(xrandr | grep connected | awk '{print $1}')"
