#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
. functions.sh
cd ../

# Setup vim just the way I likes it
# Install the YouCompleteMe plugin
# Assumes vim-setup.sh has been run

## May need to install cmake and python libs
## sudo apt-get install build-essential cmake python-dev

APTGET=""

CMAKE=`which cmake`
if [ $CMAKE == "" ]
then
    APTGET="$APTGET cmake"
fi

if [ ! -d "/usr/share/build-essential" ]
then
    APTGET="$APTGET build-essential"
fi

if [ ! -d "/usr/share/doc/python-dev" ]
then
    APTGET="$APTGET python-dev"
fi

if [ ! $APTGET == "" ]
then
    sudo aptitude install $APTGET
fi

get_bundle_from_github Valloric YouCompleteMe
pushd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py
popd


