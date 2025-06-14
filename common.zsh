PS1='%n@%m %~$ '

alias n="nvim"
alias v="vim"
alias gs="git status"
alias gl="git pull"
alias gp="git push"
alias gc="git commit"
alias venv="source .venv/bin/activate"
alias szc="source $HOME/.zshrc"

export c="$HOME/.config"
export nc="$HOME/.config/nvim"
export kc="$HOME/.config/kitty"
export zc="$HOME/.zshrc"
export dc="$HOME/.dotfiles/"

# add github agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github_key
