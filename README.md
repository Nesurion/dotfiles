# dotfiles

Personal dotfiles managed using a bare Git repository.

## Setup

### First-time installation

```bash
# Clone the dotfiles repo to a bare repository
git clone --bare git@github.com:Nesurion/dotfiles.git $HOME/.dotfiles

# Create an alias for managing dotfiles
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# Checkout the dotfiles
dotfiles checkout

# Set the flag to not show untracked files
dotfiles config --local status.showUntrackedFiles no
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

Use the `dotfiles` alias instead of `git`:

```bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Update vimrc"
dotfiles push
```

## What's included

- **zsh** configuration with oh-my-zsh
- **vim/neovim** configuration
- **git** configuration
- **tmux** configuration with TPM plugins and custom Oasis theme
- Various dotfiles for tools like fzf, lazygit, etc.

## tmux

### Plugin manager

Plugins are managed via [TPM](https://github.com/tmux-plugins/tpm). Install it once:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then inside tmux, press `prefix + I` to fetch and install all plugins.

### Plugins

| Plugin                                                            | Purpose                                                 |
| ----------------------------------------------------------------- | ------------------------------------------------------- |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)    | Sane defaults everyone can agree on                     |
| [tmux-oasis](https://github.com/uhs-robert/tmux-oasis)            | Status bar theme framework                              |
| [tmux-fzf-url](https://github.com/wfxr/tmux-fzf-url)              | Open URLs from terminal history with fzf (`prefix + u`) |
| [tmux-floax](https://github.com/omerxx/tmux-floax)                | Floating scratch pane (`prefix + f`, menu `prefix + F`) |
| [tmux-which-key](https://github.com/alexwforsythe/tmux-which-key) | Which-key popup for tmux bindings                       |

### Custom Oasis Tokyo Night Moon theme

The repo ships a custom colorscheme for tmux-oasis based on the [Tokyo Night Moon](https://github.com/folke/tokyonight.nvim) palette. The theme file lives at:

```
~/.tmux/plugins/tmux-oasis/themes/dark/oasis_tokyonight_moon_dark.conf
```

It is **not bundled with the upstream tmux-oasis plugin** — after installing plugins via TPM you need to copy or symlink it into the plugin's themes directory:

```bash
# copy
cp ~/.config/tmux/themes/oasis_tokyonight_moon_dark.conf \
   ~/.tmux/plugins/tmux-oasis/themes/dark/

# or symlink (survives theme file edits without re-copying)
ln -s ~/.config/tmux/themes/oasis_tokyonight_moon_dark.conf \
      ~/.tmux/plugins/tmux-oasis/themes/dark/oasis_tokyonight_moon_dark.conf
```

The theme is selected in `~/.config/tmux/tmux.conf` via:

```tmux
set -g @oasis_flavor 'tokyonight_moon_dark'
```

> **Note:** tmux-oasis only auto-appends `_dark` for its built-in theme names. `tokyonight_moon` is a custom theme, so the full suffix `_dark` must be included explicitly.

## Security

Private credentials and API keys are stored in `~/.zshrc.local` which is not tracked in git.
