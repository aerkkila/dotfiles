tmp=`xrandr |grep -o '.* connected' |grep -o '^[^e ]*'`
if [ ${#tmp} != 0 ]; then
    xrandr --output eDP-1 --off --output ${tmp} --auto
fi

#lisätään kaikki fonttipolut
kansiot=`ls -1 /usr/share/fonts`
for i in $kansiot; do
    xset +fp /usr/share/fonts/$i
done

xset r rate 340 40;
exec blueman-applet &
exec xcompmgr & #ikkunoitten läpinäkyvyys
#exec picom -CG --no-fading-openclose --paint-on-overlay &
exec hsetroot -solid '#000000' & #tausta mustaksi, xcompmgr muuttaa sen harmaaksi
./.tilapalkki.sh &
numlockx &
exec dwm 2> ~/.dwm.log
