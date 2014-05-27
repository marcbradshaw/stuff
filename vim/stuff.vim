
function FindSubs()
    lvimgrep  /^\s*sub /j %
    lvimgrepa /^\s*method /j %
    execute "lopen " . (winheight(0)/2)
endfunction
command Subs call FindSubs() 

function TidyDiff(script)

    let TempFile = tempname()
    let SaveModified = &modified
    exe 'w ' . TempFile
    let &modified = SaveModified

    exe 'vertical diffsplit ' . TempFile
    exe 'set modifiable'
    exe 'set noro'
    exe '%! ' . a:script
    exe 'w'
    exe 'set ro'
    exe 'set nomodifiable'
endfunction
command TidyDiff call TidyDiff('perltidy')

