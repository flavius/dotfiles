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
* `xorg-xmodmap` for modifying keymaps
* `xclip` to copy inside tmux

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

Now create `.offlineimaprc` with vim. Use one after one the snippets named
`general`, `mailboxes` and according to your needs `gmail-account` to define
a gmail account, or `imap-account` for a more generalistic imap account. You
can combine as many as you please. Do not forget about `<C-j>` and `<C-k>` - so
you won't miss any required fields.

Please read each snippet, line by line. Their goal is to ease installation, not
to hide knowledge from you.

For instance, it is expected that you figure out yourself that after creating
the accounts, you must also list them in a comma-sepparated list in the
`general` section.

The point is: **you must know your dotfiles**.

Now let's see if you've set up offlineimap correctly. Run the command
`offlineimap`. This will take a while, so head on to the next section.

## Mutt - email reader

`cd .mutt` and use these snippets: `sec-general`, `sec-editing`, `sec-viewing`,
`sec-macros-hooks`, `sec-crypto`, `sec-accounts` in a new file called `muttrc`.
Do not forget to:

* read the configuration you're creating, so if something goes wrong, you know
  where you need to go to fix it
* use `<C-j>` and `<C-k>`

By now, you must have figured out yourself, from that last snippet
`sec-accounts`, that you have to create a file `accounts.muttrc`.

Open this file and you'll be able to use the snippet `default-account-gmail`.
You can tweak this as you like. If you have improvements anyone can benefit
from, please submit a patch for this snippet.

You can also add multiple accounts. Read the text carefully: there is also
a signature file you have to edit. It's all easy to figure out, it's
intuititive, just read what you see.

A new acronym is borning: **RWTFUS** :-)

Now run mutt from the console. You should be able to see your spoolfile now.
Pressing `O` will run offlineimap to fetch new e-mails and synchronize your
local maildirs (your spoolfile being one of them) with the IMAP server.

## SMTP - sender

You also need to send e-mails, because simply copying them to the "Sent"
maildir via offlineimap will not actually send any e-mail. OfflineIMAP is
obviously working over IMAP, but sending e-mail is done over another protocol
called SMTP. For this, we'll use msmtp.

So `cd` and `vim .msmtprc`. Use the snippet `gmail` (the only one available as
of now) and type in your gmail username.

You must also change the permissions for this one:

    chmod 600 .msmtprc

Congrats, you're all set. Except...

## It's a lie

If your e-mail is not signed, then it's a lie :-) You'll want to generate a PKI
keypair by running:

    gpg --gen-key

Choose a very long and good passphrase, with mixed letter cases, symbols and
digits. Just make sure you won't forget it. My recommendation is to also use
a big key size - most modern computers can cope these days with 4096 bits
easily.

## Notmuch - email indexer

You'll also want to index your e-mail, in order to be able to search through
all the e-mails with speed. Remember, every directory in your `~/Mail/*/`
directory is a stand-alone maildir, so it's not easy to do that.

And this includes counting the number of new e-mails (after invoking
offlineimap).

For this, we'll use notmuch. Install it if you have not already. Then use the
`def` snippet.

You should soon see a yellow hand and a number counting the numbers of new
threads in your maildirs. Send an e-mail (with mutt and vim editing and msmtp)
to yourself to test it.

