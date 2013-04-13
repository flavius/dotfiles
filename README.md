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

And set your shell to zsh:

    chsh -s /bin/zsh `whoami`

There are currently no installation instructions available. Basically, you
will also need to run

    vundle.sh -i

to install the bundles (if any), create some symlinks in `.X/resources` to
the terminal emulator used (perhaps `.X/resources/programs/urxvt/main_acceptable_setup`),
and throw in your credentials in `.config/git/10_user.conf` - there is also a
`.config/git/10_user.conf.example`.

Some other steps may be missing, but these should be the main steps.

