#!/bin/bash
# Original: http://frexx.de/xterm-256-notes/
#           http://frexx.de/xterm-256-notes/data/colortable16.sh
# Modified by Filippov Vladimir

version="colortheme 1.4
Copyright (C) 2007, 2009-2010 Despair Electronics Co.
This is free software.  You may redistribute copies of it under the terms of
the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
There is NO WARRANTY, to the extent permitted by law.

Written by Filippov Vladimir (DeanJW)."

usage="Usage: $0 [OPTION]...
Uncompress FILEs to standard output.

  -f, --full
  -s, --short    
  -h, --help        display this help and exit
  -v, --version     display version information and exit

With no FILE, or when FILE is -, read standard input.

Report bugs to <bug-gzip@gnu.org>."

case $1 in
-f | --full)    exec
uname -srm
echo
echo Table for 16-color terminal escape sequences.
echo Replace ESC with \\033 in bash.
echo
echo "┌────┬──────────────────────────────────────────────────────────────────────────┐"
echo "│BKG │  Foreground colors                                                       │"
echo "├────┼──────────────────────────────────────────────────────────────────────────┤"
FGNAMES=(' black' '   red' ' green' 'yellow' '  blue' 'magnta' '  cyan' ' white')
BGNAMES=('BLK' 'RED' 'GRN' 'YEL' 'BLU' 'MAG' 'CYN' 'WHT')
for b in $(seq 0 7); do
    bg=$(($b+40))

    echo -en "\033[0m│${BGNAMES[$b]} │  "
    for f in $(seq 0 7); do
        echo -en "\033[${bg}m \033[$(($f+30))m ${FGNAMES[$f]} "
    done
    echo -en "\033[0m│"
    echo -en "\033[0m\n│\033[0m    │  "
    for f in $(seq 0 7); do
        echo -en "\033[${bg}m \033[1;$(($f+30))m ${FGNAMES[$f]} "
    done
    echo -en "\033[0m│"    
    echo -e "\033[0m"

    if [ "$b" -lt 7 ]; then
        echo "│    ├──────────────────────────────────────────────────────────────────────────┤"
    fi
done
echo "└────┴──────────────────────────────────────────────────────────────────────────┘"
echo
echo
;;

-s | --short)    exec
echo
echo Table for 16-color terminal escape sequences.
echo Replace ESC with \\033 in bash.
echo
echo "Background | Foreground colors"
echo "---------------------------------------------------------------------"
for((bg=40;bg<=47;bg++)); do
        for((bold=0;bold<=1;bold++)) do
                echo -en "\033[0m"" ESC[${bg}m   | "
                for((fg=30;fg<=37;fg++)); do
                        if [ $bold == "0" ]; then
                                echo -en "\033[${bg}m\033[${fg}m [${fg}m  "
                        else
                                echo -en "\033[${bg}m\033[1;${fg}m [1;${fg}m"
                        fi
                done
                echo -e "\033[0m"
        done
        echo "--------------------------------------------------------------------- "
done

echo
echo
;;

-sf)    exec

for attr in 0 1 4 5 7 ; do
    echo "----------------------------------------------------------------"
    printf "ESC[%s;Foreground;Background - \n" $attr
    for fore in 30 31 32 33 34 35 36 37; do
        for back in 40 41 42 43 44 45 46 47; do
            printf '\033[%s;%s;%sm %02s;%02s  ' $attr $fore $back $fore $back
            printf '\033[0m'
        done
    printf '\n'
    done
    printf '\033[0m'
done

echo
echo
;;

-h | --help)    exec echo "$usage";;
-v | --version) exec echo "$version";;
*)    exec echo "$usage";;
esac
