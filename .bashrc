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
    echo ".bashrc 191017 on $OS $LINUXTYPE $VERSION"
fi

# Handle history
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# User specific aliases and functions

unset SSH_ASKPASS

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export GOPATH=$HOME/go
export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]: \w\[\033[32m\]$(parse_git_branch)\[\033[00m\] $ "
