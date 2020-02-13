# bash #
## bash scripts ##

.bashrc with useful aliases.
```
cp .bashrc ~/.bashrc
# or
cd ~
wget https://raw.githubusercontent.com/mrminning/bash/master/.bashrc
```

Put this in .bashrc to only use aliases
```
if [ -f ~/bash/.bash_aliases ]; then
    . ~/bash/.bash_aliases
fi
```

## tmux ##
```
cd ~
wget https://raw.githubusercontent.com/mrminning/bash/master/.tmux.conf
```
