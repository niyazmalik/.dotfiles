# ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac
# History settings - increased for better history
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
shopt -s checkwinsize
# Color support for ls and grep
alias ls='ls --color=auto'
export LS_COLORS='di=1;34:ex=1;93:ow=34:tw=34'
alias grep='grep --color=auto'
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'

alias kv='nvim ~/.config/kitty/kitty.conf'
alias ks='kill -SIGUSR1 $KITTY_PID'

alias bv='nvim ~/.bashrc'
alias bs='source ~/.bashrc'


# Skip bash completion (this can be slow, will enable it if only I need it...)
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   fi
# fi
# Faster cd (don't check for typos)
shopt -u cdspell 2>/dev/null
# Disable mail check
unset MAILCHECK

# Custom prompt!
PS1='\n\[\033[0;31m\]◆ Command!\[\033[0m\] '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
