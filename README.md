This dotfiles setup configures the following tools:

* `zsh` as a shell
* `git` for revision control
* `vim` as an editor
* `X` for display
* `awesomeWM` as the window manager
* `tmux` as the terminal multiplexer
* `keychain` for starting the ssh agent upon login
* `weechat` as an IRC (freenode) client, with some scripts and sane defaults

Make sure you have these programs installed. Other programs may also be
required, in which case I've forgot to mention them. If this occures to you,
please submit an issue.

The best way is to start from scratch, with a new user altogether. You can
either delete everything in your home directory, if you REALLY do not have
any important data (for instance, if you've just installed linux), like so:

    rm -rf $HOME/*
    rm -rf $HOME/.*

Or you can create a new user, as root:

    USER=foo && PASS=bar && useradd -p $(perl -e"print crypt('$PASS', '$USER')") -c "Hello Hacklets" $USER && mkdir /home/$USER && chown -R $USER:users /home/$USER

Do not forget to set the variables `USER` and `PASS` in the above command.

Once you're logged in as user `$USER` (no matter how) and `ls -la` shows nothing but the
directories `.` and `..`, you can type in:

    zsh <(curl https://raw.github.com/flavius/dotfiles/master/bin/install.sh -L -s -o -)

A few questions may be asked. Just follow the instructions in the output.

Then log out and log back in. A tmux session will start if you log in from a
linux terminal (`tty{1,2,3,4,5,6}`). If you log in from `X`, awesome WM will
start, in which case you have to press the Windows key (called `Mod4`) and
`Enter` to get a terminal emulator (with tmux started inside).

If you want to install the vim plugins, do:

    vundle.sh -i

To initialize your git credentials, do:

    cd .config/git/
    cp 10_user.conf.example 10_user.conf
    vim 10_user.conf

and edit the file accordingly.
