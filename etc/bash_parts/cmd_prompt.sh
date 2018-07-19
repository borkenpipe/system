#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

. $HOME/bin/shellTools/host_color.sh
#. $HOME/bin/sshTools/shell_gpg_agent #|| . $HOME/bin/sshTools/shell_ssh_agent
. $HOME/bin/sshTools/shell_ssh_agent
. $HOME/etc/simple-bash-powerline.sh

