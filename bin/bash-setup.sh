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

get_from_github git git

cd $MYDIR
cp ../remote/git/contrib/completion/git-completion.bash ~/.bash
cp ../remote/git/contrib/completion/git-prompt.sh ~/.bash

add_to_bashrc "source ~/.bash/git-completion.bash"
add_to_bashrc "source ~/.bash/git-prompt.sh"

get_from_github cxreg smartcd
cd $MYDIR
pushd ../remote/smartcd
make install
popd

add_to_bashrc "PS1" "'\[\e[1;32m\]\u\[\e[1;31m\]@\h \[\e[1;33m\]\w\[\e[1;32m\]\$(__git_ps1 \"(%s)\")\[\e[0m\]$ '"
add_to_bashrc "export GIT_PS1_SHOWDIRTYSTATE=1"

