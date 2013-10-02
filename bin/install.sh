#!/bin/zsh

echo "installing"
pushd $HOME
git clone https://github.com/flavius/dotfiles.git $HOME
echo "Please provide your password (not root)"
chsh -s /bin/zsh
#ln -s $HOME/.X/resources/programs/urxvt/main_acceptable_setup .X/resources/autoload/urxvt
mkdir -p $HOME/.vim/bundle
pushd $HOME/.vim/bundle
git clone https://github.com/vim-chosen-plugins/vundle.git
popd
popd
echo "Please log out and log back in again"
