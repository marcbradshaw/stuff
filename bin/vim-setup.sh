#!/bin/bash

# Setup vim just the way I likes it

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
        git clone https://github.com/$OWNER/$PROJECT.git
    fi

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
        svn checkout http://$REPO.googlecode.com/svn/trunk/ $DIR
    fi

    pushd $DIR
    svn up
    popd

}

#
# Create directories if required
#

cd ~
mkdir -p .vim/bundle
mkdir -p .vim/autoload

cd ~/.vim/
if [ ! -e autoload/pathogen.vim ]
then
    git clone https://github.com/tpope/vim-pathogen.git
    ln -s ~/.vim/vim-pathogen/autoload/pathogen.vim ~/.vim/autoload/pathogen.vim
fi
pushd vim-pathogen
git pull
popd

add_to_vimrc "execute pathogen#infect()"

get_bundle_from_github jlanzarotta bufexplorer

get_bundle_from_github airblade vim-gitgutter
add_to_vimrc "let g:gitgutter_highlight_lines " " 0"
add_to_vimrc "set nu"

get_bundle_from_github tpope vim-fugitive

get_bundle_from_github scrooloose nerdtree

get_bundle_from_github scrooloose syntastic
add_to_vimrc "let g:syntastic_enable_perl_checker " " 0"
add_to_vimrc "syntax on"
add_to_vimrc "filetype plugin indent on"

get_bundle_from_github kien rainbow_parentheses.vim

get_bundle_from_github maxbrunsfeld vim-yankstack

get_bundle_from_google_code conque conque-read-only 

get_bundle_from_github xolox vim-misc
get_bundle_from_github xolox vim-session
add_to_vimrc "let g:session_autosave = 'no'"
add_to_vimrc "let g:session_autoload = 'no'"

get_bundle_from_github vim-perl vim-perl

get_bundle_from_github tpope vim-markdown

add_to_vimrc "set expandtab"
add_to_vimrc "set softtabstop" "4"
add_to_vimrc "set shiftwidth" "4"
add_to_vimrc "set tabpagemax" "500"
add_to_vimrc "set nocp"
add_to_vimrc "set showtabline" "2"

add_to_vimrc "autocmd BufEnter * :redraw!"
add_to_vimrc "autocmd BufWritePost * :redraw!"
add_to_vimrc "autocmd FocusGained * :redraw!"

add_to_vimrc "set foldmethod" "indent"
add_to_vimrc "set foldnestmax" "1"
add_to_vimrc "set nofoldenable"
add_to_vimrc "set foldlevel" "1"

