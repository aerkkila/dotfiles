# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=2000
HISTFILESIZE=30000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='\[\033[33m\]\#\[\033[1;34m\]\w\[\033[0m\]\$ '

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

alias gdb='gdb -q'
alias sudo='sudo -E'
alias rm='rm -I'

kiinnita() {
    sudo mkdir -p /media/${USER}/$1
    sudo mount -o uid=$USER,gid=$(groups |grep -o '^\w*') /dev/$1 /media/${USER}/$1
}

yksi_tiedosto() {
    ls -1 $@ |head -1
}

luo_salasana() {
    pwgen 16 -sy | gpg -o ~/gpgtiedostot/$1.gpg --symmetric --cipher-alge AES256
}

pura() {
    gpg -d ~/gpgtiedostot/$1.gpg |xclip -selection clipboard
}

näppäimistö() {
   emacs /usr/share/X11/xkb/symbols/$1 &
   echo setxkbmap
}

monoääni() {
    pacmd load-module module-remap-sink sink_name=mono master=$(pacmd list-sinks | grep -m 1 -oP 'name:\s<\K.*(?=>)') channels=2 channel_map=mono,mono
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#ssh-agent käynnistyy ellei jo ole käynnissä
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 6h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
