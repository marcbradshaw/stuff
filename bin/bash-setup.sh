#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
cd ../

# Setup vim just the way I likes it

function add_to_bashrc {
 
    KEY=$1
    VALUE=$2

    if [ "$VALUE" == "" ]
    then
        FOUNDLINE=`grep -F -x "$KEY" ~/.bashrc`
    else
        # Not quite 100%, but close enough
        # Does not enforce whole line, FIXME
        FOUNDLINE=`grep -F "$KEY" ~/.bashrc`
    fi

    if [ "$FOUNDLINE" == "" ]
    then

        if [ "$VALUE" == "" ]
        then
            ADDLINE="$KEY"
        else
            ADDLINE="$KEY=$VALUE"
        fi

        echo Adding "$ADDLINE" to .bashrc
        echo "$ADDLINE" >> ~/.bashrc
    fi

}

function get_from_github {

    OWNER=$1
    PROJECT=$2

    echo "Processing $PROJECT"

    cd $MYDIR
    cd ../remote

    if [ ! -d $PROJECT ]
    then
        git clone https://github.com/$OWNER/$PROJECT.git
    fi

    pushd $PROJECT
    git pull
    popd

}

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

