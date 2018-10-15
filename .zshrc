# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/Users/achavez/Library/Python/2.7/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/achavez/.oh-my-zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  colored-man-pages
  git
  python
  osx
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#==========================================================
# ALIASES -- Keep in #SYNC with DE TUNNEL SCRIPT
# (Last copied here 20180522)
#==========================================================
alias dbconn-prod-dw01_dmf='USAGE: Configure DB TOOLS to connect to DW01 db via host=localhost,port=55432'
alias dbconn-prod-dw02_dmf='USAGE: Configure DB TOOLS to connect to DW02 db via host=localhost,port=56432'
alias dbconn-prod-dwdev_dmf='USAGE: Configure DB TOOLS to connect to DWDEV db via host=localhost,port=56439'
alias dmf_aliases_dbconn='echo ""; echo "*** LIST OF ALL DMF DBCONN ALISES: ***"; echo ""; echo "$(alias | grep -i dbconn | egrep -i "_dmf|dmf_") "
'
alias dmf_aliases_rdp='echo ""; echo "*** LIST OF ALL DMF RDP ALISES: ***"; echo ""; echo "$(alias | grep -i rdp | egrep -i "_dmf|dmf_") "'
alias dmf_aliases_ssh='echo ""; echo "*** LIST OF ALL DMF SSH ALISES: ***"; echo ""; echo "$(alias | grep -i ssh | egrep -i "_dmf|dmf_") "'
alias dmf_ps_psnl_ssh='echo ""; echo "*** LIST OF ALL PSNL SSH PROCESSES (REGARDLESS of DMF): ***"; echo ""; echo "$(ps | grep -i ssh) "'
alias helpme='echo -e '\''\n*** MAIN HELPME: SHOWING ALL DMF ALIASES ETC: ***\n'\''; alias | grep -i '\''dmf'\'' '
alias rdp-prod-rdp01_dmf='USAGE: Configure RDP to connect to RDP01 server via host=localhost,port=53389'
alias rdp-prod-report01_dmf='USAGE: Configure RDP to connect to REPORT01 server via host=localhost,port=52389'
alias ssh-prod-dw01_dmf='ssh alex_chavez@localhost -p 55022'
alias ssh-prod-dw02_dmf='ssh alex_chavez@localhost -p 56022'
alias ssh-prod-dwdev_dmf='ssh alex_chavez@localhost -p 57022'
alias ssh-prod-etl01_dmf='ssh alex_chavez@localhost -p 51022'
#==========================================================
alias ll="ls -lah"

# Aliases for installed CLI utilities
alias cat="bat"
alias ping="prettyping --nolegend"
alias top="htop"
alias help="tldr"

# For asdf (Extendable version manager with support for Ruby, Node.jsm Elixir, Erlang & more)
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash


test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/achavez/.asdf/installs/nodejs/8.11.3/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/achavez/.asdf/installs/nodejs/8.11.3/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/achavez/.asdf/installs/nodejs/8.11.3/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/achavez/.asdf/installs/nodejs/8.11.3/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# Add pyenv init to enable shims and autocompletion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Enable the pyenv-virtualenv plugin
if which pyenv-virtualenv-init > /dev/null; then
  eval "$(pyenv virtualenv-init -)";
fi

# Set up tab completion for the go-jira CLI client
eval "$(jira --completion-script-bash)"

# byobu
export BYOBU_PREFIX=/usr/local

# pure
autoload -U promptinit; promptinit
prompt pure
