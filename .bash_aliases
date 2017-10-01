alias ls='ls --group-directories-first --color=auto'
alias ll='ls --group-directories-first -lohX --color=auto'
alias la='ls --group-directories-first -AolhX --color=auto'

alias mv='mv -v'
alias cp='cp -v'
alias du='du -h'
alias df='df -h'

alias seakr=/opt/cisco/anyconnect/bin/vpnui

alias kv="for i in \`ps aux | grep -i vivado | /bin/grep -v grep | awk '{print \$2;}'\` ; do kill -9 \$i; done"
alias kc="for i in \`ps aux | grep -i chrome | /bin/grep -v grep | awk '{print \$2;}'\` ; do kill -9 \$i; done"
alias kdz='for i in `ps aux | grep -i dzen2 | /bin/grep -v grep | awk '\''{print $2;}'\''` ; do kill -9 $i; done'
