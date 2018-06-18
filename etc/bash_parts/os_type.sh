#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

PATH=$PATH:/usr/local/bin:$HOME/bin:$HOME/opt/bin
if [ "$(uname)" == "Darwin" ] ; then
    PATH=$PATH:$HOME/bin/osx
    PATH=$PATH:$HOME/bin/osx/applescripts
    PATH=$PATH:/Applications/Utilities/Activity\ Monitor.app/Contents/MacOS
    PATH=$PATH:/Applications/KisMAC.app/Contents/MacOS
    PATH=$PATH:/Applications/Meld.app/Contents/MacOS/
    alias meld=Meld
    PATH=$PATH:/Applications/Xcode.app/Contents/Applications/FileMerge.app/Contents/MacOS/
    PATH=$PATH:/usr/local/sbin
    PATH=$PATH:$HOME/DeveloperTools
    PATH=$PATH:$HOME/bin/itermFunzzies/
    OSTYPE="DARWIN"

    source $HOME/etc/bash_parts/iterm2.sh

    SHELL_NAME=$(basename $SHELL)
    export SHELL_INTEGRATION=~/.iterm2_shell_integration.$SHELL_NAME

    if [ ! -f $SHELL_INTEGRATION ] ; then
        curl -L https://iterm2.com/misc/${SHELL_NAME}_startup.in -o ~/.iterm2_shell_integration.${SHELL_NAME}
        source $SHELL_INTEGRATION
    fi

    if [[ -x /usr/local/bin/brew  && -f $(brew --prefix)/etc/bash_completion ]]; then
        source "$(brew --prefix)/etc/bash_completion"
    fi

    # VMware Fusion
    if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
        export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
    fi

    if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
        . "$(brew --prefix)/etc/bash_completion"
    fi

else
    OSTYPE="ASSUMING_LINUX"
    PATH=$PATH:$HOME/bin/gpg
    source $HOME/etc/bash_parts/linux_term.sh
fi

[ -n "$DEBUG" ] && echo "[*] OSType: $OSTYPE"
