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

# 1. Define the git branch function (Now using Square Brackets [])
parse_t_branch() {  
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/'  
}  
  
# 2. Define a function that forces the PS1 to be what we want  
apply_my_prompt() {  
    # Capture the branch output into a local variable
    local git_info=$(parse_t_branch)
    local git_formatted=""

    # If git_info is not empty, wrap ONLY the text in Black on White
    if [[ -n "$git_info" ]]; then
        git_formatted="\[\033[30;47m\]$git_info\[\033[00m\]"
    fi

    # Apply the PS1
    if [[ -n "$TERM" && "$TERM" != "dumb" ]]; then  
        # The space before $git_formatted is outside the highlight
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '"$git_formatted"'-▶ '  
    else  
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '  
    fi  
}  
  
# 3. The Magic Step:  
if [[ "$PROMPT_COMMAND" != _"apply_my_prompt"_ ]]; then  
    PROMPT_COMMAND="apply_my_prompt;$PROMPT_COMMAND"  
fi
EOF
```