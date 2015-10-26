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
get_bundle_from_github Valloric YouCompleteMe
pushd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py
popd


