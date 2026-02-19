# oh-my-zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(zoxide history-substring-search docker kubectl azure fzf)

if [[ $- == *i* ]]; then
  source $ZSH/oh-my-zsh.sh
fi

# Initialize zoxide for non-interactive shells too
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# Set neovim as the default editor
export EDITOR='nvim'

# complete command based on history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# bat
export BAT_THEME_DARK="tokyonight_night"
export BAT_THEME_LIGHT="tokyonight_day"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.oh-my-posh.toml)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# ansible
export PATH="/opt/homebrew/opt/ansible@8/bin:$PATH"

# fzf
source <(fzf --zsh)
# fzf git
source ~/.fzf-git.sh

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"

source ~/.zshaliases

# Load private environment variables (API keys, tokens, etc.)
# This file is not tracked in git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# homebrew installed apps completion
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit && compinit

# sdkman
if [[ -d /opt/homebrew/opt/sdkman-cli/libexec ]]; then
  export SDKMAN_DIR=/opt/homebrew/opt/sdkman-cli/libexec
  [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

. "$HOME/.local/bin/env"
