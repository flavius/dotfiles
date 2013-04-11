#!/bin/zsh

#TODO use zparseopts
case $1 in
'-i')
    params=('+BundleInstall')
    if [[ "$2" == '-q' ]]; then
        params=($params '+qall')
    fi
    tty=`tty`
    `vim $params < $tty > $tty`
   ;;
esac
