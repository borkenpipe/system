#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

if which assh ; then
    alias ssh="assh wrapper ssh"
    acl()
    {
        assh config list
    }
    asl()
    {
        assh sockets list
    }
    asf()
    {
        assh sockets flush
    }
fi
