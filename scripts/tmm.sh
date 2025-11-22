#!/bin/bash

MAIN="main"

if tmux list-sessions | grep -q '(attached)'; then
    tmux detach
fi

if tmux has-session -t $MAIN 2>/dev/null; then
    tmux attach -t $MAIN

else
    tmux new-session -d -s $MAIN -n "tops"

    tmux select-window -t $MAIN:1
    tmux send-keys -t 1 'btop' C-m
    tmux split-window -h
    tmux send-keys -t 2 'htop' C-m

    tmux attach -t $MAIN:1
fi
