#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

if [ $(uname) == "Darwin" ] ; then
    alias md5sum="md5"

    if [[ -x /usr/local/bin/brew  && -f $(brew --prefix)/etc/bash_completion ]]; then
        . $(brew --prefix)/etc/bash_completion
    fi
fi

