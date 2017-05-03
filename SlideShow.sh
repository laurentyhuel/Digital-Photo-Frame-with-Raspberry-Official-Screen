#!/bin/sh
feh --recursive --randomize --auto-zoom --fullscreen --borderless --hide-pointer --cycle-once --slideshow-delay 5 --image-bg black /media/pi/ToshibaExt/Images/ & # run feh in background with appropriate options
echo '"pkill -n feh; pkill -n xbindkeys"'>xbindkeys.temp # create file with commands to kill feh and xbindkeys
echo "b:1">>xbindkeys.temp # when button 1 is pressed
xbindkeys -n -f xbindkeys.temp # execute xbindkeys using created file and not a daemon
rm xbindkeys.temp # dump the file
