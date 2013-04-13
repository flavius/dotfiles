#!/bin/zsh

echo "installing"
pushd $HOME
git clone https://github.com/flavius/dotfiles.git $HOME
chsh -s /bin/zsh `whoami`
ln -s .X/resources/urxvt .X/resources/programs/urxvt/main_acceptable_setup
popd
echo "Now log out and log back in please"
