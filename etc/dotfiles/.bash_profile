#!/bin/bash

SOURCERS="os_type.bash vars.bash colors.bash shopts.bash nav.bash"
PREFIX="$HOME/etc/bash_parts"

main()
{
    local file
    local fullpath
    for file in $SOURCERS ; do 
        fullpath=$PREFIX/$file
        [ -r "$file" ] && source $file
        [ -r "$file" ] || echo "[F] Failed to source \"$file\""
    done
}

main "$*"
