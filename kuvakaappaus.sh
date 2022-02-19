#!/bin/sh

osakuva() {
    ffmpeg -loglevel warning -f x11grab -show_region 1 -video_size $3x$4 -i $DISPLAY+$1,$2 -frames: 1 $HOME/kuvakaappaus_"$( date +"%s" )".png
}

kokokuva() {
    ffmpeg -loglevel warning -f x11grab -i $DISPLAY -frames: 1 $HOME/kuvakaappaus_"$( date +"%s" )".png
}

if [ "$#" -lt 1 ]; then
    kokokuva
else
    osakuva $@
fi
