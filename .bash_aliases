#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# NOTE: To pass an arg in the middle of an alias, you need to create a function as in this example..
#
#    alias last2='function _(){ ls -lt $1 |  tail -2; }; _'
#
# NOTE: all "/usr/bin" have been shortened to "/bin", which assumes the current OS has implemented the
# /usr merge project discussed here: https://www.freedesktop.org/wiki/Software/systemd/TheCaseForTheUsrMerge/
#
# Uhh Oh! RLEL6 never implemented the /usr merge, and Mediatek *still* uses (in 2021) RHEL6 (btw, wtf?)
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
shopt -s nocasematch

[ _$HOSTNAME = _ ] && export HOSTNAME=`hostname`

case $HOSTNAME in
    RmbInspiro2018) :
        export BBHOME=/home/rmbjr60
    ;;
    ds903039-l01) :
        export BBHOME=/c/Users/ds903039
    ;;
    RB-EL*) :
        export BBHOME=/home/rbyers
        export MTKGIT=/mtkoss/como/tools/git/2.32.0/bin
    ;;
esac

export PUBLIC_HTML=$BBHOME/public_html
export MEGA=$BBHOME/MEGA/MEGAsync
export BBBIN=$BBHOME/bin

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# These *should* work anywhere

alias -- -="cd -"
alias ..........="cd ../../../../.."
alias ........="cd ../../../.."
alias ......="cd ../../.."
alias ....="cd ../.."
alias ..="cd .."

alias a2d="ascii2dec"
alias brm="$BBBIN/.brm.sh"
alias cols="tput cols"
alias cp="cp -ip"
alias d2a="dec2ascii"
alias d2h="dec2hex"
alias del="rm"
alias dus="$BBBIN/.dus.sh"
alias fh="file -h"
alias grep="grep -E --color=auto"
alias gwenview="echo .local/share/Trash/{info,files} ; /bin/gwenview ; echo .local/share/Trash/{info,files}"
alias h2d="hex2dec"
alias igrep="grep -Ei --color=auto"
alias lssz="l -Sr | .commify"
alias lstr="l -tr"
alias l="/bin/ls --time-style=\"+%Y-%m-%d %H:%M:%S\" --group-directories-first -lLFANGv"
alias mc="echo did you really want to launch midnight commander?"
alias mkdir="mkdir -p"
alias mv='mv -i'
alias rows="tput lines"
alias rowcols="echo `tput lines` `tput cols`"
alias ssh="ssh -A"
alias tf="tail -250f"
alias wcl="wc -l"
alias which="type"

alias .256sum="sha256sum"
alias .DisplayFilterForWireshark=" echo \"!dns&&!igmp&&!tcp&&!ipv6&&!cdp&&!nbns&&!browser&&!lldp\""
alias .PROMPT_simplify='export PS1="% "'
alias .alias="unalias -a ; gvim -f ~/.bash_aliases ; . ~/.bash_aliases"
alias .bashrc="vim $BBHOME/.bashrc_rmbjr60"
alias .bin="pushd $BBBIN"
alias .btc="sudo bluetoothctl"
alias .clipboardgvim="gvim -s $BBBIN/clipboardpaste.vim"
alias .commify="$BBBIN/commify"
alias .diff="meld"
alias .downloads="pushd $BBHOME/Downloads"
alias .ffx="firefox&"
alias .history="history | sort -k1.9 -V | grep -i"
alias .ifconfig="ifconfig | grep inet\ "
alias .ld="l | grep ^d"
alias .lsof_tcp="sudo lsof -i -P -n | sort -k1.56 -Vru"
alias .myfixXtermTitle=". $BBBIN/UTY_myfixXtermTitle.sh"
alias .now='now -nc'
alias .pd="popd ; dirs | sed 's/^[^ 	][^ 	]*//' | sed 's/^$/(dir stack now empty)/' | sed 's/^[^(].*//'"
alias .s256sum="sha256sum"
alias .shasum='shasum --algorithm 256'
alias .showmount="findmnt"
alias .sudo_bash="/bin/sudo -i /bin/bash"
alias .tf="tail -250f"
alias .tmp="pushd $BBHOME/tmp"
alias .vimrc="gvim $BBHOME/.vimrc_rbyers"

