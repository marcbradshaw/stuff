#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd
mkdir -p local
cd local
PREFIX=$PWD

cd $MYDIR
cd ../
pushd remote/git
    git pull
    make configure
    ./configure --prefix=$PREFIX
    make
    make install
popd

