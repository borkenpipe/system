#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

alias cs="cscope -R"
alias diff="colordiff -u"
alias cless="colordiff | less"
alias make="colormake"
#GIT
alias gd="git diff | colordiff | less -R"
alias gs="git status"
alias gb="git branch -a -vv"
alias gl="git lg"
alias gls="git lgs"
alias ga="git add"
alias gco="git checkout"
alias gitk="gitk --all"
#MERCURIAL
alias hd="hg diff | colordiff | less -R"
alias hs="hg status"
alias hl="hg lg"
alias hls="hg lgs"
alias ha="hg add"
alias hb="hg branch"
alias hco="hg checkout"
#MAKE
which colormake 1>/dev/null 2>&1
if [ $? -eq 0 ] ; then
    alias make=$(which colormake)
fi

FIND="find"
alias lsd="$FIND . -maxdepth 1 -type d | less"
alias lsf="$FIND . -maxdepth 1 -type f | less"
function findme()
{
    $FIND . -regextype posix-egrep -regex ".*$*.*"
}
