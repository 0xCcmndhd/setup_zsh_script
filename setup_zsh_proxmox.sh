#!/bin/bash
###
# Setup Zsh and Oh My Zsh for Proxmox (Server Version)
###
set -e

# Update package lists
apt-get update -y

# Install essential packages only
apt-get install -y zsh git curl wget

# Install Oh My Zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install Starship Prompt
if ! command -v starship >/dev/null 2>&1; then
    echo "Installing Starship Prompt..."
    curl -fsSL https://starship.rs/install.sh | sh -s -- --yes
fi

# Configure .zshrc file (simplified for server use)
echo "Configuring .zshrc..."
cat > ~/.zshrc << 'EOF'
# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set Zsh options
setopt appendhistory
setopt sharehistory
setopt histignoredups

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Starship prompt
eval "$(starship init zsh)"

# Server-focused aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias df='df -h'
alias free='free -h'
alias top='htop'
alias ports='netstat -tulanp'
alias update='apt update && apt upgrade'
alias syslog='tail -f /var/log/syslog'

# Proxmox-specific aliases
alias pct='pct list'
alias qm='qm list'
alias vzlist='vzlist -a'

# Plugin configuration
plugins=(
  git
  sudo
  debian
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh
EOF

# Create minimal starship configuration
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
add_newline = false

[character]
success_symbol = "[➜](bold green) "
error_symbol = "[➜](bold red) "

[directory]
truncation_length = 3
truncation_symbol = "…/"

[git_branch]
symbol = "🌱 "

[cmd_duration]
min_time = 2000
format = "took [$duration]($style) "

[hostname]
ssh_only = false
format = "[$hostname]($style)"
style = "bold green"

[username]
show_always = true
format = "[$user]($style)@"
style_user = "bold blue"
EOF

# Set Zsh as the default shell
chsh -s "$(which zsh)" || echo "Please log out and log back in to use Zsh as the default shell."

echo "Setup complete! Please restart your terminal or log out and log back in to start using Zsh."
