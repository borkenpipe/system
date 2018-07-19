#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

export PLAN=$HOME/.plan
export SYSTEM_COMMON_PATHS=$HOME/etc/system_common_paths
[ -f "$SYSTEM_COMMON_PATHS" ] && source $SYSTEM_COMMON_PATHS

ALLPATHS="common basicTools codeTools devTools devTools/jsonTools distroTools hackTools javaTools mediaTools mgmtTools vpn netTools osxTools repoTools sanitaryTools screenTools shellTools sshTools sysadminTools tmuxTools unixtooltipTools vmwareTools vmwareTools/vmware vmwareTools/vagrantTools"

for newpath in $ALLPATHS ; do 
    newfullpath="$SYSTEM_PATH_BIN/$newpath"
    if [ -d "$newfullpath" ] ; then
        debug "Importing $newfullpath"
        export PATH="$PATH:$newfullpath"
    else
        isdebug && warn "No $newfullpath"
    fi
done

export PATH

