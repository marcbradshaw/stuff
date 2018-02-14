#!/bin/bash

alias vi=vim

export TERM='xterm-256color'

source ~/.bash/git-completion.bash
source ~/.bash/git-prompt.sh

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000000
HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND='history -a'

export EDITOR=vim
export PAGER=~/.vim/bundle/vimpager/vimpager

export PATH=~/bin:~/local/bin:~/MARC/stuff/bin:$PATH

if [ ! -f ~/.no-local-lib ]
then 
    if [ "$USER" != "root" ]
    then
        eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
    fi
fi

function __perl_version {
    perl -e 'print "$^V"'
}

PS1='\[\e[1;32m\]\u\[\e[1;31m\]@\h \[\e[1;35m\]$(__perl_version) \[\e[1;33m\]\w\[\e[1;31m\]$(__git_ps1 "(\[\e[1;32m\]%s\[\e[1;31m\])")\[\e[0m\]$ '
export GIT_PS1_SHOWDIRTYSTATE=1

function setup_ssh {

    AGENT_FILE="/run/user/$UID/ssh-agent"
    AGENT_FILE_TEMP="/run/user/$UID/ssh-agent-2"
    if [ ! -e "$AGENT_FILE" ] ; then
        echo "Starting SSH Agent"
        gpg-agent --daemon --enable-ssh-support --write-env-file $AGENT_FILE
        cat $AGENT_FILE | \
            sed -r "s|^GPG_AGENT_INFO=|export GPG_AGENT_INFO=|" | \
            sed -r "s|^SSH_AUTH_SOCK=|export SSH_AUTH_SOCK=|"   | \
            sed -r "s|^SSH_AGENT_PID=|export SSH_AGENT_PID=|"   > $AGENT_FILE_TEMP
        cat $AGENT_FILE_TEMP >> $AGENT_FILE
        rm $AGENT_FILE_TEMP
        chmod 600 $AGENT_FILE
    fi
    . $AGENT_FILE
}

alias ssh="setup_ssh;ssh"
alias git="setup_ssh;git"

