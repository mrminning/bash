# User specific aliases and functions
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias aliasg='alias|grep'
alias aptin="sudo apt install"
alias aptup="sudo apt update && sudo apt upgrade -y"
alias artisan='php artisan'
alias bashaliases='source ~/bash/bash_aliases.sh'
alias bat='batcat'
alias chromecast='pactl load-module module-loopback'
alias d='cd ~/Downloads'
alias dc='docker compose'
alias docker-clean='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias dontask='unset SSH_ASKPASS'
# shoot the fat ducks in your current dir and sub dirs
alias ducks='du -cks * | sort -nr | head'
alias e='emacs -nw'
alias ec='emacsclient'
alias gadd='git add'
alias gapp='git apply'
# Backup untracked files
alias gback='git ls-files --others --exclude-standard -z|xargs -0 tar rvf' # filename.tar
alias gbr='git branch'
alias gch='git checkout'
alias gchm='git_checkout_default'
alias gcom='git commit'
alias gcoma='git commit --amend'
alias gcoman='git commit --amend --no-edit'
# Files in commit with the following id. Get commit id with glog
alias gcomfiles='git diff-tree --no-commit-id --name-only -r '
alias gdf='git diff'
alias gdfs='git diff --staged'
alias gfet='git fetch'
alias glog=_glog
alias gmer='git merge'
alias gpll='git pull'
alias gpllr='git pull --rebase'
alias gpsh='git push'
alias gpshf='git push --force-with-lease'
alias gpshr='git push origin HEAD:refs/for/master'
alias greb='git rebase origin/master'
alias greba='git rebase --abort'
alias grebc='git rebase --continue'
alias grebs='git rebase --skip'
alias grebi='git rebase origin/master --interactive'
alias grem='git remote'
alias gres1='git reset --hard HEAD~1'
alias gst='git stash'
alias gsta='git stash --all'
alias gsus='git status'
alias gwhat='git whatchanged'
alias grabu='./gradlew build'
alias grach='./gradlew check'
alias gracl='./gradlew clean'
alias graru='./gradlew run'
alias grasa='./gradlew spotlessApply'
alias grasc='./gradlew spotlessCheck'
alias grata='./gradlew tasks'
alias gratd='./gradlew testDocker'
alias grate='./gradlew test'
alias graus='./gradlew updateSnapshot'
alias h='history'
alias hg='history|grep '
alias j='jobs -l'
alias java17='sdk use java 17.0.13-amzn'
alias java21='sdk use java 21.0.4-amzn'
alias la='ls -Al'
alias l.='ls -d .*'
alias ll='ls -l'
alias lt='ls -alrt'
alias ls='ls --color=auto'

if [ "$LINUXTYPE" == "macos" ]; then
    alias ls='ls -G'
fi

alias m='bat'
alias mci='mvn clean install'
alias mct='mvn -P component-tests verify'
#alias mct='mvn verify -Pcomponent-tests -P \!update-tisp-dependencies,\!update-parent'
alias mcp='mvn clean package'
alias mcv='mvn clean verify'
alias mda='mvn dependency:analyze'
alias mdt='mvn dependency:tree'
alias mrun='mvn -f app/ spring-boot:run'
alias msa='mvn spotless:apply'
alias mtf='mvn -P component-tests-fast verify'
alias mroe='less'
alias mver='mvn verify'
alias nci='npm ci'
alias nin='npm install'
alias nrb='npm run build'
alias nrc='npm run cypresslocal'
alias nrl='npm run lint'
alias nrlf='npm run lint:fix'
alias nrs='npm run snapshots'
alias nrsd='npm run start:dev'
alias nrsl='npm run start:local'
alias nrt='npm run test'
alias nrtj='npm run test:jest'
alias obsidianbackups='python ~/projects/obsidianbackups/main.py'
alias p='cd ~/projects'
alias p3='/usr/local/bin/python3'
alias pg='ps -ef|grep'
alias pip=pip3
alias ports='netstat -tlpn' #open ports
alias psqllocal='psql -h localhost -U "postgres"'
alias tf='tail -f '
alias tm-attach='tmux a -t'
alias tm-ls='tmux ls'
alias tm-new='tmux new -s'
alias wget='wget -c'


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

function git_checkout_default() {
    # Determine the default branch
    DEFAULT_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
    git checkout $DEFAULT_BRANCH
}

function set-title() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1=${ORIG}${TITLE}
}

function set-title-dir() {
  if [[ -z "$ORIG" ]]; then
    ORIG=$PS1
  fi
  dirname=${PWD##*/}
  TITLE="\[\e]2;$dirname\a\]"
  PS1=${ORIG}${TITLE}
}

function venvactivate() {
    if [ -d "venv" ]; then
	source venv/bin/activate
    elif [ -d ".venv" ]; then
        source .venv/bin/activate
    else
        echo "venv not found"
    fi
}
