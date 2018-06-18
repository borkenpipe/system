#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

shopt -s checkwinsize # After each command, checks the windows size and changes lines and columns

