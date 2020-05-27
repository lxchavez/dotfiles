# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# For the pure zsh prompt
fpath+=$HOME/.zsh/pure

# Aliases
alias ll="ls -lah"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

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
if [ -x "$(command -v neovim)" ]; then
    export EDITOR=nvim
    alias vi="nvim"
    alias vim="nvim"
fi

# You may need to manually set your language environment
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Custom zsh functions
open() {
  setsid nohup xdg-open $1 > /dev/null 2> /dev/null
}

# pipenv autocompletions
if [ -x "$(command -v pipenv)" ]; then
    eval "$(pipenv --completion)"
    export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"
fi

# pyenv setup
if [ -x "$(command -v pyenv)" ]; then
    export PATH="/usr/bin:$PATH"
    export PATH="/home/alex/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Keep this at the bottom

# pure
autoload -U promptinit; promptinit
prompt pure

# prezto
if [ -d "${HOME}/.zprezto" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
