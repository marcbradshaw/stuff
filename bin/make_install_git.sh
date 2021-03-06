#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd
mkdir -p local
cd local
PREFIX=$PWD

cd $MYDIR
cd ../
pushd remote
  if [ ! -d git ]
  then
    git clone https://github.com/git/git.git
  fi
  pushd git
    git pull &&
    make configure &&
    ./configure --prefix=$PREFIX &&
    make &&
    make install
  popd
popd
