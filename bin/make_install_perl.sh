#!/bin/bash

RELEASEBRANCH="maint-5.20"

cd ~/git

if [ ! -d perl5 ]
then
    git clone git@github.com:Perl/perl5.git
fi

cd perl5

git checkout $RELEASEBRANCH
git pull

make clean && \
sh Configure -Dprefix=/home/marc/perl5.20 -des && \
make && \
make test && \
make install

