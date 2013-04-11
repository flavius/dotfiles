#!/bin/zsh

out=("${(@f)$(eval fc-list| grep Powerline | cut -d ':' -f 2)}")
for line in $out; do
    line="${line:1}"
    name1=("${(s/,/)line}")
    echo "$name1[1]"
    #xterm -geometry 50x10+0+0 -fa "$name1[1]" -fs 14 -hold -e "echo xterm; cat ~/chars.txt; echo $name1[1]"&
    urxvt -geometry 50x10+800+0 -fn "xft:$name1[1]" -hold -e sh -c "echo urxvt; cat ~/chars.txt; echo $name1[1]"&
done
