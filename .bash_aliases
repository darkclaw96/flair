### PATH
export PATH="$HOME/scripts/:$PATH" #for scripts
export PATH="$HOME/.local/bin:$PATH" #for pip

## STARTUP
command hello.sh  

### ALIASES
#vim
alias v='vim'
# edit bash aliases
alias brc='vim $HOME/.bashrc'
alias bal='vim $HOME/.bash_aliases'
# reload bashrc
alias brl='source $HOME/.bashrc'
# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"
# ping
alias ping='ping -c 10'
# alias ls
alias ls='exa -al --color=always --group-directories-first' # preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'
# alias xrandr
alias s1080='xrandr -s 1920x1080'
alias s720='xrandr -s 1280x720'
# bspwm
alias bsp='vim $HOME/.config/bspwm/bspwmrc'
alias hkd='vim $HOME/.config/sxhkd/sxhkdrc'
# run some folder specific command
alias run='$(cat cmdrun)'
### Package management
alias aptup='sudo nala upgrade'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptin='sudo nala install'
alias aptrm='sudo nala remove'
alias apts='nala search'

# QR
alias qr='qrencode -t ansiutf8 '

### NAVIGATION
up () {
  local d=""
  local limit="$1"
  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi
  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done
  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}
# up one level
alias cd..='cd ..'
alias ..='cd ..'
# back to previous directory
alias .-='cd -'
# Search files in the current folder
alias f="find . | grep "
# Automatically do an ls after each cd
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && la
	else
		builtin cd ~ && la
	fi
}

### Interactive file management
# confirm before overwriting something
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# rofi
alias rofichoose='rofi -dmenu -i -theme menu.rasi -p $1 $2'

# Python venvs
alias venvmk='python -m venv . && echo $(realpath .) >> ~/venvs'
alias venvgo='cd $(cat ~/venvs | rofichoose "Choose venv:" $1) && source $(realpath .)/bin/activate'
#alias venvgo='cd $(cat ~/venvs | rofi -dmenu -i -p "Choose venv:" $1) && source $(realpath .)/bin/activate'

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1   ;;
      *.tar.gz)    tar xvzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xvf $1    ;;
      *.tbz2)      tar xvjf $1   ;;
      *.tgz)       tar xvzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# play audio
playaudio(){
    file=$1
    paplay "$file" &
}

### Sync bash aliases from github
gitbash() 
{
	mv ~/.bash_aliases ~/.bash_aliases.bk
	cd
	wget https://github.com/darkclaw96/linuxconf/raw/main/.bash_aliases
	bashrl
}

### SOURCE
# bash-insulter
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### Remove duplicates in PATH
PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
