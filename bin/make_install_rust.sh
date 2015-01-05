#!/bin/bash

RELEASEBRANCH="master"

cd ~/git

if [ ! -d rust ]
then
    git clone git@github.com:rust-lang/rust.git
fi

cd perl5

git checkout $RELEASEBRANCH
git pull

make clean && \
./configure --prefix=/home/$USER/local && \
make && \
make test && \
make install

