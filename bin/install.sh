#!/bin/zsh

echo "installing"
pushd $HOME
git clone https://github.com/flavius/dotfiles.git $HOME
echo "Please provide your password (not root)"
chsh -s /bin/zsh
ln -s $HOME/.X/resources/programs/urxvt/main_acceptable_setup .X/resources/urxvt
popd
echo "Logging back in to reinitialize the environment"
su - `whoami`
