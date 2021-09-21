#!/usr/bin/env bash


COLUMNS=$(tput cols)
title="[-WELCOME-]"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

# General
alias b='cd ..'
alias d='exit'
alias cs='clear'
alias bb='cd -'
alias nautilus='nautilus >/dev/null 2>&1'
alias open='nautilus .'
alias admin='nano ~/.bashrc -l --mouse'
alias rest='source ~/.bashrc'

# Git
alias st='git status'
alias add='git add -A'
alias com='git commit -m'
alias scom='git commit -S -m'
alias ha='git push origin'

