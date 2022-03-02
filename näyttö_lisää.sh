#!/bin/sh
. _hae_näytöt.sh
[ -z $sivunautto ] || [ -z $paanautto ] && exit
[ -z $1 ] && suunta='--left-of' || suunta="$1"
xrandr --output $sivunautto --auto $suunta $paanautto
