#!/bin/bash
# Taken from:
#	https://raw.github.com/kaihendry/Kai-s--HOME/master/.xinitrc
#
# for terminus font in Archlinux :(
xset +fp /usr/share/fonts/TTF &
xset fp rehash



while true
do
	LOCALTIME=$(date +%Z\=%Y-%m-%dT%H:%M)
	OTHERTIME=$(TZ=Europe/London date +%Z\=%H:%M)
	IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1) # can get confused if you use vmware
	TEMP="$(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))C"

	if acpi -a | grep off-line > /dev/null
	then
		BAT="Bat. $(acpi -b | awk '{ print $4 " " $5 }' | tr -d ',')"
		xsetroot -name "$IP $BAT $VOL $TEMP $LOCALTIME"
	else
		xsetroot -name "$IP $TEMP $LOCALTIME"
	fi
	sleep 10s
done &

xrandr --output VGA-1 --auto --left-of LVDS-1 &

xrdb -merge ~/.Xresources
pulseaudio --start &
 
set enable-keypad on
 
make /home/priyanshu/dwm

exec /home/priyanshu/dwm/dwm
