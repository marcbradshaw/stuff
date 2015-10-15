#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
cd ../

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

#
# Create directories if required
#

cd ~
mkdir -p .vim/bundle
mkdir -p .vim/bundle.old
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

#get_bundle_from_github jlanzarotta bufexplorer
hide_bundle bufexplorer

get_bundle_from_github airblade vim-gitgutter
add_to_vimrc "let g:gitgutter_highlight_lines " " 0"
add_to_vimrc "set nu"

get_bundle_from_github tpope vim-fugitive

#get_bundle_from_github scrooloose nerdtree
hide_bundle nerdtree

get_bundle_from_github scrooloose syntastic
add_to_vimrc "let g:syntastic_enable_perl_checker " " 0"
add_to_vimrc "syntax on"
add_to_vimrc "filetype plugin indent on"

get_bundle_from_github kien rainbow_parentheses.vim
#hide_bundle rainbow_parentheses.vim
add_to_vimrc "au VimEnter * RainbowParenthesesToggle"
add_to_vimrc "au Syntax * RainbowParenthesesLoadRound"
add_to_vimrc "au Syntax * RainbowParenthesesLoadSquare"
add_to_vimrc "au Syntax * RainbowParenthesesLoadBraces"

# get_bundle_from_github maxbrunsfeld vim-yankstack
hide_bundle vim-yankstack

get_bundle_from_google_code conque conque-read-only 

# get_bundle_from_github xolox vim-misc
# get_bundle_from_github xolox vim-session
# add_to_vimrc "let g:session_autosave = 'no'"
# add_to_vimrc "let g:session_autoload = 'no'"
hide_bundle vim-misc
hide_bundle vim-session

get_bundle_from_github vim-perl vim-perl

get_bundle_from_github tpope vim-markdown

get_bundle_from_github hotchpotch perldoc-vim

get_bundle_from_github bling vim-airline
add_to_vimrc "let g:airline#extensions#tabline#enabled = 1"
add_to_vimrc "set laststatus=2"
add_to_vimrc "let g:airline_powerline_fonts = 1"

mkdir -p ~/.vim/tmp
pushd ~/.vim/tmp
git clone https://github.com/powerline/fonts.git
cd fonts
git pull
./install.sh
popd

add_to_vimrc "set expandtab"
add_to_vimrc "set softtabstop" "4"
add_to_vimrc "set shiftwidth" "4"
add_to_vimrc "set tabpagemax" "500"
add_to_vimrc "set nocp"
add_to_vimrc "set showtabline" "2"

pushd $MYDIR
cp ../vim/stuff.vim ~/.vim/
popd
add_to_vimrc "source ~/.vim/stuff.vim"


# add_to_vimrc "autocmd BufEnter * :redraw!"
# add_to_vimrc "autocmd BufWritePost * :redraw!"
# add_to_vimrc "autocmd FocusGained * :redraw!"

# add_to_vimrc "set foldmethod" "indent"
# add_to_vimrc "set foldnestmax" "1"
# add_to_vimrc "set nofoldenable"
# add_to_vimrc "set foldlevel" "1"

