#!/bin/bash
echo ""
echo "==> Intializing system..."

set -eu

export DEBIAN_FRONTEND=noninteractive

UPGRADE_PACKAGES=${1:-none}

if [ "${UPGRADE_PACKAGES}" != "none" ]; then
  echo "==> Updating and upgrading packages..."

  # Add third party repositories here if needed
  # ...

  sudo apt-get update
  sudo apt-get upgrade -y
fi

sudo apt-get install -qq \
  apache2-utils \
  apt-transport-https \
  ca-certificates \
  clang \
  cmake \
  curl \
  direnv \
  dnsutils \
  fakeroot-ng \
  gdb \
  git \
  git-crypt \
  gnupg \
  gnupg2 \
  htop \
  hugo \
  ipcalc \
  jq \
  less \
  libclang-dev \
  liblzma-dev \
  libpq-dev \
  libprotoc-dev \
  libsqlite3-dev \
  libssl-dev \
  libvirt-clients \
  libvirt-daemon-system \
  lldb \
  locales \
  man \
  make \
  mosh \
  mtr-tiny \
  musl-tools \
  ncdu \
  neovim \
  netcat-openbsd \
  openssh-server \
  pkg-config \
  pwgen \
  python \
  python3 \
  python3-flake8 \
  python3-pip \
  python3-setuptools \
  python3-venv \
  python3-wheel \
  qemu-kvm \
  qrencode \
  quilt \
  ripgrep \
  shellcheck \
  silversearcher-ag \
  socat \
  software-properties-common \
  sqlite3 \
  stow \
  sudo \
  tmux \
  tree \
  unzip \
  wget \
  zgen \
  zip \
  zlib1g-dev \
  vim-gtk3 \
  zsh \
  --no-install-recommends \

