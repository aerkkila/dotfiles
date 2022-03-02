nautot=`xrandr |grep ' connected'`
paanautto=`echo "$nautot" |grep primary |grep -o '^[^ ]*'`
sivunautto=`echo "$nautot" |grep -v primary |grep -o '^[^ ]*'`