# git aliases

SAVEPATH=$PATH
export PATH=/mtkoss/como/tools/git/2.32.0/bin:${PATH}

/bin/which -a git > /dev/null 2>&1
[ $? -eq 0 ] && {

    alias .git='pushd $MEGA/git'
    alias .gLog="echo ; git branch --verbose ; echo ; git log --graph --oneline --all --decorate=full"
    alias .gs="echo -n Repository:  ; basename \`git rev-parse --show-toplevel\` ; git status"
    alias .gtree="git ls-tree --long -r"
    alias .grepository="git rev-parse --show-toplevel"

    # alias .grepository="UTY_grepository.sh"
    # (...until I get UTY_grepository.sh imported to RB-EL6)

    [ -d $PUBLIC_HTML/git ] && {

        alias ,githelp='pushd $PUBLIC_HTML/git'

        [ -f $PUBLIC_HTML/git/git-log-formatting.sh ] && {
            alias ,gFormattingOfGitLogResults='$PUBLIC_HTML/git/git-log-formatting.sh'
        }

        [ -f $PUBLIC_HTML/github/howtos/gitnotes/gitnotes.md ] && {
            alias ,gNotesFoundOnInternetwork='retext --preview $PUBLIC_HTML/github/howtos/gitnotes/gitnotes.md &'
        }
    }

    [ -d $BBHOME/GitAhead ] && {
        alias .gahead="$BBHOME/GitAhead/GitAhead &"
    }
}
export PATH=$SAVEPATH

# Python

alias .py='pushd $PUBLIC_HTML/python'
alias ,minimal_python='cat $PUBLIC_HTML/python/minimal.py'
[ -f $BBBIN/UTY_practicePython.sh ] && {
    .  $BBBIN/UTY_practicePython.sh
}

# screen

/bin/which -a screen > /dev/null 2>&1
[ $? -eq 0 ] && {
    alias .sl="screen -list"
    alias .sr="screen -R"
}

# gnuplot

/bin/which -a gnuplot > /dev/null 2>&1
[ $? -eq 0 ] && {
    [ -f $PUBLIC_HTML/gnuplot/gnuplot_help.txt ] && alias ,gnuplothelp="cat $PUBLIC_HTML/gnuplot/gnuplot_help.txt"
}

# apt, aptitude and dpkg

alias .installed_apt="( aptitude search \"?installed\" ; echo aptitude search \\\"\?installed\\\" )"
alias .installed_filt="grep -h status.installed /var/log/dpkg* | grep -v 'installed (lib|crypts|texlive|font|desktop-file-utils|doc-base|ghostscript|gnome-menus:|hicolor-icon-theme|initramfs-tools|linux-|man-db:|mime-support:all|mintsystem:all|pulesaudio|python2|samba-|secureboot|sgml|shared-mime-info|systemd:|tex-common|ubuntu-|uuid-|x11proto-|zlib1g)' | sort -V"
alias .installed_unfilt="grep -h status.installed /var/log/dpkg* | sort -V"
alias .aptup="sudo apt update && sudo apt upgrade -y"
alias .notinstalled="( echo aptitude search \\\"\?not\(\?installed\)\\\" ; aptitude search \"?not(?installed)\" ; echo aptitude search \\\"\?not\(\?installed\)\\\" )"
alias ,aptitude='cat $PUBLIC_HTML/unix/aptitude.txt'
alias ,dpkg='cat $PUBLIC_HTML/unix/dpkg.txt'

# public_html

