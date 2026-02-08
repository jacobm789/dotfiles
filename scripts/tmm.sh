#!/bin/bash

MAIN="main"

if [ -n "$TMUX" ]; then
    echo "Currently in a tmux session!"
    exit 1
elif tmux list-sessions | grep -q "$MAIN.*(attached)"; then
    echo "$MAIN already attached elsewhere!"
elif tmux has-session -t $MAIN 2>/dev/null; then
    tmux attach -t $MAIN
else
    tmux new-session -d -s $MAIN -n "tops"

    tmux select-window -t $MAIN
    tmux send-keys -t 1 'btop' C-m
    tmux split-window -h
    tmux send-keys -t 2 'htop' C-m

    tmux attach -t $MAIN
fi
