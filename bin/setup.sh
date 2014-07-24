#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
cd ../

bin/vim-setup.sh
bin/bash-setup.sh
bin/perl-setup.pl

