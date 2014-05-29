#!/bin/bash

PS1='\[\e[1;32m\]\u\[\e[1;31m\]@\h \[\e[1;33m\]\w\[\e[1;31m\]$(__git_ps1 "(\[\e[1;32m\]%s\[\e[1;31m\])")\[\e[0m\]$ '
export GIT_PS1_SHOWDIRTYSTATE=1

