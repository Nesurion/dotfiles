# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# export TYPEWRITTEN_PROMPT_LAYOUT="half_pure"
# export TYPEWRITTEN_RELATIVE_PATH="adaptive"
# export TYPEWRITTEN_RIGHT_PROMPT_PREFIX_FUNCTION=typewritten_right_prefix
# export TYPEWRITTEN_LEFT_PROMPT_PREFIX_FUNCTION=(pwd)
# export TYPEWRITTEN_COLOR_MAPPINGS="primary:#81A1C1;secondary:#A3BE8C;accent:#8FBCBB;info_negative:#BF616A;info_positive:#A3BE8C;info_neutral_1:#EBCB8B;info_neutral_2:#B48EAD;info_special:#D08770"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git iterm2 kubectl)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# [[ user section ]]

export EDITOR='nvim'

alias reload="source ~/.zshrc"
# git
join_with_hypen() {
  local IFS="-"
  echo "$*"
}

alias glgo="git log --pretty=oneline --abbrev-commit"
alias gdc="git diff --cached"

gcob () {
  local branch_title=$(join_with_hypen $@)
	git checkout -b feature/$branch_title
}

gcoa () {
  local branch_title=$(join_with_hypen $@)
	git checkout -b feature/ATLAS-$branch_title
}

gri () {
	git rebase -i HEAD~$1
}

alias ghpr="gh pr create"
alias ghprd="gh pr create -d"
alias ghd="gh dash"
alias gcl="git fetch -p && git branch -vv | grep ': gone]' | grep -vE '^\s*(master|main)\s' | awk '{print \$1}' | xargs git branch -d"

# docker
alias dps="docker ps"
alias docker-socket="sudo ln -s $HOME/.docker/run/docker.sock /var/run/docker.sock"

# bat
export BAT_THEME="tokyonight_night"

if hash bat 2>/dev/null; then
  alias cat="bat -pp"
fi

# jenv
eval "$(jenv init -)"

# typewritten theme customization
typewritten_right_prefix() {
  current_kube_context="$(kubectx -c 2> /dev/null)"
  tw_kube_region=$(echo $current_kube_context | awk -F'-' '{print $2}')
  tw_kube_env=$(echo $current_kube_context | awk -F'-' '{print $3}')
  tw_kube_namespace="$(kubens -c 2> /dev/null)"

  if [[ $current_kube_context != "" ]]; then
    echo "󱃾 $(basename $tw_kube_region)-$(basename $tw_kube_env)/$(basename $tw_kube_namespace)"
  fi
}

# kubectl
kssec () {
	kubectl get secret $1 -o json | jq '.data | map_values(@base64d)'
}
alias kgpw="watch 'kubectl get pods'"

# eval "$(starship init zsh)"

# goland
export GOPATH=$HOME/golang
export GOPROXY="direct"
export GOROOT=/opt/homebrew/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.toml)"
fi

# nvm 
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# prod db access
function proddb {
    local EXTENSION=$2
    kubectl>/dev/null
    local NAMESPACE="$1"
    local K8S_DB_SECRET="postgres$EXTENSION"
    local DB=$(kubectl get secret -n $NAMESPACE $K8S_DB_SECRET -o json | jq -r .data.database | base64 -d)
    local USER=$(kubectl get secret -n $NAMESPACE $K8S_DB_SECRET -o json | jq -r .data.user | base64 -d)
    local HOST=$(kubectl get secret -n $NAMESPACE $K8S_DB_SECRET -o json | jq -r .data.host | base64 -d)
    local PASSWORD=$(kubectl get secret -n $NAMESPACE $K8S_DB_SECRET -o json | jq -r .data.password | base64 -d)
    # echo "Connecting to VPN Office Bonn"
    # networksetup -connectpppoeservice "VPN Office Bonn"
    # sleep 1
    PGPASSWORD=$PASSWORD pgcli -h $HOST -u $USER -d $DB
    # echo "Disconnecting from VPN Office Bonn"
    # networksetup -disconnectpppoeservice "VPN Office Bonn"
}

# ansible
ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible-leanix-vault-pass.txt
export PATH="/opt/homebrew/opt/ansible@8/bin:$PATH"

# fzf
source <(fzf --zsh)
# fzf git
source ~/.fzf-git.sh

# dotfiles alias to manage dotfiles via git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# neovim
alias n="nvim"

# azure cli - change tenant
alias azsap="az login --tenant 69b863e3-480a-4ee9-8bd0-20a8adb6909b"
alias azlx="az login --tenant 52ef8f7b-e339-4923-8e6a-fa9ee3304195"

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"
alias lg="lazygit"

# zoom
alias zoom="open -a zoom.us 'https://leanix.zoom.us/j/93512421375'"

# eza
if hash eza 2>/dev/null; then
  alias ls="eza --icons"
  alias ll="eza -l --icons"
  alias la="eza -la --icons"
  alias l="eza -l -h --icons"
  alias lr="eza -l --icons --sort-modified"
  alias tree="eza -T"
fi

# magic fix for watch to support aliases
alias watch="watch "

# zoxide
eval "$(zoxide init zsh)"
if hash zoxide 2>/dev/null; then
  alias cd="z"
fi

# Load Angular CLI autocompletion.
source <(ng completion script)
