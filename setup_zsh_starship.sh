#!/bin/bash

###
# Setup Zsh, Oh My Zsh, Starship Prompt, Plugins, and JetBrainsMono Nerd Font
# Corrected version: Removes unnecessary backslashes in starship.toml to fix parse errors.
###

set -e  # Exit immediately if a command exits with a non-zero status.

# Determine the package manager
if command -v apt-get >/dev/null 2>&1; then
    PM="apt-get"
elif command -v yum >/dev/null 2>&1; then
    PM="yum"
elif command -v dnf >/dev/null 2>&1; then
    PM="dnf"
elif command -v pacman >/dev/null 2>&1; then
    PM="pacman"
else
    echo "Supported package manager not found. Please install packages manually."
    exit 1
fi

# Update package lists (if applicable)
if [ "$PM" = "apt-get" ]; then
    sudo apt-get update -y
elif [ "$PM" = "pacman" ]; then
    sudo pacman -Sy
fi

# Install necessary packages
echo "Installing necessary packages..."
case "$PM" in
    apt-get)
        sudo apt-get install -y zsh git curl wget unzip fontconfig autojump
        ;;
    yum)
        sudo yum install -y zsh git curl wget unzip fontconfig autojump
        ;;
    dnf)
        sudo dnf install -y zsh git curl wget unzip fontconfig autojump
        ;;
    pacman)
        sudo pacman -S --noconfirm zsh git curl wget unzip fontconfig autojump
        ;;
esac

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

# Add Starship to the zsh configuration
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Install zsh-autosuggestions plugin
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install JetBrainsMono Nerd Font
echo "Installing JetBrainsMono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"
FONT_TMP_DIR=$(mktemp -d)

curl -fLo "$FONT_TMP_DIR/JetBrainsMono.zip" "$FONT_URL"
unzip -o "$FONT_TMP_DIR/JetBrainsMono.zip" -d "$FONT_TMP_DIR"
find "$FONT_TMP_DIR" -name "*.[o,t]tf" -type f -exec cp {} "$FONT_DIR/" \;
rm -rf "$FONT_TMP_DIR"

# Refresh font cache
if command -v fc-cache >/dev/null 2>&1; then
    echo "Updating font cache..."
    fc-cache -f "$FONT_DIR"
else
    echo "Fontconfig is not available. Skipping font cache update."
fi

# Configure .zshrc file
echo "Configuring .zshrc..."
cat > ~/.zshrc << 'EOF'
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set Zsh options
setopt autocd             # Auto-change to a directory by typing its name
setopt appendhistory      # Append history instead of overwriting
setopt sharehistory       # Share history across all sessions
setopt histignoredups     # Ignore duplicate history entries
setopt inc_append_history # Add commands as they are typed, not just at exit

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Prompt configuration using Starship
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# Aliases
alias ll='ls -alF'        # Long listing format
alias la='ls -A'          # All files except . and ..
alias l='ls -CF'          # Column-wise listing
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias ..='cd ..'
alias ...='cd ../..'

# Export editor
export EDITOR='nano'      # Or 'vim', 'nvim', 'code', etc.

# Path additions
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Plugin configuration using Oh My Zsh
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
  extract
  sudo
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Custom functions

# Extract archives easily
extract () {
  if [ -f "$1" ] ; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"    ;;
      *.tar.gz)    tar xzf "$1"    ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xf "$1"     ;;
      *.tbz2)      tar xjf "$1"    ;;
      *.tgz)       tar xzf "$1"    ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create a directory and navigate into it
mcd () {
  mkdir -p "$1" && cd "$1";
}

EOF

# Create .config directory if not exists
mkdir -p ~/.config

# Configure starship.toml
echo "Configuring Starship prompt..."
cat > ~/.config/starship.toml << 'EOF'
# Don't print a new line at the start of the prompt
add_newline = false

# Prompt format
format = """$all$character"""

# Use a custom prompt character
[character]
success_symbol = "[➜](bold green) "
error_symbol = "[➜](bold red) "

# Directory module
[directory]
truncation_length = 3
truncation_symbol = "…/"
home_symbol = "~"

# Git status module
[git_status]
conflicted = "⚔️ "
ahead = "⇡${count}"
behind = "⇣${count}"
staged = "[+${count}](green)"
modified = "[~${count}](red)"
untracked = "[?${count}](yellow)"
deleted = "🗑️ "
renamed = "➡️ "
style = "bold yellow"

# Git branch module
[git_branch]
symbol = "🌱 "

# Node.js module
[nodejs]
format = "via [🌐 v${version}]($style) "

# Python module
[python]
format = "via [🐍 v${version}]($style) "

# Rust module
[rust]
format = "via [🦀 v${version}]($style) "

# Package module
[package]
format = "[$symbol$version]($style) "
symbol = "📦 "

# Disable unused modules
[aws]
disabled = true

[gcloud]
disabled = true

[env_var]
disabled = true

[hostname]
disabled = true

[line_break]
disabled = true

[username]
disabled = true

# Battery status module
[battery]
full_symbol = "🔋 "
charging_symbol = "⚡️ "
discharging_symbol = "🔌 "
display = [
  { threshold = 10, style = "bold red" },
  { threshold = 30, style = "bold yellow" },
  { style = "bold green" }
]

# Time module
[time]
disabled = false
format = "at [🕙 $time]($style) "
time_format = "%H:%M"

# Command duration module
[cmd_duration]
min_time = 2000  # Show command duration if it exceeds 2 seconds
format = "took [$duration]($style) "
style = "bold yellow"

# Custom module example (e.g., Kubernetes context)
[custom.k8s]
command = "kubectl config current-context"
when = "command -v kubectl > /dev/null"
format = "on [⎈ $output](bold blue) "
EOF

# Set Zsh as the default shell
echo "Changing default shell to Zsh..."
chsh -s "$(which zsh)" || echo "Please log out and log back in to use Zsh as the default shell."

echo "Setup complete! Please restart your terminal or log out and log back in to start using Zsh with your new configuration."
