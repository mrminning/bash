#!/bin/bash
#
# C-b q displays pane-numbers
#
# Expected to be run from within tmux
# Setup a workspace for system
# Top panels with resodos scripts
# Bottom open logs
function rswdl () {
    # Open 3 panes
    tmux3;
    # Goto commands
    tmux send-keys "cd system" C-m;
    tmux select-pane -R;
    tmux send-keys "cd system" C-m;
    # Goto logs
    tmux select-pane -D;
    tmux send-keys "tf log/server.log" C-m;
    # Select pane 0
    tmux select-pane -t 0;

}

function tmux2() {
    # Open 2 windows, end in top left #0, top right #1, bottom #2
    if ! __checkTmux -eq 1; then
       echo "Are you in tmux?"
       return;
    fi
    tmux split-window -v;
    tmux select-pane -t 0;
}

function tmux3() {
    # Open 3 windows, end in top left #0, top right #1, bottom #2
    if ! __checkTmux -eq 1; then
       echo "Are you in tmux?"
       return;
    fi
    tmux split-window -v;
    tmux resize-pane -D 15;
    tmux select-pane -U;
    tmux split-window -h;
    tmux select-pane -t 0;
}

function tmux4() {
    # Open 4 windows, end in top left #0, top right #1, bottom left #2, bottom right #3
    if ! __checkTmux -eq 1; then
       echo "Are you in tmux?"
       return;
    fi
    tmux split-window -v;
    tmux split-window -h;
    tmux select-pane -U;
    tmux split-window -h;
    tmux select-pane -t 0;
}

function __checkTmux() {
    if [[ "$TERM" =~ "screen".* ]]; then
       return 0
    fi
    return 1
}
