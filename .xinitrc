#!/bin/zsh

files=( $HOME/.X/initrc/autoload/*(N) )
if (( $#files )); then
    for f in $files; do
        source "${f}"
    done
fi

files=( $HOME/.X/modmap/autoload/*(N) )
if (( $#files )); then
    for modmap in $files; do
        xmodmap "${modmap}"
    done
fi

files=( $HOME/.X/resources/autoload/*(N) )
if (( $#files )); then
    for res in $files; do
        xrdb -merge "${res}"
    done
fi

#xset b off &
#/usr/bin/xscreensaver -no-splash &
#xbindkeys &

#mpdscribble &
#mpd ~/.mpdconf &
#dropboxd &

#. ~/.screenlayout/top_down.sh

files=( $HOME/.X/pre-wm/autoload/*(N) )
if (( $#files )); then
    for f in $files; do
        source "${f}"
    done
fi

source $HOME/.X/wm

