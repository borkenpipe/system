#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

SHELL_NAME=$(basename $SHELL)
export SHELL_INTEGRATION=$SYSTEM_PATH_ETC/iterm2/iterm2_shell_integration.${SHELL_NAME}
test -e "${SHELL_INTEGRATION}" && source "${SHELL_INTEGRATION}"

alias iterm_trans='echo -e "\033]50;SetProfile=Transparent\x7"'
alias iterm_def='echo -e "\033]50;SetProfile=Default\x7"'

ITERM_PROFILE_HELPERS=$HOME/etc/it2prof_hosts.sh
[ -f "${ITERM_PROFILE_HELPERS}" ] && source "${ITERM_PROFILE_HELPERS}"
alias iterm_etc="cd ~/etc/iterm2/"
alias i_etc="cd ~/etc/iterm2/"
alias i_dyn="cd ~/Library/Application\ Support/iTerm2/DynamicProfiles/"

iterm_get_integrations()
{
    if [ ! -f $SHELL_INTEGRATION ] ; then
        curl -L https://iterm2.com/misc/${SHELL_NAME}_startup.in -o ~/.iterm2_shell_integration.${SHELL_NAME}
        source $SHELL_INTEGRATION
    fi
}

