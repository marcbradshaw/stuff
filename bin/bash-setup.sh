#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
. functions.sh
cd ../

# Setup bash just the way I likes it

#
# Create directories if required
#

cd ~
mkdir -p .bash

cd $MYDIR
cd ../
mkdir -p remote

mkdir -p ~/local/bin
mkdir -p ~/bin

get_from_github git git

cd $MYDIR
cp ../remote/git/contrib/completion/git-completion.bash ~/.bash
cp ../remote/git/contrib/completion/git-prompt.sh ~/.bash
cp ../bash/stuff.sh ~/.bash

add_to_bashrc "source ~/.bash/stuff.sh"

cd $MYDIR
cd ../
cp bin/git-pullsafe ~/bin/

get_from_github visionmedia git-extras
cd $MYDIR
pushd ../remote/git-extras
export PREFIX=~/local/
make install
popd

get_from_github cxreg smartcd
cd $MYDIR
pushd ../remote/smartcd
make install
popd