alias .public='pushd $PUBLIC_HTML'
alias .unix='pushd $PUBLIC_HTML/unix'
alias .vimhelp='pushd $PUBLIC_HTML/vim'
alias ,GrepCheat='cat $PUBLIC_HTML/unix/grep-cheat.txt'
alias ,History='cat $PUBLIC_HTML/bash/historyExpansion.txt'
alias ,Touch='cat $PUBLIC_HTML/unix/touch.txt'
alias ,ascii='cat $PUBLIC_HTML/Uncataloged/0-ASCII.txt'
alias ,awk='cat $PUBLIC_HTML/unix/awk.txt'
alias ,bobcheat="pushd $PUBLIC_HTML"
alias ,case='cat $PUBLIC_HTML/bash/caseDemo.sh'
alias ,eatargs='cat $PUBLIC_HTML/bash/eatargs.sh'
alias ,exitstatus='grep YES $PUBLIC_HTML/unix/grep-cheat.txt'
alias ,for='cat $PUBLIC_HTML/bash/for_viaCmdLine_linuxAndWindows.txt'
alias ,grepcheat='cat $PUBLIC_HTML/unix/grep-cheat.txt'
alias ,if="cat $BBBIN/if_.txt"
alias ,keyboardshortcuts='retext --preview $PUBLIC_HTML/linux-mint/gnome-keyboard-shortcuts.md &'
alias ,mktemp='cat $PUBLIC_HTML/unix/mktemp.txt'
alias ,read='cat $PUBLIC_HTML/bash/read_file_or_pipe.sh'
alias ,sort='cat $PUBLIC_HTML/unix/sort.txt | tail -16'
alias ,ssh='cat $PUBLIC_HTML/unix/ssh.txt'
alias ,tab="echo Ctrl-V+tab"
alias ,while=' cat $PUBLIC_HTML/bash/while.sh'

# Hostname-specific alieases

case $HOSTNAME in
    RmbInspiro2018) :
        alias .314159="pushd $MEGA/314159"
        alias .copyq="flatpak run com.github.hluk.copyq"
        alias .fg="firefox --no-remote -P funiculargoat &"
        alias .mega="pushd $MEGA"
        alias .music="pushd /media/rmbjr60/Silver_Blue_2T/BKUPS/MrKitesS8/Card/Music"
        alias .ndmoviefind="cat /media/rmbjr60/Seagate\ Backup\ Plus\ Drive/AppData/Local/GitHub/NonCached_a2a65d850739bc178b2eb13c3e2a9faafea2f9143c0/INDEX.txt | grep -Eiv \"jpg|jpeg|\.zip|\.rar|\.png|\.gif|\.bmp|thumbs.db\" |grep -i "
        alias .ndphotofind="cat /media/rmbjr60/Seagate\ Backup\ Plus\ Drive/AppData/Local/GitHub/NonCached_a2a65d850739bc178b2eb13c3e2a9faafea2f9143c0/INDEX.txt | grep -Eiv \"\.mkv|\.iso|\.wmv|\.avi\" | grep -i "
        alias .ndpushd="pushd /media/rmbjr60/Silver_Blue_2T/AppData/Local/GitHub/NonCached_a2a65d850739bc178b2eb13c3e2a9faafea2f9143c0/2move2/2move2/2move2/2move2/2move2/2move2/2move3/vids"
        alias .pdfreader="xreader"
        alias .resumes="pushd $BBHOME/JobHunt2021/resumes"
        alias .src="pushd $MEGA/source/repos"
        alias .videos="pushd $BBHOME/Videos"
    ;;

    rb-el*) :
        alias .cmakeload='. $BBBIN/UTY_cmakeload.sh'
        alias .ct='export JWRC1CT=/jenkins/workspace/repos/c1/coretracer && mkdir $JWRC1CT 2>&1 > /dev/null ; pushd $JWRC1CT'
        alias gvim='/bin/gvim -geometry=184x45+4+118'
        alias .ctdir='export JWRC1CT=/jenkins/workspace/repos/c1/coretracer && mkdir $JWRC1CT 2>&1 > /dev/null ; pushd $JWRC1CT'
        alias .ctlaunch='.ctdir; module load Thor/CoreTracer/1.0.0.beta; CoreTracer'
        alias .jwr='pushd /jenkins/workspace/repos'
        alias .moduleload='module load como/tools/git/ como/tools/emacs/26.1 como/python/3.6.1'
        alias .today='pushd $BBHOME/working_directory/today'
        #lias .cmake_module='echo moudule load /jenkins/workspace/repos/dsptk/cmake-deps.module'
        #lias .search_logfile_for_errors='gvim -s ~/bin/searchfor_ERROR.vim'
    ;;

