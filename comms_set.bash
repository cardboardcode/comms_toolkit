#!/usr/bin/env bash

# Display [ -WELCOME- ] whenever comms_set.bash is sourced.
COLUMNS=$(tput cols)
title="[ -WELCOME- ]"
printf "%*s\n" $(((${#title}+$COLUMNS)/2)) "$title"

# General
alias s='cd $HOME/comms_toolkit'
alias b='cd ..'
alias d='exit'
alias cs='clear'
alias bb='cd -'
alias open='xdg-open .'
alias admin='nano ~/comms_toolkit/aux.bash -l --mouse'
alias rest='source ~/.bashrc'
alias new='gnome-terminal & disown'

function wifi(){
	while true; do
	    TS=$(date '+%Y-%m-%d %H:%M:%S')
	
	    # 1. Raw connectivity (no DNS)
	    if ! ping -c1 -W2 1.1.1.1 > /dev/null 2>&1; then
	        echo "[$TS] Offline (no ping)"
	    # 2. DNS working?
	    elif ! getent hosts google.com > /dev/null 2>&1; then
	        echo "[$TS] DNS failure"
	    else
	        echo "[$TS] Online"
	    fi
	
	    sleep 2
	done
}

# Git
alias st='git status'
alias add='git add -A'
alias scom='git commit -S -m'
alias ha='git push origin'
alias checkurl='git config --get remote.origin.url'

_git_commit_options() {
    local cur opts
    COMPREPLY=()

    cur="${COMP_WORDS[COMP_CWORD]}"
    opts=":hammer: :heavy_plus_sign: :blue_book: :zap: :fire:"

    # Only complete when inside an opening quote
    if [[ $COMP_CWORD -eq 1 && $cur == \"* ]]; then
        local unquoted="${cur#\"}"

        for opt in $opts; do
            if [[ $opt == "$unquoted"* ]]; then
                COMPREPLY+=( "\"$opt \"")
            fi
        done
    fi
}

function com() {
    git commit --signoff -m "$1"
}

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

function rev(){
	# Check if /review does not exists in ~/Desktop
	# If true, create /review directory.
	# Otherwise, proceed.
	if [ ! -d "/home/$USER/Desktop/review" ]; then
		echo "[ /home/$USER/Desktop/review ] - MISSING"
		mkdir -p ~/Desktop/review
	else
		echo "[ home/$USER/Desktop/review ] - FOUND"
	fi

	cd /home/$USER/Desktop/review

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

function arp_scan_select() {
    # Ensure arp-scan exists
    if ! command -v arp-scan >/dev/null 2>&1; then
        echo "Error: arp-scan is not installed."
        return 1
    fi

    # Get list of non-loopback interfaces
    mapfile -t ifaces < <(ip -o link show | awk -F': ' '{print $2}' | grep -v '^lo$')

    if [ "${#ifaces[@]}" -eq 0 ]; then
        echo "No network interfaces found."
        return 1
    fi

    echo "Select a network interface:"
    select iface in "${ifaces[@]}"; do
        if [[ -n "$iface" ]]; then
            echo
            echo "Running arp-scan on interface: $iface"
            echo
            sudo arp-scan -I "$iface" --localnet
            break
        else
            echo "Invalid selection. Try again."
        fi
    done
}

aux_file_path="${HOME}/comms_toolkit/aux.bash"

if [[ -f "$aux_file_path" ]]; then
    echo "[aux.bash] - FOUND. Sourcing..."
	source $aux_file_path
else
	echo "[aux.bash] - MISSING. Please create under /comms_toolkit to add new commands..."
fi

unset aux_file_path
