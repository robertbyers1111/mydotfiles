MANPATH=$MANPATH:/usr/share/man

#
#    This can take anywhere from 1-60 seconds! ...
#
#    module load como/tools/git/ como/tools/emacs/26.1 como/python/3.6.1
#

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
#xport HISTTIMEFORMAT='%FT%T ' #iso8601 format
#If you want to use emacs as editor you may want to use emacsserver so it stays up in the background
#export EDITOR="emacsclient -nw -a '' -c -s default"
#xport HISTSIZE= HISTFILESIZE=
shopt -s histappend
shopt -s checkwinsize
