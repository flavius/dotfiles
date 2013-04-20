This dotfiles setup configures the following tools:

* `zsh` as a shell
* `git` for revision control
* `vim` as an editor
* `X` for display
* `awesomeWM` as the window manager
* `tmux` as the terminal multiplexer
* `keychain` for starting the ssh agent upon login
* `weechat` as an IRC (freenode) client, with some scripts and sane defaults
* `msmtp`, `mutt`, `offlineimap` and `notmuch` integrated for e-mail, along
  with helper functionalities allowing you to quickly set up new accounts
  * todo: and remove them
  * also available: tmux integration (pager showing number of new e-mails)

Make sure you have these programs installed. Other programs may also be
required, in which case I've forgot to mention them. If this occures to you,
please submit an issue.

The best way is to start from scratch, with a new user altogether. You can
either delete everything in your home directory, if you REALLY do not have
any important data (for instance, if you've just installed linux), like so:

    rm -rf $HOME/*
    rm -rf $HOME/.*

Or you can create a new user, as root:

    USER=foo && PASS=bar && useradd -p $(perl -e"print crypt('${PASS}', '${USER}')") -c "Real ${USER}" ${USER} && mkdir /home/${USER} && chown -R ${USER}:users /home/${USER}

Do not forget to set the variables `USER` and `PASS` in the above command.

Once you're logged in as user `$USER` (no matter how) and `ls -la` shows nothing but the
directories `.` and `..`, you can type in:

    zsh <(curl https://raw.github.com/flavius/dotfiles/master/bin/install.sh -L -s -o -)

A few questions may be asked. Just follow the instructions in the output.

To get ssh authentication at login, you'll use keychain. Just move your
`id_rsa` and `id_rsa.pub` to `.ssh/` and relogin. You will be prompted only
once for your passphrase, and you'll be authenticated to all your servers and
git repositories (you do use PKI for authentication, right?).

Then log out and log back in. A tmux session will start if you log in from a
linux terminal (`tty{1,2,3,4,5,6}`). If you log in from `X`, awesome WM will
start, in which case you have to press the Windows key (called `Mod4`) and
`Enter` to get a terminal emulator (with tmux started inside).

If you want to install the vim plugins, do:

    vundle.sh -i

To initialize your git credentials, do:

    vim .config/git/10_user.conf

Enter `G` to go to the end of the document, press `i` to enter insert mode,
then type the snippet name `user` and press `<Tab>` once.

The highlighted text tells you what to fill in. Additionally, the surrounding
text should be self-explanatory.

*Do not* rely on the provided snippets. They are just shortcuts. If you do, at
the very least read the rest of the text, so you'll be able to come back and
fix any problem may occur. The snippets are a quick way of hitting the ground
running if you already know what you're doing.

Press `<C-j>` and `<C-k>` respectively, while in insert mode, to navigate
across placeholders in the snippet.

After saving it, `git status` will show it as a modified file. But actually it
is ignored, as shown by:

    git ls-files -i --exclude-standard

For this reason, let's ignore it for good:

    git update-index --assume-unchanged .config/git/10_user.conf

# E-Mail

## Credentials

First off, you need to store your credentials. This is done via `.netrc`.

To do this (as most of the configuration), we use snippets, in this case one
named `machine`, analogously to the `user` above.

If you want to configure gmail credentials, you can use the snippet
`gmail-machine`. Personally, I recommend you generate an application-specific
password and use that, instead of your cleartext account password. First you
need to activate [two-step
authentication](https://www.google.com/accounts/SMSAuthConfig) if you have not
already, and then head over to [application-specific
passwords](https://accounts.google.com/b/0/IssuedAuthSubTokens?hide_authsub=1).
Everything else should be obvious.

This is not as secure as encrypting the files, but at least you have a quick
"plan B" in case your machine gets lost, as you can easily revoke such
passwords.

## IMAP - client

Now open `.offlineimaprc` with vim. Reading the top comments, you should figure
out what snippets are available. Press `G` to go to the bottom of the file, and
use the snippets you need. `<C-j>` and `<C-k>` are available as always, thanks
to the UltiSnips vim plugin.

Do not forget to re-read the top comments, which instruct you how to activate
the accounts you've created. The snippets were used just to create them, but
they need to be wired the way it's described in the comments.

In general, read the *entire* file you're creating, even if you're using
scripts or shortcuts like snippets. I cannot emphasize this enough: these are
*YOUR* configs, *YOU* are responsible for them.

Now let's see if you've set up offlineimap correctly. Run the command
`offlineimap`. This may take a while, depending on the amount of e-mail you
have. 30k messages may take around a half an hour (approximation depending on
many factors, so you know what to expect).

## SMTP - sender

## Mutt - email client

## Notmuch - email indexer

