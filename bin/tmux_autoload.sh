#!/bin/zsh

files=( $HOME/.tmux/autoload/*(N) )
for f in $files; do
    if [ -x "$f" ]; then
        exec "$f"
    else
        tmux source-file "$f"
    fi
done

