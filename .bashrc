# .bashrc

# Anything else that goes at an interactive prompt.  Command prompt, editor
# variables, aliases

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ll='ls -lh'
alias df='df -h'
alias du='du -h'

# Enable colors and set better colors for directory listings
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# Use syntax highlighting for less
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '

# Add Git to the prompt in an intelligent way
if [ -f ~/.gitprompt ]; then
    source ~/.gitprompt
fi
