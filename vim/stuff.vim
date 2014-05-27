
function FindSubs()
    lvimgrep  /^\s*sub /j %
    lvimgrepa /^\s*method /j %
    execute "lopen " . (winheight(0)/2)
endfunction
command Subs call FindSubs() 

function TidyDiff()
    let TempFile = tempname()
    let SaveModified = &modified
    exe 'w ' . TempFile
    let &modified = SaveModified
    exe 'split ' . TempFile
    exe '%! ' . a:script
endfunction
command TidyDiff call TidyDiff('perltidy')

