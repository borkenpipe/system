#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"
script_include "common/osdetect"

if [ "$(detectos)" = "osx" ] ; then
    debug "Installing for osx"
    # use our stuff now
    ./defaults.sh
    # Hammer time
    # shellcheck disable=SC2045,SC2035,SC2010,SC2086,SC2086
    for file in $(ls *json | grep -v "base_template.json\\|colors.json") ; do mv -fv $file ~/Library/Application\ Support/iTerm2/DynamicProfiles/$file ; done
    # should be needed ?
    [ ! -d ~/etc/ ] && mkdir -v ~/etc/
    mv -v it2prof_hosts.sh ~/etc/
    mv -v myhosts ~/etc/
else
    debug "Installing for linux"
    mv -v myhosts ~/etc/
    mv -v it2prof_hosts.sh ~/etc/
fi
