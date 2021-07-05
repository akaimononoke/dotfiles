#!/bin/zsh

HOME_BIN_DIR=$HOME/bin &&
    rm -rf $HOME_BIN_DIR &&
    mkdir -p $HOME_BIN_DIR &&
    cp bin/* $HOME_BIN_DIR

BASH_COMP_DIR=$HOME/.bash-completions &&
    rm -rf $BASH_COMP_DIR &&
    mkdir -p $BASH_COMP_DIR &&
    cp bash-completions/* $BASH_COMP_DIR

ZSH_COMP_DIR=$HOME/.zsh-completions &&
    rm -rf $ZSH_COMP_DIR &&
    mkdir -p $ZSH_COMP_DIR &&
    cp zsh-completions/* $ZSH_COMP_DIR

cp .zshrc $HOME/.zshrc

exec $SHELL -l
