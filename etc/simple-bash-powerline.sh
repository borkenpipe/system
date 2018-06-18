#!/usr/bin/env bash

[ -z "$BG_GREEN" ] && [ -r $HOME/bin/common/color_env_set.sh ] && source  $HOME/bin/common/color_env_set.sh

__powerline() {

    # what OS?
    case "$(uname)" in
        Darwin)
            readonly PS_SYMBOL=$PS_SYMBOL_DARWIN
            ;;
        Linux)
            readonly PS_SYMBOL=$PS_SYMBOL_LINUX
            ;;
        *)
            readonly PS_SYMBOL=$PS_SYMBOL_OTHER
    esac

    __git_info() { 
        [ -x "$(which git)" ] || return    # git not found

        local git_eng="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$($git_eng symbolic-ref --short HEAD 2>/dev/null || $git_eng describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        local marks

        # branch is modified?
        [ -n "$($git_eng status --porcelain)" ] && marks+=" $GIT_BRANCH_CHANGED_SYMBOL"

        # how many commits local branch is ahead/behind of remote?
        local stat="$($git_eng status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        local aheadN="$(echo $stat | grep -o 'ahead [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        local behindN="$(echo $stat | grep -o 'behind [[:digit:]]\+' | grep -o '[[:digit:]]\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        printf " $GIT_BRANCH_SYMBOL$branch$marks "
    }

    __customhostname() {
        SSH_HOST=$FG_GREEN
        BG_HOST="" #$(getservercolor $(hostname)) # TODO needs to be fixed, messes up CL
        [ -d /proc ] && cat /proc/$PPID/status | head -1 | cut -f2 | grep -vq sshd && SSH_HOST=$FG_MAGENTA
        [ -d /proc ] && cat /proc/$PPID/status | head -1 | cut -f2 | grep -vq tmux  && SSH_HOST=$FG_BLUE
        [ -z "$BG_HOST" ] && BG_HOST=$BG_BLACK
        FG_USER=$FG_GREEN
        whoami | grep -q root && FG_USER=$FG_RED
        printf "$FG_USER$USER$FG_YELLOW@$BG_HOST$SSH_HOST\h$RESET"
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly. 

        PREV_RET_VAL=$?
        mystatus=""
        if [ $PREV_RET_VAL -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
            mystatus=""
        else
            #play -qn synth sin E2 trim 0 0.25
            local BG_EXIT="$BG_RED"
            mystatus="($PREV_RET_VAL)"
        fi
        #printf "$BG_EXIT$FG_BASE3 $PS_SYMBOL " # $statusoutput $RESET X"
        EXIT_STATUS="$BG_EXIT$FG_BASE3$PS_SYMBOL $mystatus $RESET"
        PS1="$BG_BASE1$FG_BASE3$(__customhostname)$RESET"
        PS1+="$BG_BLACK$FG_BASE3 $PWD $RESET"
        PS1+="$BG_BLUE$FG_BASE3$(__git_info)$RESET"
        PS1+="$EXIT_STATUS "
    }
    PROMPT_COMMAND=ps1
}

__powerline
unset __powerline
