#!/bin/zsh

for f in $HOME/.X/initrc/*; do
    if [ -f "$f" ]; then
        source "${f}"
    fi
done

for modmap in $HOME/.X/modmap/*; do
    if [ -f "$modmap" ]; then
        xmodmap "${modmap}"
    fi
done

for res in $HOME/.X/resources/*; do
    if [ -f "$res" ]; then
        xrdb -merge "${res}"
        echo "MERGE: $res"
    fi
done

#xset b off &
#/usr/bin/xscreensaver -no-splash &
#xbindkeys &

#mpdscribble &
#mpd ~/.mpdconf &
#dropboxd &

#. ~/.screenlayout/top_down.sh

for f in $HOME/.X/pre-wm/*; do
    if [ -f "$f" ]; then
        source "${f}"
    fi
done

echo "-----[ starting WM ]----------------------------------------------------"

source $HOME/.X/wm

for f in $HOME/.X/post-wm/*; do
    if [ -f "$f" ]; then
        source "${f}"
    fi
done
echo "-----[ .xinitrc done ]--------------------------------------------------"