rm -rf /var/lib/apt/lists/*

# install Docker
if ! [ -x "$(command -v docker)" ]; then
  curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
  sudo sh /tmp/get-docker.sh
fi

# install Go
if ! [ -x "$(command -v go)" ]; then
  echo " ==> Installing go..."
  export GO_VERSION="1.14.3"
  wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz" 
  tar -C /usr/local -xzf "go${GO_VERSION}.linux-amd64.tar.gz" 
  rm -f "go${GO_VERSION}.linux-amd64.tar.gz"
  export PATH="/usr/local/go/bin:$PATH"
fi

# install 1Password
if ! [ -x "$(command -v op)" ]; then
  echo " ==> Installing 1Password .."
  export OP_VERSION="v1.0.0"
  curl -sS -o 1password.zip https://cache.agilebits.com/dist/1P/op/pkg/${OP_VERSION}/op_linux_amd64_${OP_VERSION}.zip
  unzip 1password.zip op -d /usr/local/bin
  rm -f 1password.zip
fi

# install protobuf
if ! [ -x "$(command -v protoc)" ]; then
  echo " ==> Installing protobuf .."
  export PROTOBUF_VERSION="3.12.2"
  mkdir -p protobuf_install 
  pushd protobuf_install
  wget https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
  unzip protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
  mv bin/protoc /usr/local/bin
  mv include/* /usr/local/include/
  popd
  rm -rf protobuf_install
fi

# install tools
if ! [ -x "$(command -v jump)" ]; then
  echo " ==> Installing jump .."
  export JUMP_VERSION="0.30.1"
  wget https://github.com/gsamokovarov/jump/releases/download/v${JUMP_VERSION}/jump_${JUMP_VERSION}_amd64.deb
  sudo dpkg -i jump_${JUMP_VERSION}_amd64.deb
  rm -f jump_${JUMP_VERSION}_amd64.deb
fi

VIM_PLUG_FILE="${HOME}/.local/share/nvim/site/autoload/plug.vim"
if [ ! -f "${VIM_PLUG_FILE}" ]; then
  echo " ==> Installing vim plugins"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  mkdir -p "${HOME}/.local/share/nvim/plugged"
  pushd "${HOME}/.local/share/nvim/plugged"
  git clone "https://github.com/tpope/vim-sensible"
  git clone "https://github.com/scrooloose/nerdtree"
  git clone "https://github.com/tpope/vim-fugitive"
  git clone "https://github.com/airblade/vim-gitgutter"
  git clone "https://github.com/tpope/vim-surround"
  git clone "https://github.com/hdima/python-syntax"
  git clone "https://github.com/cespare/vim-toml"
  git clone "https://github.com/ekalinin/Dockerfile.vim"
  git clone "https://github.com/elzr/vim-json"
  git clone "https://github.com/fatih/vim-hclfmt"
  git clone "https://github.com/fatih/vim-nginx"
  git clone "https://github.com/fatih/vim-go"
  git clone "https://github.com/hashivim/vim-hashicorp-tools"
  git clone "https://github.com/junegunn/fzf.vim"
  git clone "https://github.com/roxma/vim-tmux-clipboard"
  git clone "https://github.com/plasticboy/vim-markdown"
  git clone "https://github.com/tmux-plugins/vim-tmux"
  git clone "https://github.com/tmux-plugins/vim-tmux-focus-events"
  popd
fi

if [ ! -d "${HOME}/.fzf" ]; then
  echo " ==> Installing fzf"
  git clone https://github.com/junegunn/fzf "${HOME}/.fzf"
  pushd "${HOME}/.fzf"
  git remote set-url origin git@github.com:junegunn/fzf.git 
  ${HOME}/.fzf/install --bin --64 --no-fish
  popd
fi

TMUX_CONFIG_FILE="${HOME}/.tmux/.tmux.conf"
if [ ! -f "${TMUX_CONFIG_FILE}" ]; then
  echo "==> Pulling Oh My Tmux! config files..."
  cd
  git clone https://github.com/gpakosz/.tmux.git
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
fi

mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/bin"
mkdir -p "${HOME}/downloads"
mkdir -p "${HOME}/workspace"

if [ ! -d "${HOME}/workspace/dotfiles" ]; then
  echo "==> Pulling dotfiles"
  cd "${HOME}/workspace"
  git clone --recursive https://github.com/lxchavez/dotfiles.git

  cd "${HOME}/workspace/dotfiles"
  git remote set-url origin git@github.com:lxchavez/dotfiles.git

  # symlink config files so we can sync them via git
  mkdir -p "${HOME}/.config/nvim"
  ln -sfn $(pwd)/.config/nvim/init.vim "${HOME}/.config/nvim/init.vim"
  ln -sfn $(pwd)/.zshrc "${HOME}/.zshrc"
  ln -sfn $(pwd)/.gitconfig "${HOME}/.gitconfig"
fi


if [ -x "$(command -v zsh)" ]; then
  zsh /tmp/bootstrap-zsh.sh
fi

if ! [ -x "$(command -v code-server)" ]; then
  echo "==> Installing code-server..."
  curl -fsSL https://code-server.dev/install.sh | sh
  systemctl --user enable --now code-server

  if ! [ -x "$(command -v caddy)" ]; then
    echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" \
      | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
    sudo apt update
    sudo apt-get install -qq caddy

    if ! [-f "/etc/caddy/Caddyfile"]; then
      export DOMAIN_NAME="dev.alexchavez.codes"
      echo "${DOMAIN_NAME}\nreverse_proxy 127.0.0.1:8080" > /etc/caddy/Caddyfile
      sudo systemctl reload caddy
      echo "Now visit https://${DOMAIN_NAME}"
      echo "code-server password is in ~/.config/code-server/config.yaml"
    fi
  fi
fi

# install Python tools
if ! [ -x "$(command -v pyenv )" ]; then 
  echo "==> Installing pyenv..."
  curl https://pyenv.run | bash
fi

# pipx and standalone CLI programs/utils installed via pip
if ! [ -x "$(command -v pipx )" ]; then 
  echo "==> Installing pipx..."
  python3 -m pip install --user pipx
  python3 -m pipx ensurepath

  if ! [ -x "$(command -v sam )" ]; then 
    echo "==> Installing aws-sam-cli via pipx..."
    pipx install aws-sam-cli
  fi
fi

if ! [ -x "$(command -v pipenv )" ]; then
  echo "==> Installing pipenv..."
  pipx install pipenv
fi

# AWS CLI
if [ ! -x "$(command -v aws)" ]; then
  echo "==> Installing awscli..."
  cd "${HOME}"
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf awscliv2.zip
  rm -rf "${HOME}/awscliv2.zip"
fi

if [ ! -x "$(command -v terraform)" ]; then
  echo "==> Installing terraform cli..."
  export TERRAFORM_VERSION="0.12.26"
  cd "${HOME}/downloads"
  curl -sSOL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
  mv "${HOME}/downloads/terraform" /usr/local/bin/terraform
fi

if [ ! -x "$(command -v vd)" ]; then
  echo "==> Installing visidata..."
  sudo apt install -y apt-transport-https
  cd "${HOME}/downloads"
  wget https://raw.githubusercontent.com/saulpw/deb-vd/master/devotees.gpg.key
  sudo apt-key add devotees.gpg.key
  sudo add-apt-repository \
    "deb [arch=amd64] https://raw.githubusercontent.com/saulpw/deb-vd/master \
    sid \
    main"
  sudo apt update && sudo apt install -y visidata
fi

if [ ! -x "$(command -v rbenv)" ]; then
  echo "==> Installing rbenv..."
  curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
fi

if [ ! -x "$(command -v bvm)" ]; then
  echo "==> Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
fi

if [ ! -x "$(command -v yarn)" ]; then
  echo "==> Installing yarn..."
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
  sudo apt update && sudo apt install -y yarn
fi

echo ""
echo "==> Done!"
