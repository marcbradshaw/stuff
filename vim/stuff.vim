
function FindSubs()
    lvimgrep  /^\s*sub /j %
    lvimgrepa /^\s*method /j %
    execute "lopen " . (winheight(0)/2)
endfunction
command Subs call FindSubs() 

