#!/bin/bash

## Bash Functions

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

## vim Functiona

function add_to_vimrc {
 
    KEY=$1
    VALUE=$2

    if [ "$VALUE" == "" ]
    then
        FOUNDLINE=`grep -F -x "$KEY" ~/.vimrc`
    else
        # Not quite 100%, but close enough
        # Does not enforce whole line, FIXME
        FOUNDLINE=`grep -F "$KEY" ~/.vimrc`
    fi

    if [ "$FOUNDLINE" == "" ]
    then

        if [ "$VALUE" == "" ]
        then
            ADDLINE="$KEY"
        else
            ADDLINE="$KEY=$VALUE"
        fi

        echo Adding "$ADDLINE" to .vimrc
        echo "$ADDLINE" >> ~/.vimrc
    fi

}

function get_bundle_from_github {

    OWNER=$1
    PROJECT=$2

    echo "Processing $PROJECT"

    cd ~/.vim/bundle

    if [ ! -d $PROJECT ]
    then
        cd ~/.vim/bundle.old
        if [ -d $PROJECT ]
        then
            mv -i $PROJECT ../bundle/
        else
            cd ~/.vim/bundle
            git clone https://github.com/$OWNER/$PROJECT.git
        fi
    fi
    cd ~/.vim/bundle

    pushd $PROJECT
    git pull
    popd

}

function get_bundle_from_google_code {

    REPO=$1
    DIR=$2

    echo "Processing $REPO"

    cd ~/.vim/bundle

    if [ ! -d $DIR ]
    then
        cd ~/.vim/bundle.old
        if [ -d $DIR ]
        then
            mv -i $DIR ../bundle/
        else
            cd ~/.vim/bundle
            svn checkout http://$REPO.googlecode.com/svn/trunk/ $DIR
        fi
    fi
    cd ~/.vim/bundle

    pushd $DIR
    svn up
    popd

}

function hide_bundle {
    BUNDLE=$1

    echo "Processing $BUNDLE"

    cd ~/.vim/bundle
    if [ -d $BUNDLE ]
    then
        mv -i $BUNDLE ../bundle.old/
        echo "Moving bundle";
    fi
}


