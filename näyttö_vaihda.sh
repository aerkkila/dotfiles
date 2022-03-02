#!/bin/sh
. _hae_näytöt.sh
[ -z $sivunautto ] && exit
[ -z $paanautto ]  ||  paanautto_pois="--output $paanautto --off"
xrandr $paanautto_pois --output $sivunautto --auto --primary
