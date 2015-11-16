#!/bin/bash

MYDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $MYDIR
. functions.sh
cd ../

# Setup vim just the way I likes it

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

get_bundle_from_github scrooloose nerdtree
#hide_bundle nerdtree

get_bundle_from_github scrooloose nerdcommenter

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

get_bundle_from_github vim-scripts YankRing.vim

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
add_to_vimrc "set backspace=indent,eol,start"

pushd $MYDIR
cp ../vim/stuff.vim ~/.vim/
popd
add_to_vimrc "source ~/.vim/stuff.vim"

add_to_vimrc "set term=xterm-256color"

# add_to_vimrc "autocmd BufEnter * :redraw!"
# add_to_vimrc "autocmd BufWritePost * :redraw!"
# add_to_vimrc "autocmd FocusGained * :redraw!"

# add_to_vimrc "set foldmethod" "indent"
# add_to_vimrc "set foldnestmax" "1"
# add_to_vimrc "set nofoldenable"
# add_to_vimrc "set foldlevel" "1"

