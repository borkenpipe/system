#!/bin/bash -x

SOURCERS="os_type.sh vars.sh colors.sh shopts.sh nav.sh shorthand.sh cmd_prompt.sh networking.sh ssh.sh tmux.sh shell.sh inet.sh os_post.sh finally.sh"
PREFIX="$HOME/etc/bash_parts"

main()
{
    local file
    local fullpath
    for file in $SOURCERS ; do 
        fullpath=$PREFIX/$file
        [ -r "$fullpath" ] && source $fullpath
        [ -r "$fullpath" ] || echo "[F] Failed to source \"$fullpath\""
    done
}

main "$*"
