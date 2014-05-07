#!/bin/bash

# Setup vim just the way I likes it

function add_to_vimrc {
 
    LINE=$1

    SEARCH=`grep "^$LINE$" ~/.vimrc`

    if [ "$LINE" != "$SEARCH" ]
    then
        echo Adding "$LINE" to .vimrc
        echo $LINE >> ~/.vimrc
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
add_to_vimrc "let g:gitgutter_highlight_lines = 1"
add_to_vimrc "set nu"

get_bundle_from_github tpope vim-fugitive

get_bundle_from_github scrooloose nerdtree

get_bundle_from_github scrooloose syntastic
add_to_vimrc "let g:syntastic_enable_perl_checker = 0"
add_to_vimrc "syntax on"
add_to_vimrc "filetype plugin indent on"

add_to_vimrc "set expandtab"
add_to_vimrc "set softtabstop=4"
add_to_vimrc "set shiftwidth=4"
add_to_vimrc "set tabpagemax=500"
add_to_vimrc "set nocp"
add_to_vimrc "set showtabline=2"

