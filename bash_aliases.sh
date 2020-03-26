# User specific aliases and functions
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias artisan='php artisan'
alias behat='vendor/bin/behat --strict'
alias chromecast='pactl load-module module-loopback'
alias dc='docker-compose'
alias dontask='unset SSH_ASKPASS'
# shoot the fat ducks in your current dir and sub dirs
alias ducks='du -cks * | sort -nr | head'
alias e='emacs -nw'
alias ec='emacsclient'
alias gadd='git add'
alias gbr='git branch'
alias gch='git checkout'
alias gcom='git commit'
alias gcoma='git commit --amend'
# Files in commit with the following id. Get commit id with glog
alias gcomfiles='git diff-tree --no-commit-id --name-only -r '
alias gdf='git diff'
alias gfet='git fetch'
alias glog=_glog
alias gmer='git merge'
alias gpll='git pull'
alias gpsh='git push'
alias greb='git rebase origin/master'
alias grebi='git rebase origin/master --interactive'
alias gst='git stash'
alias gsus='git status'
alias h='history'
alias hg='history|grep '
alias j='jobs -l'
alias la='ls -al'
alias l.='ls -d .*'
alias ll='ls -l'
alias lt='ls -alrt'
alias ls='ls --color=auto'

if [ "$LINUXTYPE" == "macos" ]; then
    alias ls='ls -G'
fi

alias m='less'
alias mci='mvn clean install'
alias mct='mvn -P component-tests verify'
alias mtf='mvn -P component-tests-fast verify'
alias mroe='less'
alias p3='/usr/local/bin/python3'
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

function bu() { cp -a "$1" "$1".bkp-`date +%y%m%dt%H%M%S`; }

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

function mcisr()
{
    dir=${PWD##*/}
    if [ "$dir" == "app" ]; then
	cd ..
    fi
    mvn install
    cd app && mvn spring-boot:run
}

function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/^* \(.*\)/ (\1)/'
}