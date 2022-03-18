DP=`xrandr |grep -o '.* connected' |grep -o '^[^e ]*'`
eDP=`xrandr |grep -o '.* connected' |grep -o '^e\S*'`
[ $DP ] && xrandr --output ${eDP} --off --output ${DP} --auto --primary

#lisätään kaikki fonttipolut
kansiot=`ls -1 /usr/share/fonts`
for i in $kansiot; do
    xset +fp /usr/share/fonts/$i
done

xset r rate 250 40;
exec blueman-applet &
exec xcompmgr & #ikkunoitten läpinäkyvyys
[ $TAUSTA ] || export TAUSTA='-solid #000000' #oletustausta mustaksi, xcompmgr muuttaa sen harmaaksi
exec hsetroot $TAUSTA &
./.tilapalkki1.sh &
numlockx &
exec dwm 2> ~/.dwm.log
