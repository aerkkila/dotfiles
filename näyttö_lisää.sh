#!/bin/sh
. _hae_näytöt.sh
[ -z $sivunautto ] || [ -z $paanautto ] && exit
[ $1 ] && suunta="$1" || suunta='--left-of'
xrandr --output $sivunautto --auto $suunta $paanautto 
[ $TAUSTA ] || TAUSTA='#000000'
hsetroot -solid $TAUSTA
