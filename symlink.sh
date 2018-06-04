#!/bin/bash

. tools/stdlib.tools

if [ ! -d "backup" ]; then
    warn "Creating Backup folder"
    mkdir -p "backup"
fi

if [ ! -d "local" ]; then
    warn "Creating local/bin folder"
    mkdir -p "local/bin"
fi


for value in `ls config`; do
    ## Ingore all .sh files
    if [[ $value == *.sh ]];then
        warn "ignore *.sh files"
       continue
    fi

    # [ -f "$value" ]  || continue

    if [ -f "$HOME/.$value" ];then
      step "Backup origial files"
      mv "$HOME/.$value" backup/$value.dotfile
    fi

    step "$HOME/.$value"
    ln -s -b "dotfiles/config/$value" "$HOME/.$value"

done

step "Symlinking successful."
