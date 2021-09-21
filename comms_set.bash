#!/usr/bin/env bash


COLUMNS=$(tput cols)
title="[-WELCOME-]"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

# General
alias b='cd ..'
alias d='exit'
alias cs='clear'
alias bb='cd -'
alias open='xdg-open .'
alias admin='nano ~/.bashrc -l --mouse'
alias rest='source ~/.bashrc'
alias new='gnome-terminal & disown'

# Git
alias st='git status'
alias add='git add -A'
alias com='git commit -m'
alias scom='git commit -S -m'
alias ha='git push origin'
alias checkurl='git config --get remote.origin.url'

# Directory Hop
alias repo='cd ~/Desktop/repo_archive'
