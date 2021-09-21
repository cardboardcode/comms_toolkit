#!/usr/bin/env bash

# Display [ -WELCOME- ] whenever comms_set.bash is sourced.
COLUMNS=$(tput cols)
title="[ -WELCOME- ]"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

# General
alias b='cd ..'
alias d='exit'
alias cs='clear'
alias bb='cd -'
alias open='xdg-open .'
alias admin='nano ~/comms_toolkit/comms_set.bash -l --mouse'
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

# Functions

function searchword(){

	# Check if there is not exactly 2 commandline arguments
	# If true, report error and exit.
	# Otherwise, proceed.
	if [ ! $# -eq 2 ]; then
		echo "[ ERROR ] - Arguments given is not exactly 2. Exiting ..."
	     	echo "Eg. searchword <SEARCH_DIR> <SEARCH_TERM>"
		return 1
	fi

	#Assign input directory based on user's input.
	SEARCH_DIR="$1"
	# Check if user input directory does not exist,
	# If true, report error and exit.
	# Otherwise, proceed.
	if [ ! -d "$SEARCH_DIR" ]; then
		echo "[ ERROR ] - Input search directory does not exist. Exiting..."
		return 1
	fi

	grep -rnw $1 -e $2
}

