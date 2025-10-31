lazy_load() {
    local cmd="$1"
    local init_cmd="$2"
    
    eval "$cmd() {
        unfunction $cmd
        eval \"$init_cmd\"
        $cmd \"\$@\"
    }"
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'

alias n="nvim"
alias v="vim"
alias gs="git status"
alias gl="git pull"
alias gd="git diff"
alias gp="git push"
alias gc="git commit"
alias gb="git branch"
alias gbc="git rev-parse --abbrev-ref HEAD | wl-copy"
alias gch="git checkout"
# TUI utility for git checkout when you forget the branch
#   More information: https://til.jakelazaroff.com/fzf/make-a-tui-for-switching-and-deleting-git-branches/
alias gcht="git branch | fzf --preview 'git log -p main..{-1} --color=always {-1}' | cut -c 3- | xargs git checkout"
alias venv="source .venv/bin/activate"
alias szc="source $HOME/.zshrc"
alias sv="source .venv/bin/activate"
alias nf="neofetch"
alias hr="hyprctl reload"
alias h="Hyprland"

alias i="sudo pacman -S"
alias is="pacman -Ss"

alias c="wl-copy"

export c="$HOME/.config"
export nc="$HOME/.config/nvim"
export kc="$HOME/.config/kitty"
export zc="$HOME/.zshrc"
export dc="$HOME/.dotfiles/"

# add github agent
eval "$(ssh-agent -s)" > /dev/null; ssh-add ~/.ssh/github_key 2>/dev/null

eval "$(starship init zsh)"
