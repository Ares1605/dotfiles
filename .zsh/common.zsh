export DOTFILES_DIR="$HOME/.dotfiles"

lazy_load() {
    local cmd="$1"
    local init_cmd="$2"
    
    eval "$cmd() {
        unfunction $cmd
        eval \"$init_cmd\"
        $cmd \"\$@\"
    }"
}

# ===== Zsh Vi Mode Plugin =====
source $DOTFILES_DIR/.zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

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
alias gbc="git rev-parse --abbrev-ref HEAD | tr -d '\n' | wl-copy"
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
alias fn="cd ~/Documents/notes/ && nvim ./ && cd -"
export hc="$HOME/.config/hypr"
alias ls="eza"
alias tree="tre"
alias ssh="kitten ssh"


# Replace gross Claude CLI with opencode
alias claude="opencode"

# Powerpill natively supports download parallelization
#  More Information: https://wiki.archlinux.org/title/Powerpill
alias powerpill="pacman"
PACMAN="powerpill"

alias i="sudo $PACMAN -S"
alias is="$PACMAN -Ss"

alias c="wl-copy"
alias cat="bat"
alias ocat="/usr/bin/cat"

alias bios="systemctl reboot --firmware-setup"

export c="$HOME/.config"
export nc="$HOME/.config/nvim"
export kc="$HOME/.config/kitty"
export zc="$HOME/.zshrc"
export dc=$DOTFILES_DIR

# A less option my mycli, to disable line wrapping
#  More information: https://www.mycli.net/pager (Look at "Page Behavior" section)
export LESS="-SRXF"

# add github agent
eval "$(ssh-agent -s)" > /dev/null; ssh-add ~/.ssh/github_key 2>/dev/null

eval "$(starship init zsh)"

export PATH=$PATH:$HOME/.spicetify

export NVM_DIR="$HOME/.nvm"
# Add an explicit node version and add the --no-use flag to skip
# a long operation (should reduce NVM sourcing from .4s to 0.07s).
#
#  More info: https://www.ioannispoulakas.com/2020/02/22/how-to-speed-up-shell-load-while-using-nvm/
export PATH="$PATH:$HOME/.nvm/versions/node/v24.10.0/bin"
lazy_load nvm 'source /usr/share/nvm/init-nvm.sh --no-use'

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
lazy_load pyenv 'eval "$(pyenv init - zsh)"'

export PATH="$PATH:$HOME/.local/share/coursier/bin"

# adding gem to path for ruby
lazy_load gem 'export GEM_HOME="$(ruby -e '\''puts Gem.user_dir'\'')"; export PATH="$PATH:$GEM_HOME/bin"'

lazy_load brew 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

# ===== Dependency Tracking =====
# Sync all dependencies
alias sync-all="$DOTFILES_DIR/setup-scripts/sync-installed.sh"
# Or sync individually
alias sync-npm="$DOTFILES_DIR/setup-scripts/sync-npm.sh"
alias sync-pip="$DOTFILES_DIR/setup-scripts/sync-pip.sh"
alias sync-go="$DOTFILES_DIR/setup-scripts/sync-go.sh"
# ===============================

# ===== Zsh Vi Mode Configuration =====
# Change cursor shape for different vi modes
ZVM_CURSOR_STYLE_ENABLED=true

# Use nvim as external editor (press 'vv' in normal mode to edit command in nvim)
export EDITOR='nvim'

# Hook function to fix fzf key bindings after zsh-vi-mode loads
function zvm_after_init() {
  # Restore fzf key bindings (Ctrl+R for history search)
  [ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
}
# =====================================
