# oh-my-zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(gitfast zoxide history-substring-search docker kubectl azure fzf)

source $ZSH/oh-my-zsh.sh

# Set neovim as the default editor
export EDITOR='nvim'

# complete command based on history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# bat
export BAT_THEME_DARK="tokyonight_night"
export BAT_THEME_LIGHT="tokyonight_day"

# jenv
eval "$(jenv init -)"

# python
# export PATH="$(pyenv root)/shims:${PATH}"

# goland
# export GOPATH=$HOME/golang
# export GOPROXY="direct"
# export GOROOT=/opt/homebrew/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

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

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"

# Load Angular CLI autocompletion.
# source <(ng completion script)

source ~/.zshaliases

# google Gemini
export GOOGLE_API_KEY="REPLACE_WITH_YOUR_GOOGLE_API_KEY"
export AZURE_OPENAI_KEY="REPLACE_WITH_YOUR_AZURE_KEY"


# jira
export JIRA_API_TOKEN="REPLACE_WITH_YOUR_JIRA_TOKEN"

# homebrew installed apps completion
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit
