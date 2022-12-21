# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add go to the PATH
if [ -d /usr/local/go/bin ]; then
    PATH="/usr/local/go/bin:$PATH"
fi

# Add rbenv to the PATH
if [ -d /root/.rbenv/bin ]; then
    PATH="/root/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# Aliases
alias ls="ls --color=auto"
alias ll="ls -lAh"
alias la="ls -A"
alias l="ls -CF"
alias untar='tar -xvzf'

# Aliases for installed CLI utilities
if [ -x "$(command -v fzf)" ]; then
    alias preview="fzf --preview 'bat --color \"always\" {}'"
fi
if [ -x "$(command -v htop)" ]; then
    alias top="htop"
fi
if [ -x "$(command -v ncdu)" ]; then
    alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
fi
if [ -x "$(command -v nvim)" ]; then
    export EDITOR=nvim
    alias vi="nvim"
    alias vim="nvim"
fi
if [ -x "$(command -v xclip)" ]; then
    alias pbpaste='xclip -selection clipboard -o'
    alias pbcopy='xclip -selection clipboard'
fi
if [ -x "$(command -v vd)" ]; then
    alias -s csv=vd
fi
if [ -x "$(command -v batcat)" ]; then
    alias cat=batcat
fi

# You may need to manually set your language environment
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# Custom zsh functions
if [ -x "$(command -v xdg-open)" ]; then
    open() {
        setsid nohup xdg-open $1 > /dev/null 2> /dev/null
    }
fi

if [ -x "$(command -v tmux)" ]; then
    exit() {
        if [[ -z $TMUX ]]; then
            builtin exit
            return
        fi

        panes=$(tmux list-panes | wc -l)
        wins=$(tmux list-windows | wc -l) 
        count=$(($panes + $wins - 1))
        if [ $count -eq 1 ]; then
            tmux detach
        else
            builtin exit
        fi
    }
fi

# Extract commmon compression file formats
# Usage: x filename
extract(){
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1    ;;
            *.tar.gz)    tar xvzf $1    ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "Unable to extract '$1'" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# ZSH Autocompletions
autoload -U bashcompinit; bashcompinit

if [ -x "$(command -v pipenv)" ]; then
    eval "$(pipenv --completion)"
    export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"
fi
if [ -x "$(command -v pipx)" ]; then
    eval "$(register-python-argcomplete pipx)"
fi
if [ -f "/usr/local/bin/aws_completer" ]; then
    complete -C '/usr/local/bin/aws_completer' aws
fi

# Ensure that we have an ssh config with AddKeysToAgent set to true
if [ ! -f ~/.ssh/config ] || ! cat ~/.ssh/config | grep AddKeysToAgent | grep yes > /dev/null; then
    echo "AddKeysToAgent  yes" >> ~/.ssh/config
fi
# Ensure a ssh-agent is running so you only have to enter keys once
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi

# Keep this at the bottom

# prezto
if [ -d "${HOME}/.zprezto" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pure prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
