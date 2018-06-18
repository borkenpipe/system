#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

gresults(){ s="$@"; wget -q -O- -U Mozilla www.google\.com/search?q=\"$s\" |egrep -o "About [0-9,]+ results";} # Get Google results number

