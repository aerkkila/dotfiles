# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth # don't put duplicate lines or lines starting with space in the history.
shopt -s histappend # append to the history file, don't overwrite it
HISTSIZE=2000
HISTFILESIZE=300000

shopt -s checkwinsize # päivitä LINES ja COLUMNS -arvot aina komennon jälkeen
shopt -s globstar # "**" täsmää kaikkiin tiedostoihin ja hakemistoihin alihakemistoineen

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

PS1='\[\033[33m\]\#\[\033[1;94m\]\w\[\033[0m\]\$ '

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
alias emasc='echo "Korjataan emasc -> emacs" ; emacs'
alias netti='sudo systemctl restart NetworkManager.service'
alias diff='diff --color'

kiinnita() {
    sudo mkdir -p /media/${USER}/$1
    sudo mount -o uid=$USER,gid=$(groups |grep -o '^\w*') /dev/$1 /media/${USER}/$1
}

yksi_tiedosto() {
    ls -1 $@ |head -1
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
