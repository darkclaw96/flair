### STARTUP
command neofetch
command echo -e "\n\tThaaru maaru Thakkali soru!\n"

### EXPORT
# monitor name
export DISP1="$(xrandr | grep connected | awk '{print $1}')"

### ALIASES
# reload bashrc
alias bashrl='source ~/.bashrc'
# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"
# ls
alias ls='exa -al --color=always --group-directories-first' # preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing

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
alias ..='cd .. && ls'
# back to previous directory
alias .-='cd - && ls'

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
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

### Interactive file management
# confirm before overwriting something
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

### Package management
alias aptup='sudo nala upgrade'
alias aptupd='sudo apt update'
alias aptupg='sudo apt upgrade'
alias aptin='sudo nala install'
alias aptrm='sudo nala remove'

# bspwm
alias bsp='nano ~/.config/bspwm/bspwmrc'
alias hkd='nano ~/.config/sxhkd/sxhkdrc'
