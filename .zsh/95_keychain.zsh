if [[ $TERM == "screen-256color" ]]; then
    sig=`gpg -k --with-colons | grep "^pub" | cut -d : -f 5`
    keychain -q -Q --dir ~/.ssh/.keychain ~/.ssh/id_rsa ${sig:8}
    source ~/.ssh/.keychain/$HOST-sh
    source ~/.ssh/.keychain/$HOST-sh-gpg
fi
