## **What Is This?** 
This repository contains a general toolkit one can **use to navigate quickly** on a new Ubuntu environment.

## **Instructions** :blue_book:

**Run** the commands below to download and set up the bash command toolkit on your workstation to quickly start using.

```bash
cd $HOME
```

```bash
git clone https://github.com/cardboardcode/comms_toolkit.git --depth 1 --single-branch
echo "source ~/comms_toolkit/comms_set.bash" >> ~/.bashrc
source ~/.bashrc
```

**Configure** the command prompt for ease of use with Git Versioning:

```bash
cat << 'EOF' >> ~/.bash_aliases

# 1. Define the git branch function
parse_t_branch() {  
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'  
}  

# 2. Define the function that builds the prompt
apply_my_prompt() {  
    # IMPORTANT: Initialize all parts as empty strings every single time the function runs
    local venv_part=""
    local git_part=""
    local chroot_part=""
    local user_host_part="\[\033[01;32m\]\u@\h\[\033[00m\]"
    local cwd_part="\[\033[01;34m\]\w\[\033[00m\]"
    local separator=": "
    local suffix="-▶ "

    # --- Handle Debian Chroot ---
    if [[ -n "$debian_chroot" ]]; then
        chroot_part="($debian_chroot) "
    fi

    # --- Handle Python Virtual Environment ---
    # We check if the variable is set AND if the directory actually exists
    if [[ -n "$VIRTUAL_ENV" && -d "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        venv_part="\[\033[01;36m\]($venv_name)\[\033[00m\] "
    fi

    # --- Handle Git Branch ---
    local git_info=$(parse_t_branch)
    if [[ -n "$git_info" ]]; then
        git_part="\[\033[30;47m\]$git_info\[\033[00m\]"
    fi

    # --- Assemble the Final PS1 ---
    # Using double quotes allows us to inject the parts we just built,
    # but we keep \u, \h, and \w as literals so they remain dynamic.
    PS1="${chroot_part}${venv_part}${user_host_part}${separator}${cwd_part} ${git_part}${suffix}"
}  

# 3. The Magic Step: Register the function to run before every prompt
# We use a check to prevent appending the same function multiple times to PROMPT_COMMAND
if [[ "$PROMPT_COMMAND" != *"apply_my_prompt"* ]]; then  
    PROMPT_COMMAND="apply_my_prompt;$PROMPT_COMMAND"  
fi
EOF
```