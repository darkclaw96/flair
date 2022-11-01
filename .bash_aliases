#startup command
command neofetch
command echo -e "\n\tThaaru maaru Thakkali soru!\n"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#general aliases
alias bashrl='. ~/.bashrc'

#ls
export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS -a'
alias la='ls $LS_OPTIONS -lahF'
#alias ll='ls $LS_OPTIONS -l'

#Navigation
alias ..='cd .. && ls'
alias .-='cd - && ls'

#Interactive file management:
#alias rm='rm -i'
#alias cp='cp -i'
#alias mv='mv -i'

#apt
alias aptup='sudo nala update && sudo nala upgrade'
alias aptupd='sudo nala update'
alias aptupg='sudo nala upgrade'
alias aptin='sudo nala install'
alias aptrm='sudo nala remove'

#bspwm
alias bsp='nano ~/.config/bspwm/bspwmrc'
alias hkd='nano ~/.config/sxhkd/sxhkdrc'
