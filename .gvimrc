if has("msdos") || has("win32") || has("win64")
    if hostname() =~ "^RmbInspiro"
        source c:\Users\rmbjr60\_gvimrc_rbyers
    elseif hostname() =~ "^DS903039"
        source c:\Users\DS903039\_gvimrc_rbyers
    endif
else
    source ~/.gvimrc_rbyers
endif
