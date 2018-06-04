#Alias

echo -e "\\e[1m\\e[32m=== Alias ===\\e[0m"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

alias gr="go run"

## Docker Alias
## https://gist.github.com/BretFisher/70c61f0e6099eb60fcc6bc4569f21da9
alias dkr='docker rm $(docker ps -aq)'
alias dk="docker"
alias dkc="docker-compose"
# alias sbl="/opt/sublime_text_3/sublime_text"
# alias code="/opt/VSCode-linux-x64/code"

alias c="clear"
alias e="vim"

## proyectos
DIR_DOT=$HOME/dotfiles
. ${DIR_DOT}/config/alias.d/suyo.sh


