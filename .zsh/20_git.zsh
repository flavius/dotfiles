###############################################################################
# utility functions for managing dotfiles
#
# the bare repositories are found at $DOTFILES_MASTERDIR.
# TODO: further documentation
###############################################################################

###############################################################################
### internal functions
###############################################################################
function dotdirs() {
    local -a mydirs; mydirs=()
    local -a name
    for gitdir in $DOTFILES_MASTERDIR/*.git; do
        name=${gitdir//$DOTFILES_MASTERDIR\/}
        mydirs+=(${name:0:-4})
    done
    reply=($mydirs)
    return
}

function dotfiles_get_tracked() {
    local -a aliases;
    local -a out;
    dotdirs
    aliases=($reply)
    typeset -gA reply
    reply=()
    for a in $aliases; do
        out=("${(@f)$(eval .G-$a ls-tree -r --name-only $1)}")
        for line in $out; do
            reply[$line]=$a
        done
    done
    #for k in ${(k)reply}; do
    #    echo "$k -> $reply[$k]"
    #done
    return
}

function dotfiles_create_alias() {
    alias .G-$1="git --work-tree=$HOME --git-dir=$DOTFILES_MASTERDIR/$1.git"
}

function dotfiles_get_untracked() {
    local -a out;
    local -a untracked;
    out=("${(@f)$(eval git --git-dir=$HOME/.git clean -dnX)}")
    for line in $out; do
        untracked+=(${line:13})
    done
    reply=($untracked)
    return
}

###############################################################################
### public functions
###############################################################################
function dotfiles_create_git_aliases() {
    local -a dirnames;
    dotdirs
    dirnames=($reply)
    for gitdir in $dirnames; do
        dotfiles_create_alias $gitdir
    done
    return
}

function dotfiles_list_tracked() {
    #typeset -gA reply
    dotfiles_get_tracked HEAD
    for key in ${(k)reply}; do
        if [ ! -z $1 ]; then
            echo "$reply[$key]\t$key"
        else
            echo "$key"
        fi
    done
    typeset -ga reply
    return
}

function dotfiles_list_untracked() {
    dotfiles_get_untracked
    for untracked in $reply; do
        if [ ! -z $1 ]; then
            echo "$untracked"
        else
            if [ "/" != $untracked[-1] ]; then
                echo "$untracked"
            fi
        fi
    done
}

function dotfiles_new_repo() {
    if [ ! -d "$DOTFILES_MASTERDIR/$1.git" ]; then
        mkdir -p "$DOTFILES_MASTERDIR/$1.git"
        git init --bare "$DOTFILES_MASTERDIR/$1.git"
    fi
    dotfiles_create_alias $1
    return
}

###############################################################################
### main()
###############################################################################
dotfiles_create_git_aliases
