#!/bin/bash
case "$TERM" in
    xterm-color|*-256color|xterm-ghostty) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)';

if [ "$color_prompt" = yes ]; then
    PS1='\[\e[96;1m\]\W\[\e[0m\] \[\e[90m\](\[\e[96;2m\]${PS1_CMD1}\[\e[0;90m\])\[\e[96;2m\]>\[\e[0m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export TERM=xterm-256color
