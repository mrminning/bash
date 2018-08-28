# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Check OS for linux/freebsd/openbsd/darwin
# Check LINUXTYPE for centos/rhel/ubuntu/raspbian
OS=$( uname | tr '[:upper:]' '[:lower:]')

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    LINUXTYPE=$ID
    VERSION=$VERSION_ID

    case $ID in
        rhel)
            PKGMGR="yum"
            ;;
        centos)
            PKGMGR="yum"
            ;;
        raspbian)
            PKGMGR="apt"
            ;;
        ubuntu)
            PKGMGR="apt"
            ;;
    esac
else
    LINUXTYPE="macos"
    VERSION=0
fi

# Only print on interactive shell, or scp will break.
if [ "$SSH_TTY" ]
then
    # .bashrc <date><revision>
    echo ".bashrc 180427 on $OS $LINUXTYPE $VERSION"
fi

# Handle history
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# User specific aliases and functions
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias artisan='php artisan'
alias behat='vendor/bin/behat --strict'
alias dontask='unset SSH_ASKPASS'
# shoot the fat ducks in your current dir and sub dirs
alias ducks='du -ck | sort -nr | head'
alias e='emacs -nw'
alias gadd='git add'
alias gbr='git branch'
alias gch='git checkout'
alias gcom='git commit'
# Files in commit with the following id. Get commit id with glog
alias gcomfiles='git diff-tree --no-commit-id --name-only -r '
alias gdf='git diff'
alias gfet='git fetch'
alias glog=_glog
alias gmer='git merge'
alias gpll='git pull'
alias gpsh='git push'
alias gst='git stash'
alias gsus='git status'
alias h='history'
alias hg='history|grep '
alias j='jobs -l'
alias l.='ls -d .* --color=auto'
alias la='ls -al'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias lt='ls -alrt --color=auto'
alias m='less'
alias mroe='less'
alias p3='/usr/local/bin/python3.5'
alias ports='netstat -tulanp'
alias tf='tail -f '
alias wget='wget -c'

if [ "$PKGMGR" == "yum" ]; then
    alias install="yum install"
    alias update="yum update"
elif [ "$PKGMGR" == "yum" ]; then
    alias install="sudo apt install"
    alias update="sudo apt update && sudo apt upgrade"    
fi

unset SSH_ASKPASS

function bu() { cp "$1" "$1".bkp-`date +%y%m%dt%H%M%S`; }

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi

}

function _glog()
{
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar czf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

function md() { 
mkdir -p $1 
cd $1 
}

function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

