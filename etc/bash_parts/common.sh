#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

function is_interactive ()
{
    if [[ $- == *i* ]]; then
        return 0
    else
        return 1
    fi
    return 1
}


function if_force_yesno ()
{
	while true; do
		read -p "Exit for real?" yn
		case $yn in
			[Yy]* ) return 1 ;;
			[Nn]* ) return 0 ;;
			* ) echo "Please answer yes or no.";;
		esac
	done
    echo done
    sleep 1

}

#if ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
  #PS1="@$HOSTNAME $PS1"
#fi

function cdl() { builtin cd "$@" && ls -l; }
