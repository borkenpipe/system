#!/bin/bash

SYSTEM_PATH_BIN=${SYSTEM_PATH_BIN:-"$HOME/bin"}
SYSTEM_PATH_ETC=${SYSTEM_PATH_ETC:-"$HOME/etc"}
SOURCE_DIR_SYSTEM=${SYSTEM_PATH_BIN}
source "${SYSTEM_PATH_BIN}/common/includer.sh"
script_include "common/util.sh"

##################
# TMUX FUNCTIONS #
##################
alias tl="tmux list-sessions"
alias tn="tmux new -s "
alias ta="tmux_detach_attach"
alias ts="tmux switch -t "
function tmwv {
    tmux split-window -dh "$*"
}

function tmwh {
    tmux split-window -dv "$*"
}

tda() {
    tmux_detach_attach "$*"
}
tdac()
{
    tmux_detach_attach console
}

##############
# TMUXINATOR #
##############
alias mux="tmuxinator"
tmuxinator_etc()
{
    cd ~/etc/dotfiles/.config/tmuxinator || return 1
}
alias te=tmuxinator_etc
[ -r "$HOME/etc/bash_parts/tmuxinator.bash" ] && source ~/etc/bash_parts/tmuxinator.bash

alias ml="mux list"
alias mc="mux commands"

################
# PROFILE MGMT #
################

SESSION_TYPE=local
MYTTY=$(tty)
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    SESSION_TYPE=remote/ssh
else
    case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) SESSION_TYPE=remote/ssh;;
    esac
fi

case $SESSION_TYPE in
    local)
        [ -x ~/.local_source ] &&  source ~/.local_source
        echo "[*] on $MYTTY"
        it2prof "$(hostname)"
        ;;
    local/tmux)
        [ -x ~/.local_source.tmux ] &&  source ~/.local_source.tmux
        ;;
    remote/tmux)
        [ -x ~/.local_source.tmux ] &&  source ~/.local_source.tmux
        ;;
    remote/ssh)
        [ -x ~/.local_source.ssh ] &&  source ~/.local_source.ssh
        echo "[*] on $MYTTY"
        [ -z "$LC_ITERM2_PROFILE_ALREADY_SET" ] && it2prof "$(hostname)"
        ;;
    *)
        [ -x ~/.local_source ] &&  source ~/.local_source
        ;;
esac

if ! hostisosx ; then
    export TMUXINATOR_CONFIG_OSX=~/.config/tmuxinator
    export TMUXINATOR_CONFIG_LINUX=~/.tmuxinator
    [ ! -f "$TMUXINATOR_CONFIG_LINUX" ] && [ ! -h "$TMUXINATOR_CONFIG_LINUX" ] && ln -svf $TMUXINATOR_CONFIG "$TMUXINATOR_CONFIG_LINUX"
fi
