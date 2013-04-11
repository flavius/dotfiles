if [[ $TERM != "screen-256color" ]]; then
    tmux attach -t ctrl || tmux new -s ctrl
fi
