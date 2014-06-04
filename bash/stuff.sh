#!/bin/bash

source ~/.bash/git-completion.bash
source ~/.bash/git-prompt.sh

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config

export EDITOR=vim

export PATH=~/bin:~/local/bin:~/MARC/stuff/bin:$PATH

eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)

PS1='\[\e[1;32m\]\u\[\e[1;31m\]@\h \[\e[1;33m\]\w\[\e[1;31m\]$(__git_ps1 "(\[\e[1;32m\]%s\[\e[1;31m\])")\[\e[0m\]$ '
export GIT_PS1_SHOWDIRTYSTATE=1

