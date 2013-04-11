setopt nonomatch
PATH=$HOME/bin:$PATH

for file in $HOME/.zsh/*.zsh; do
    source $file
done
