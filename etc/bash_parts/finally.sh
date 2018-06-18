#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

#BASH
export HISTFILESIZE=2147483647
export HISTSIZE=2147483647
export HISTTIMEFORMAT="%F %T #"
export EDITOR=vim
export GIT_EDITOR="visp"

export LESS="-S"

LOCALSCRIPTSPATH=$HOME/etc/hostconfigs/$(hostname)/
LOCALSCRIPTSFIRST=$LOCALSCRIPTSPATH/firsttime
if [ -x $LOCALSCRIPTSFIRST ] ; then
    if [ ! -r /tmp/firsttime ] ; then
        $LOCALSCRIPTSFIRST && touch /tmp/firsttime
    else
        [ -n "$DEBUG" ] && echo "[-] not first time to run ($LOCALSCRIPTSFIRST) ...         rm /tmp/firsttime #RMFIRSTTIME"
    fi
else
    [ -n "$DEBUG" ] && printf "[-] No local host scripts\\n\\t\\t(%s)  to run\\n" "$LOCALSCRIPTSFIRST"
fi
LOCALSCRIPTS=$LOCALSCRIPTSPATH/login
if [ -x $LOCALSCRIPTS ] ; then
    $LOCALSCRIPTS
else
    [ -n "$DEBUG" ] && printf "[-] No local host scripts\\n\\t\\t(%s)  to run\\n" "$LOCALSCRIPTS"
fi
LOCALSOURCE=$LOCALSCRIPTSPATH/source
if [ -x $LOCALSOURCE ] ; then
    source $LOCALSOURCE
else
    [ -n "$DEBUG" ] && printf "[-] No local host scripts\\n\\t\\t(%s)  to run\\n" "$LOCALSOURCE"
fi

# shellcheck disable=SC2139
alias hostconfigs_edit_first="\$EDITOR $LOCALSCRIPTSFIRST"
# shellcheck disable=SC2139
alias hostconfigs_edit_source="\$EDITOR $LOCALSOURCE"
# shellcheck disable=SC2139
alias hostconfigs_edit_login="\$EDITOR $LOCALSCRIPTS"

if [ -x tmux ] ; then
    [ -n "$DEBUG" ] && echo "[*] tmux sessions"
    tl
fi

PLAN=~/.plan
if [ -r $PLAN ] ; then
    cat $PLAN
fi

# PUNISHMENT
alias locaete=sl
alias gerp=sl

