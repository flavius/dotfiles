This dotfiles setup configures the following tools:

* `zsh` as a shell
* `git` for revision control
* `vim` as an editor
* `X` for display
* `awesomeWM` as the window manager
* `tmux` as the terminal multiplexer
* `keychain` for starting the ssh agent upon login
* `weechat` as an IRC (freenode) client, with some scripts and sane defaults

The best way to start off is by using a new user altogether. Log into your
account and clean everything:

    rm -rf * .*

The quick way is to then issue:

    zsh <(curl https://raw.github.com/flavius/dotfiles/rewrite/bin/install.sh -L -o -)

* create a new user
* clone this repository into
