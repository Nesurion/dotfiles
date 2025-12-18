# dotfiles

Personal dotfiles managed using a bare Git repository.

## Setup

### First-time installation

```bash
# Clone the dotfiles repo to a bare repository
git clone --bare git@github.com:Nesurion/dotfiles.git $HOME/.dotfiles

# Create an alias for managing dotfiles
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Checkout the dotfiles
config checkout

# Set the flag to not show untracked files
config config --local status.showUntrackedFiles no
```

### Configure private environment variables

1. Copy the example file:
   ```bash
   cp ~/.zshrc.local.example ~/.zshrc.local
   ```

2. Edit `~/.zshrc.local` and fill in your actual values:
   - Google API key
   - Azure OpenAI key
   - Jira API token
   - Any other private credentials

3. Never commit `.zshrc.local` - it's already in `.gitignore`

## Usage

Use the `config` alias instead of `git`:

```bash
config status
config add .vimrc
config commit -m "Update vimrc"
config push
```

## What's included

- **zsh** configuration with oh-my-zsh
- **vim/neovim** configuration
- **git** configuration
- Various dotfiles for tools like fzf, lazygit, etc.

## Security

Private credentials and API keys are stored in `~/.zshrc.local` which is not tracked in git.