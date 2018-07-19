#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"
script_include "common/osdetect"

if [ ! -f "hosts.csv.blank" ] ; then
    ./make_init_hostlist.sh || exit 43
    if [ ! -f "hosts.csv" ] ; then
        copy_file "hosts.csv.blank" "hosts.csv"
    fi

fi

if [ "$(detectos)" = "osx" ] ; then
    debug "Building iterms for osx"
    ./defaults.sh || exit 44
    ./gen_base_profiles.sh || exit 45
    ./install.sh || exit 46
else
    debug "Building iterms for linux"
    ./gen_base_profiles.sh || exit 45
    ./install.sh || exit 46
fi
