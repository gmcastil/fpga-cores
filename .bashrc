#!/bin/bash

# -- Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# --- Aliases
alias ls='ls --color=auto'
alias ll='ls -lhX --color=auto'
alias la='ls -alhX --color=auto'

alias mv='mv -v'
alias cp='cp -v'
alias du='du -h'
alias df='df -h'

# --- Setup path
export PATH=$HOME/.loca/bin:$PATH

# --- Bash

# Disk space is cheap
HISTSIZE=100000
HISTFILESIZE=200000

# Check window size after each command and update LINES and COLUMNS if necessary
shopt -s checkwinsize
shopt -s histappend

MOST_PATH=$(which most)
if [ -x "$MOST_PATH" ]; then
    export PAGER=most
fi

# --- Prompt
if [ -f $HOME/.prompt ]; then
    source $HOME/.prompt
fi

# --- HDL tools
if [ -f $HOME/.toolsrc ]; then
    source $HOME/.toolsrc
fi
