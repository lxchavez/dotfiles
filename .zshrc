# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/id_rsa"

# Import aliases
. ~/.aliases

# pipenv autocompletions
if which pipenv > /dev/null; then
    eval "$(pipenv --completion)"
    export PIPENV_PYTHON="${PYENV_ROOT}/shims/python"
fi

# Load pyenv automatically by appending
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

# pure
autoload -U promptinit; promptinit
prompt pure

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# pyenv setup
# export PATH="/usr/bin:$PATH"
# export PATH="/home/alex/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# Use neovim
if type nvim > /dev/null 2>&1; then
  export EDITOR=nvim
  alias vim='nvim'
fi

# tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

# Keep this at the bottom

# prezto
if [ ! -d "${HOME}/.zprezto" ]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
