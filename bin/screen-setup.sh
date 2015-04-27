#~/bin/bash

touch ~/.screenrc

if grep -q "termcapinfo xterm-unicode ti@:te@" ~/.screenrc
then
    echo -n
else
    echo "termcapinfo xterm-unicode ti@:te@" >> ~/.screenrc
fi

if grep -q "termcapinfo xterm ti@:te@" ~/.screenrc
then
    echo -n
else
    echo "termcapinfo xterm ti@:te@" >> ~/.screenrc
fi

if grep -q "termcapinfo xterm 'hs:ts=\\\E]2;:fs=07:ds=\\\E]2;screen07'" ~/.screenrc
then
    echo -n
else
    echo "termcapinfo xterm 'hs:ts=\E]2;:fs=07:ds=\E]2;screen07'" >> ~/.screenrc
fi