esac

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# PracticePython v0.3
#
# practice_python_via_github_uty()
# {
#     PYHELPDIR=~/public_html/python
#     PRACTICEDIR=PracticePython
#     PRACTICEFULLPATHR=$PYHELPDIR/$PRACTICEDIR
#     [ ! -d $PRACTICEFULLPATHR ] && {
#         echo Creating $PRACTICEFULLPATHR
#         mkdir -p $PRACTICEFULLPATHR
#         cd $PRACTICEFULLPATHR
#         cd ..
#         git clone git@github.com:robertbyers1111/PracticePython.git
#     }
#     pushd $PRACTICEFULLPATHR > /dev/null
#     echo "pwd: `pwd | sed 's@/home/[^/][^/]*/@~/@'`"
#     git status
# }
#
# alias .practice_python=practice_python_via_github_uty

#-----------------------------------------------------------------------
#--
#-- Oddity with tab completion..
#--
#-- This alias fails filename tab completion (but not directory tab completion)
#--
#--      alias gv="gvim -geom=999x222"
#--
#-- Root cause (I think) has to do with the following that show up in
#-- my shell..
#--
#--    % declare -p|grep "\bgv\b"
#--    [gv]="!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?(.gz|.GZ|.bz2|.BZ2|.Z))"
#--
#--    % complete |grep -i " gv$"
#--    complete -F _filedir_xspec gv
#--
#-- ..I found this definition is coming from.
#--
#--     % grep -E "\bgv\b" /usr/share/bash-completion/bash_completion 
#--    _install_xspec '!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?(.gz|.GZ|.bz2|.BZ2|.Z))' gv ggv kghostview
#--
#--
#-- Workaround is to add *BOTH* of these to .bashrc..
#--
#--     compopt -o bashdefault gv
#--     complete -F _filedir_xspec gv
#--
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
#-- [OLD]
#-- I no longer use this due to finding the --time-style feature of /bin/ls
#--
#--    This is a function because aliases don't accept positional parameters
#--
#--    lsalfunc () {
#--     /bin/ls --full-time --group-directories-first -lLFAGv $* | /bin/sed 's/.[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9] [+-][0-9].[0-9][0-9]//'
#--    }
#--
#--  alias l="lsalfunc"

