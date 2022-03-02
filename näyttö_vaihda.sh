#!/bin/sh
. _hae_näytöt.sh
[ $sivunautto ] || exit
[ $paanautto ]  &&  paanautto_pois="--output $paanautto --off"
xrandr $paanautto_pois --output $sivunautto --auto --primary
[ $TAUSTA ] || TAUSTA='#000000'
hsetroot -solid $TAUSTA
