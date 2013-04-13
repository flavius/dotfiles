#!/bin/zsh

echo "installing"
pushd $HOME
git clone https://github.com/flavius/dotfiles.git $HOME
echo "Please provide root password"
chsh -s /bin/zsh `whoami`
ln -s .X/resources/programs/urxvt/main_acceptable_setup .X/resources/urxvt
popd
echo "Now log out and log back in please"
