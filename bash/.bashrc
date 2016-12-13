#
# ~/.bashrc
#

. ~/.bash_aliases

# send pass copied passwords to primary
export PASSWORD_STORE_X_SELECTION=primary

# make man pages colorful
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# beaufify the prompt (with git)
#. /usr/share/git/completion/git-prompt.sh

# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWCOLORHINTS=1
# GIT_PS1_DESCRIBE_STYLE="branch"
# GIT_PS1_SHOWUPSTREAM="auto git"

# get_sha() {
# 	git rev-parse --short HEAD 2>/dev/null
# }

# PROMPT_COMMAND='__git_ps1 "${PYTHON_VIRTUALENV}\[\033[0;36m\]\u\[\033[0m\] \[\033[0;33m\]\W\[\033[0m\]" " \[\e[31;1m\]> \[\e[0m\]" " \[\033[1;36m\]:\[\033[0m\]%s \[\033[0;35m\]$(get_sha)"'

source $HOME/.bash_prompt

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# liquid prompt!
#source $HOME/.liquidprompt/liquidprompt

# source autoenv
#source $(which activate.sh)

# masquerade as xterm!
export TERM=xterm

export NOTES_DIRECTORY=$HOME/Sync/notes

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
