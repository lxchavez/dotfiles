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

# Aliases
alias ls="ls --color=auto"
alias ll="ls -lAh"
alias la="ls -A"
alias l="ls -CF"

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

# ZSH Autocompletions
autoload -U bashcompinit
bashcompinit

if [ -x "$(command -v pipenv)" ]; then
    eval "$(pipenv --completion)"
    export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"
fi
if [ -x "$(command -v pipx)" ]; then
    eval "$(register-python-argcomplete pipx)"
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
