#!/bin/bash

. tools/stdlib

if [ ! -d "backup" ]; then
    mkdir -p "backup"
fi

for value in `ls`; do
    if [[ $value == *.sh ]];then
        continue
    fi

    [ -f "$value" ]  || continue

    step "Backup origial files"
    if [ -f "$HOME/.$value" ];then
	 mv "$HOME/.$value" backup/$value.dotfile
    fi
    
    step "$HOME/.$value"
    ln -s -b "dotfiles/$value" "$HOME/.$value" 
    
done

step "Symlinking successful."