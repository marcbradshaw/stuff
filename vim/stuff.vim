
function FindSubs()
    lvimgrep  /^\s*sub / %
    lvimgrepa /^\s*method / %
    lopen
endfunction
command Subs call FindSubs() 

