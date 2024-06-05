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
alias wifi='ping google.com'

# Git
alias st='git status'
alias add='git add -A'
alias com='git commit -m'
alias scom='git commit -S -m'
alias ha='git push origin'
alias checkurl='git config --get remote.origin.url'

# Directory Hop
function repo(){
	# Check if /repo does not exists in ~/Desktop
	# If true, create /repo directory.
	# Otherwise, proceed.
	if [ ! -d "/home/$USER/Desktop/repo" ]; then
		echo "[ /home/$USER/Desktop/repo ] - MISSING"
		mkdir -p ~/Desktop/repo
	else
		echo "[ home/$USER/Desktop/repo ] - FOUND"
	fi

	cd /home/$USER/Desktop/repo

}

function dev(){
	# Check if /dev does not exists in ~/Desktop
	# If true, create /dev directory.
	# Otherwise, proceed.
	if [ ! -d "/home/$USER/Desktop/dev" ]; then
		echo "[ /home/$USER/Desktop/dev ] - MISSING"
		mkdir -p ~/Desktop/dev
	else
		echo "[ home/$USER/Desktop/dev ] - FOUND"
	fi

	cd /home/$USER/Desktop/dev

}

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

function gourl(){
	GIT_URL=$(git config --get remote.origin.url)
	echo "Opening ${GIT_URL}"
	# unset OUTPUT

	# Check if the url is ssh.
	# If true, get substring and concatenate such that it mimicks a https.
	# Otherwise, just use the generated url.
	SUB='@'
	if [[ "$GIT_URL" == *"$SUB"* ]]; then
		# Determine and store github or gitlab substring.
		# Determine and store url substring.
		# Concatenate 1st and 2nd substring with http://
		echo ${GIT_URL:4:10}
		echo ${GIT_URL:15:${#GIT_URL}}
		firefox "https://${GIT_URL:4:10}/${GIT_URL:15:${#GIT_URL}}"
	else
		firefox $GIT_URL
	fi

	unset GIT_URL SUB
}
