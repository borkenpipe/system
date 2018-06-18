#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

export IFACE_FUNCTIONS=~/bin/netTools/iface-functions.sh
if [ -x $IFACE_FUNCTIONS ] ; then
    source $IFACE_FUNCTIONS
    alias ifu=iface_up
    alias ifd=iface_down
    alias ifl=iface_list
fi

mping()
{
    ping "$@" | awk -F[=\ ] '/time=/{t=$(NF-1);f=2000-14*log(t^18);c="play -q -n synth 1 pl "f"&";print $0;system(c)}'
}

countdown()
(
  IFS=:
  set -- $*
  secs=$(( ${1#0} * 3600 + ${2#0} * 60 + ${3#0} ))
  while [ $secs -gt 0 ]
  do
    sleep 1 &
    printf "\r%02d:%02d:%02d" $((secs/3600)) $(( (secs/60)%60)) $((secs%60))
    secs=$(( $secs - 1 ))
    wait
  done
  echo
)

cpr()
{
  rsync -Rav --progress $*
  sync
}
