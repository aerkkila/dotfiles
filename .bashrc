# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lsh='ls --hide=*~'

alias catbash='cat ~/bash'
alias gdb='gdb -q'

kiinnita() {
    sudo mkdir -p /media/${USER}/$1
    sudo mount -o uid=$USER,gid=$(groups |grep -o '^\w*') /dev/$1 /media/${USER}/$1
}

yksi_tiedosto() {
    ls -1 $@ |head -1
}

luo_salasana() {
    pwgen 16 -sy > .$1
    gpg -o .$1.gpg --symmetric --cipher-algo AES256 .$1
    shred -vzu .$1
}

pura() {
    gpg -d ~/gpgtiedostot/$1.gpg |xclip -selection clipboard
}

nautto() {
    tmp=`xrandr |grep "^DP-. connected"`
    if [ ${#tmp} != 0 ]; then
	xrandr --output eDP-1 --off --output DP-${tmp:3:1} --auto
	return
    fi
    tmp=`xrandr |grep 'HDMI-. connected'`
    if [ ${#tmp} != 0 ]; then
	xrandr --output eDP-1 --off --output HDMI-${tmp:5:1} --auto
    fi
}

näppäimistö() {
   emacs /usr/share/X11/xkb/symbols/$1 &
   emacs /usr/include/X11/keysymdef.h &
   echo setxkbmap
}

monoääni() {
    pacmd load-module module-remap-sink sink_name=mono master=$(pacmd list-sinks | grep -m 1 -oP 'name:\s<\K.*(?=>)') channels=2 channel_map=mono,mono
}

alavasen() {
    ikkuna=`xdotool getactivewindow`
    xdotool windowsize $ikkuna 984 709
    xdotool windowmove $ikkuna 0 709
}

tvsk() {
    cd ~/tvsk
    emacs tvsk_huomioita.txt tvsk_uv.txt &
    sleep 1
    emacs=`xdotool getactivewindow`
    xdotool windowsize $emacs 550 1390
    xdotool windowmove $emacs 11 52
    kuva=`ls -1 käytetyt/*.jpg | head -$1 |tail -1`
    gnome-open $kuva &
    sleep 1
    kuva=`xdotool getactivewindow`
    xdotool windowsize $kuva 1064 1466
    xdotool windowmove $kuva 1523 -25
    gnome-open tvsk.odt &
    sleep 3
    ikkuna=`xdotool getactivewindow`
    xdotool windowsize $ikkuna 997 1391
    xdotool windowmove $ikkuna 561 52
    xdotool mousemove --window $ikkuna 300 300
    xdotool click 1
    xdotool key Ctrl+End
    xdotool click 7
}

essee() {
    cd ~/kurssit/rannikkoos/
    xdotool windowmove `xdotool getactivewindow`  1154 1040
    xdotool windowminimize `xdotool getactivewindow`
    emacs essee &
    sleep 1
    ikkuna=`xdotool getactivewindow`
    xdotool windowsize $ikkuna 1250 1390
    xdotool windowmove $ikkuna $((2559-750)) 52
    xdotool key Ctrl+x
    xdotool key 3
    xdotool key Ctrl+x
    xdotool key Ctrl+f
    xdotool type essee1
    sleep 0.2
    xdotool key Return
    firefox &
    while [ -z `xdotool search --name "DuckDuckGo"` ]
    do
        :
    done
    sleep 3
    xdotool key F6
    sleep 0.5
    xdotool type scholar.google.com
    sleep 0.5
    xdotool key Return
    ikkuna=`xdotool getactivewindow`
    xdotool windowsize $ikkuna 1200 1390
    xdotool windowmove $ikkuna 0 0
}

kandi() {
    cd ~/kurssit/kandityö
    xdotool windowmove `xdotool getactivewindow` 800 1040
    emacs tuloksista tekstiä.txt &
    sleep 1
    while [ -z `xdotool search --name "emacs@fuxi16"`]
    do
	:
    done
    sleep 0.5
    ikkuna=`xdotool getactivewindow`
    xdotool windowsize $ikkuna 1000 1390
    xdotool windowmove $ikkuna $((2559-750)) 52
    ncview icemod.nc &
    sleep 0.4
    ikkuna=`xdotool getactivewindow`
    xdotool windowmove $ikkuna 0 600
}

koord() {
    cd ~/kurssit/kandityö
    xdotool windowminimize `xdotool getactivewindow`
    ncview icemod.nc &
    sleep 0.3
    xdotool windowmove `xdotool getactivewindow` 0 600
    ncview icemod.nc &
    sleep 0.3
    xdotool windowmove `xdotool getactivewindow` 0 0
    xdotool mousemove 135 312
    sleep 0.1
    xdotool mousedown 1
    sleep 0.5
    xdotool mousemove 135 333
    xdotool mouseup 1
    sleep 0.5
    xdotool windowmove `xdotool getactivewindow` 600 60
    xdotool mousemove 218 231
    sleep 0.5
    xdotool click 1
    xdotool click 1
    xdotool mousemove 141 913
    sleep 0.1
    xdotool mousedown 1
    sleep 0.5
    xdotool mousemove 141 958
    xdotool mouseup 1
    sleep 1.3
    xdotool windowmove `xdotool getactivewindow` 600 720
    xdotool mousemove 219 832
    sleep 0.1
    xdotool click 1
    xdotool click 1
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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
