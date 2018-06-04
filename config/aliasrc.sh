#Alias

echo 'loading alias '
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

# zappa-suyo
alias sd-shell='docker run -ti -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION -v $(pwd):/var/task  --rm -p8000:8000 --network sour-diesel_default sour-diesel bash'