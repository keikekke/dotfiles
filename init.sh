#!/bin/bash

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.tmux.conf ~/.tmux.conf
ln -sf $(pwd)/.bash_profile ~/.bash_profile
ln -sf $(pwd)/.bashrc ~/.bashrc
ln -sf $(pwd)/.zsh_profile ~/.zsh_profile
ln -sf $(pwd)/.zshrc ~/.zshrc
ln -sf $(pwd)/.xprofile ~/.xprofile
ln -sf $(pwd)/.xinitrc ~/.xinitrc

# install VimPlug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall
