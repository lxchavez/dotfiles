#!/bin/zsh
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
  echo "==> Installing prezto"
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done
fi

if [ -d "${HOME}/workspace/dotfiles" ]; then
  cd "${HOME}/workspace/dotfiles"
  ln -sfn $(pwd)/.zprestorc "${HOME}/.zpreztorc"
fi

echo "==> Setting shell to zsh..."
chsh -s /usr/bin/zsh

echo "==> Finished zsh config!"