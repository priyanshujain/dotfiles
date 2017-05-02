#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias icpc="cd /home/priyanshu/Workspace/ICPC"

alias ls='ls --color=auto'
alias sleep='echo -n mem >/sys/power/state'
PS1='[\u@\h \W]\$ '

alias ll='ls -alh --group-directories-first --color=always'

alias suspend='sudo systemctl suspend'
alias s='sudo systemctl'
alias grep='GREP_COLOR="1;33;40" LANG=C grep --exclude-dir=node_modules --color=auto'