#------------------------------------------------------------
#-- OLD..
#
#   alias cols="stty -a |head -1 |sed 's/.*columns \([0-9][0-9]*\).*/\1/'"
#   alias cols="stty -a |head -1 |sed 's/.*columns \([0-9][0-9]*\).*/\1/'"
#   alias dus="du -h --max-depth=1 . | sort -h"
#   alias dus="du -h --max-depth=1 . | sort -h" (dus.sh allows $1 instead of hard-coded '.')
#   alias find="/usr/bin/find -xdev"
#   alias gv="gvim -geom=999x222"
#   alias gwenview="echo .local/share/Trash/{info,files} ; /usr/bin/gwenview ; echo .local/share/Trash/{info,files}"
#   alias jj="JJscreen.tcl"
#   alias lc="~rmbjr60/bin/lsal | commify"
#   alias lc="$RMBJR60/bin/lsal | commify"
#   alias lstr="~rmbjr60/bin/lsal -tr"
#   alias l="~rmbjr60/bin/lsal"
#   alias pycharm="~rmbjr60/pycharm/bin/pycharm.sh"
#   alias pycharm="pycharm.sh&"
#   alias rowcols="stty -a | head -1 | cut -d\; -f2-3 | sed 's/;/R x /' | sed -r 's/(rows |columns)//g' | sed 's/  *//g' | sed 's/$/C/'"
#   alias rowcols="stty -a | head -1 | cut -d\; -f2-3 | sed 's/;/R x /' | sed -r 's/(rows |columns)//g' | sed 's/  *//g' | sed 's/$/C/'"
#   alias rows="stty -a | head -1 | sed 's/.*; rows  *\([0-9][0-9]*\);  *columns.*/\1/'"
#   alias rows="stty -a | head -1 | sed 's/.*; rows  *\([0-9][0-9]*\);  *columns.*/\1/'"
#   alias todo="todo.sh"
#   alias vi="gvim -geom=999x222"
#   alias vi="vim -X"
#
#   alias .1="pushd `cat $RMBJR60/.workdir1rc`"
#   alias .PGE="pushd $RMBJR60/src/pge/patchutils"
#   alias .Screen="cat $PUBLIC_HTML/unix/screen.txt"
#   alias .Vimdiff="cat $PUBLIC_HTML/vim/vimdiff.txt"
#   alias .Vnew='vim -X `/bin/ls -1t | /usr/bin/head -1`'
#   alias .Vtemp='vim -X `tempfile -d. -m644 -pzz -s.tmp`'
#   alias .ac="gvim $MEGA/314159/AC-PBGATG0-100C.ahk"
#   alias .activate=". ~/TeamDrive/Python-2018/Selenium/bin/activate; . ~/.promptrc; pushd ~/TeamDrive/Python-2018/Selenium"
#   alias .ahk='gvim -geom 999x222 $RMBJR60/TeamDrive/314159/AC-PBGATG0-100C.ahk'
#   alias .akatest="pushd $RMBJR60/akatest"
#   alias .anyconnect="sudo openconnect --user=rbyers --authgroup=iRobot-VPN vpn.irobot.com"
#   alias .asearch="aptitude search"
#   alias .bkups="pushd $RMBJR60/TeamDrive/BKUPS/RmbInspiro2018"
#   alias .comm="cat $PUBLIC_HTML/unix/comm.txt"
#   alias .deleteme_now="pushd $RMBJR60/deleteme_now"
#   alias .documents="pushd $RMBJR60/Documents"
#   alias .dos2unix="dos2unix --force --keepdate"
#   alias .dus="du -hx --max-depth=1 . | sort -h"
#   alias .eclipse="$RMBJR60/eclipse/cpp-2020-09/eclipse/eclipse"
#   alias .findallFiles="sudo find /bin /etc /home /lib* /opt /root /sbin /srv /usr /var"
#   alias .findhelp="cat $PUBLIC_HTML/unix/find.txt"
#   alias .glances="$RMBJR60/bin/UTY_myfixXtermTitle.sh glances; glances --enable-irq --time 5 --process-short-name --fs-free-space"
#   alias .gv="gvim -geom=999x222"
#   alias .gzip="gzip -v"
#   alias .hash='cat $PUBLIC_HTML/perl/hash.pl'
#   alias .history="cat $PUBLIC_HTML/sh/historyExpansion.txt ; history | grep -i"
#   alias .if="cat $PUBLIC_HTML/sh/if_.txt"
#   alias .irobertx="ssh -Y irobert@irobert"
#   alias .irobert="ssh irobert@irobert"
#   alias .line="wine $RMBJR60/.wine/drive_c/users/rmbjr60/Local\ Settings/Application\ Data/LINE/bin/current/LINE.exe &"
#   alias .logs="pushd ~/iRobot/logs"
#   alias .lurchdart="ssh root@lurchdart"
#   alias .lurchnav="ssh root@lurchnav"
#   alias .nd=". ~/bin/.newBranchSwitchTo.sh"
#   alias .pathshow='echo $PATH | tr : \\n | grep -n .  | sed "s/:/: /" | sed "s/^\([1-9]:\)/ \1/"'
#   alias .pide="gvim -geom=999x222 -p2 -s ~/.vim/vimrc_pide"
#   alias .po="popd ; dirs | sed 's/^[^ 	][^ 	]*//' | sed 's/^$/(dir stack now empty)/' | sed 's/^[^(].*//'"
#   alias .poop="cat $PUBLIC_HTML/perl/Poop3/Poop3.pm ; cat $PUBLIC_HTML/perl/Poop3/usePoop3.pl"
#   alias .practice_python="( cd ~/public_html/python/Practice ; cp TEMPLATE.py test_\`date +%Y-%m%d-%H%M\`.py ; chmod +x test_\`date +%Y-%m%d-%H%M\`.py ; gvim test_\`date +%Y-%m%d-%H%M\`.py )"
#   alias .pycharm="pycharm.sh >> ~/logs/pycharm.log 2>&1 &"
#   alias .rabbit="pushd ~/iRobot/rabbit"
#   alias .resumes="pushd $RMBJR60/TeamDrive/Jobs/Resumes/2018"
#   alias .6780l="ssh -X rbyers@irbt-6780l"
#   alias .8758l="ssh -Yvvv -E ~/.ssh/logs/ssh-\`date +%Y-%m%d-%H%M%S-%N\`.log irobert@irbt-8758l"
#   alias .zubuntulinux=.8758l
#   alias .robotcfg="gvim ~/rabbit/config/robot/ROBOTCFG.py"
#   alias .rpmcheat="~rmbjr60/public_html/unix/rpm.sh"
#   alias .script='. $BBHOME/bin/UTY_scriptutil.sh'
#   alias .scripts="pushd $RMBJR60/akatest/scripts"
#   alias .splitpide="gvim -geom=999x222 -O2 -s ~/.vim/vimrc_splitpide"
#   alias .tailhist="history | tail -32"
#   alias .teamdrive="pushd ~/TeamDrive"
#   alias .tools="pushd $RMBJR60/akatest/tools"
#   alias .ubuntulinuxx11="ssh -YJ rbyers@irbt-9123m rbyers@ubuntu-linux"
#   alias .ubuntulinuxx11="ssh -Y rbyers@ubuntu-9123m"
#   alias .ubuntulinux="ssh rbyers@ubuntu-9123m"
#   alias .ubuntulinux="ssh -J rbyers@irbt-9123m rbyers@ubuntu-linux"
#   alias .whatami="echo From /a/etc/install.conf.. ; grep INSTALL /a/etc/install.conf ; grep -i true /a/etc/akamai.conf | sort | grep -Ei 'split|smoosh'"
#   alias .wine_downloads="pushd $RMBJR60/.wine/drive_c/users/rmbjr60/Downloads"
#
#   irbt-8758l) :
#       alias .adhoc="pushd ~/adhoc"
#       alias .glog="echo ; git branch --verbose ; echo ; git log --graph --oneline --all --decorate=full"
#       alias .gpor="git pull origin rabbit-dev"
#       alias .gstatus="git status"
#       alias .gvim_dev_log="gvim -s ~/bin/searchfor_ERROR.vim dev_??.??_??-??-??_*.log"
#       alias .logdir=". ~/bin/.gotolatestlogdir.sh"
#       alias .nd=".switchgit"
#       alias .nightlies="pushd ~/nightlies"
#       alias .pycharm="pycharm-community >> ~/logs/pycharm.log 2>&1 &"
#       alias .rabbit="pushd ~/rabbit"
#       alias .switchgit=". ~/bin/.switchgit.sh"
#       alias .venv=". ~/rabbit/venv/bin/activate ; . ~/.promptrc ; cd ~/rabbit"
#       alias .vivaldi="vivaldi >> ~/logs/vivaldi.log 2>&1 &"
#   ;;
#
#   alias .version='\
#       printf "\n> python -mplatform\n" ; python -mplatform ;\
#       printf "\n> cat /proc/version\n" ; cat /proc/version ;\
#       printf "\n> uname -mrs\n" ; uname -mrs ;\
#       printf "\n> cat /etc/os-release\n" ; cat /etc/os-release | grep -Ev "BUG_REPORT_URL=|HOME_URL=|ID=|ID_LIKE=|PRIVACY_POLICY_URL=|SUPPORT_URL=" | sort -V ;\
#       printf "\n> cat /etc/lsb-release\n" ; cat /etc/lsb-release ;\
#       printf "\n> cat /etc/linuxmint/info\n" ; [ -f /etc/linuxmint/info ] && cat /etc/linuxmint/info ;\
#       printf "\n> cat /etc/redhat-release\n" ; [ -f /etc/redhat-release ] && cat /etc/redhat-release ;\
#   '
#------------------------------------------------------------
#-- wtf? vim with '-u' somehow causes F11 and F12 to not work
#
#   alias vi="vim -X -u $RMBJR60/.vimrc"
#------------------------------------------------------------
