#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd
mkdir -p local
cd local
PREFIX=$PWD

cd $MYDIR
cd ../
pushd remote
  if [ ! -d vim ]
  then
    git clone https://github.com/vim/vim.git
  fi
  pushd vim/src
    git pull &&
    make distclean &&
    make configure &&
    ./configure --prefix=$PREFIX --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu &&
    make &&
    make install
  popd
popd
