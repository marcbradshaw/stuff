#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd
mkdir -p local
cd local
PREFIX=$PWD

# sudo aptitude install libevent-dev ncurses-dev

cd $MYDIR
cd ../
pushd remote
  if [ ! -d tmux ]
  then
    git clone https://github.com/tmux/tmux.git
  fi
  pushd tmux
    git pull &&
    sh autogen.sh &&
    ./configure --prefix=$PREFIX &&
    make &&
    make install
  popd
popd
