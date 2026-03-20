# oh-my-zsh
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(zoxide history-substring-search docker kubectl azure fzf)

if [[ $- == *i* ]]; then
  source $ZSH/oh-my-zsh.sh
fi

# Initialize zoxide (cached)
_zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zoxide_init.zsh"
if [[ ! -f "$_zoxide_cache" ]] || [[ $(whence -p zoxide) -nt "$_zoxide_cache" ]]; then
  mkdir -p "${_zoxide_cache:h}"
  zoxide init zsh > "$_zoxide_cache"
fi
source "$_zoxide_cache"
unset _zoxide_cache

# Set neovim as the default editor
export EDITOR='nvim'

# complete command based on history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# bat
export BAT_THEME_DARK="tokyonight_night"
export BAT_THEME_LIGHT="tokyonight_day"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  _omp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/omp_init.zsh"
  if [[ ! -f "$_omp_cache" ]] || [[ $(whence -p oh-my-posh) -nt "$_omp_cache" ]] || [[ ~/.oh-my-posh.toml -nt "$_omp_cache" ]]; then
    mkdir -p "${_omp_cache:h}"
    oh-my-posh init zsh --config ~/.oh-my-posh.toml > "$_omp_cache"
  fi
  source "$_omp_cache"
  unset _omp_cache
fi

# fnm (fast node manager, replaces nvm)
eval "$(fnm env --use-on-cd --shell zsh)"

# ansible
export PATH="/opt/homebrew/opt/ansible@8/bin:$PATH"

# fzf (cached)
_fzf_cache="${XDG_CACHE_HOME:-$HOME/.cache}/fzf_init.zsh"
if [[ ! -f "$_fzf_cache" ]] || [[ $(whence -p fzf) -nt "$_fzf_cache" ]]; then
  mkdir -p "${_fzf_cache:h}"
  fzf --zsh > "$_fzf_cache"
fi
source "$_fzf_cache"
unset _fzf_cache
# fzf git
source ~/.fzf-git.sh

# lazygit
export XDG_CONFIG_HOME="$HOME/.config"

source ~/.zshaliases

# Load private environment variables (API keys, tokens, etc.)
# This file is not tracked in git
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# homebrew installed apps completion (cached — rebuilds once per day)
fpath+=/opt/homebrew/share/zsh/site-functions
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# sdkman
if [[ -d /opt/homebrew/opt/sdkman-cli/libexec ]]; then
  export SDKMAN_DIR=/opt/homebrew/opt/sdkman-cli/libexec
  [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
fi

. "$HOME/.local/bin/env"
