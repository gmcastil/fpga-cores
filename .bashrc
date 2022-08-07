#!/bin/bash

# -- Function Definitions

# Tcl does not have readline support, so wrap it if it's available
tcl () {
    local tclsh=/usr/bin/tclsh
    local rlwrap=/usr/bin/rlwrap
    if [[ -x "$tclsh" && -x "$rlwrap" ]]; then
        "$rlwrap" -c "$tclsh"
    else
        "$tclsh"
    fi
}

# -- Set Bash Options

HISTSIZE=100000  # Disk space is cheap
HISTFILESIZE=200000

shopt -s checkwinsize  # Check window size after each command and update LINES
shopt -s histappend    # and COLUMNS if necessary

# -- Path Manipulation
export SCRIPTS_DIR=$HOME/scripts
export PATH=$HOME/.local/bin:$SCRIPTS_DIR:$PATH

# -- List Directory Colors
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# -- Aliases
if [[ -f $HOME/.bash_aliases ]]; then
    source $HOME/.bash_aliases
fi

# -- Colorize less output
LESS_COLOR=$HOME/.local/bin/src-hilite-lesspipe.sh
if [[ -x $LESS_COLOR ]]; then
    export LESSOPEN="| $LESS_COLOR %s"
    export LESS=" -R "
fi

# -- Custom prompt
if [[ -f $HOME/.prompt ]]; then
    source $HOME/.prompt
fi

# The coreutils package on Ubuntu 20.04 has started wrapping strings in its
# output with single quotes (') for reasons that are completely beyond me. Fix
# this behavior in interactie shells and set the quoting style to be literal.
# Yet another reason to never parse the output of the 'ls' command
export QUOTING_STYLE=literal

