#!/bin/bash

case "$TERM" in
    xterm-color|*-256color|xterm-ghostty) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

set_prompt() {
    local exit_status=$?
    
    local branch=$(git branch --show-current 2>/dev/null)
    
    local git_info=""
    if [ -n "$branch" ]; then
        git_info="\[\e[90m\] (\[\e[96;2m\]${branch}\[\e[0;90m\])"
    fi

    local arrow_color="\[\e[96;2m\]"
    if [ $exit_status -ne 0 ]; then
        arrow_color="\[\e[91;1m\]"
    fi

    PS1="\[\e[96;1m\]\W\[\e[0m\]${git_info}${arrow_color} >\[\e[0m\] "
}

PROMPT_COMMAND=set_prompt

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[96;1m\]\W\[\e[0m\]${PS1_GIT}${PS1_ARROW}'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac
