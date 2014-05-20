
function FindSubs()
    lvimgrep  /^\s*sub /j %
    lvimgrepa /^\s*method /j %
    lopen
endfunction
command Subs call FindSubs() 

