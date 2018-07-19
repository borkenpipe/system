#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

SHELL_NAME=$(basename $SHELL)

ITERM_PROFILE_HELPERS=$HOME/etc/it2prof_hosts.sh
[ -f "${ITERM_PROFILE_HELPERS}" ] && source "${ITERM_PROFILE_HELPERS}"
alias iterm_etc="cd ~/etc/iterm2/"
