# set -o nounset
# set -o errexit

# If not running interactively, don't do anything [[ "$-" != *i* ]] && return
# Shell Options # See man bash for more options...  
# Use case-insensitive filename globbing shopt -s nocaseglob 
# Make bash append rather than overwrite the history on disk shopt -s histappend 
# Completion options


# Uncomment to turn on programmable completion enhancements.
# Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion

# History Options

# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well

# Aliases

# Default to human readable figures
# alias df='df -h'
# alias du='du -h'
#
# Misc :)
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour

# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ls -A'                              # all but . and ..

# Found https://www.reddit.com/r/programming/comments/3evbbk/how_to_write_a_git_commit_message/ctiuwwz
alias whatthecommit='git commit -m "`curl whatthecommit.com/index.txt`"'

# Start xserver 
(XWin -multiwindow -clipboard -silent-dup-error &> /dev/null) & 
export DISPLAY=:0

set -o vi

command_exists () {
    type "$1" >/dev/null 2>&1 ;
}

downloadDependency() {
    local cmd=$1
    local git_url=$2
    local path=~/bin/${cmd}
    local cmd_to_alias=$3

    # Try to download prm if it does not already exist
    if [[ ! -d "${path}" ]] && command_exists git ; then
        git clone "${git_url}" "${path}"
    fi
}

# TODO: add check if it exists on path
alias sublimetext='sublime_text.exe'

# For prm 
# TODO: why doesn't this work with alias?
export EDITOR='vi'


downloadDependency "prm" "https://github.com/eivind88/prm.git"
# TODO: 
alias prm='. ~/bin/prm/prm.sh'
alias iwip='ipconfig.exe | grep Wi-Fi -a -A6'

# TODO: make pull request for adding support for windows
# downloadDependency "theFuck" "https://github.com/nvbn/thefuck.git"
    
# Check if TMUX exists and if running(?)
if command_exists tmux && [ -z "$TMUX" ]; then
    base_session='tmux'
    # Create a new session if it doesn't exist
    tmux has-session -t $base_session || tmux new-session -d -s $base_session
    # Are there any clients connected already?
    client_cnt=$(tmux list-clients | wc -l)
    if [ $client_cnt -ge 1 ]; then
        session_name=$base_session"-"$client_cnt
        tmux new-session -d -t $base_session -s $session_name
        tmux -2 attach-session -t $session_name \; set-option destroy-unattached
    else
        tmux -2 attach-session -t $base_session
    fi
fi

PATH=$PATH:~/bin
export LANG='en_GB.UTF-8'
