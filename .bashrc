#!/bin/bash

# Don't do stupid things
set -o errexit
set -o pipefail
set -o nounset

# Check window size after each command and update LINES and COLUMNS if necessary
shopt -s checkwinsize
shopt -s histappend

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

export PATH=$HOME/.loca/bin:$PATH

# Disk space is cheap
HISTSIZE=100000
HISTFILESIZE=200000

MOST_PATH=$(which most)
if [ -x "$MOST_PATH" ]; then
    export PAGER=most
fi

# Colorized man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}

# -- Source other files, if available
if [ -f $HOME/.prompt ]; then
    source $HOME/.prompt
fi

if [ -f $HOME/.toolsrc ]; then
    source $HOME/.toolsrc
fi

if [ -f $HOME/.alias ]; then
    source $HOME/alias
fi
