alias ls='ls -oh --color=auto --group-directories-first'
alias ll='ls -ohl --color=auto --group-directories-first'
alias la='ls -Aohl --color=auto --group-directories-first'

alias mv='mv -v'
alias cp='cp -v'
alias du='du -h'
alias df='df -h'

alias seakr=/opt/cisco/anyconnect/bin/vpnui

alias kv="for i in \`ps aux | grep -i vivado | /bin/grep -v grep | awk '{print \$2;}'\` ; do kill -9 \$i; done"
alias kc="for i in \`ps aux | grep -i chrome | /bin/grep -v grep | awk '{print \$2;}'\` ; do kill -9 \$i; done"
alias kdz='for i in `ps aux | grep -i dzen2 | /bin/grep -v grep | awk '\''{print $2;}'\''` ; do kill -9 $i; done'

# Suppress the drivel that some programs insist on spewing to the console
alias vlc="vlc > /dev/null 2>&1"
alias chrome="google-chrome > /dev/null 2>&1"
