# Zsh Setup Scripts

This repository contains scripts to automate the setup and configuration of the Zsh shell for both desktop and server environments. The scripts configure Zsh with Oh My Zsh, plugins, themes, and other useful settings tailored to each environment.

## Table of Contents

- [Overview](#overview)
- [Scripts](#scripts)
  - [setup-zsh-desktop.sh](#setup-zsh-desktopsh)
  - [setup-zsh-proxmox.sh](#setup-zsh-proxmoxsh)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [For Desktop Environments](#for-desktop-environments)
  - [For Proxmox or Server Environments](#for-proxmox-or-server-environments)
- [Usage](#usage)
- [Configuration](#configuration)
  - [Desktop Version Configuration](#desktop-version-configuration)
  - [Proxmox/Server Version Configuration](#proxmoxserver-version-configuration)
- [Included Plugins and Tools](#included-plugins-and-tools)
- [Fonts (Desktop Only)](#fonts-desktop-only)
- [Proxmox-Specific Aliases (Server Only)](#proxmox-specific-aliases-server-only)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Overview

The repository includes two scripts:

1. **setup-zsh-desktop.sh**: Tailored for desktop environments, this script sets up Zsh with Oh My Zsh, Starship prompt, a variety of plugins, and installs the JetBrainsMono Nerd Font for enhanced terminal visuals.

2. **setup-zsh-proxmox.sh**: Designed for server environments like Proxmox, this script focuses on essential tools, includes server-specific aliases, and avoids installing unnecessary graphical components.

## Scripts

### setup-zsh-desktop.sh

- **Purpose**: Enhance your desktop command-line experience by setting up Zsh with powerful plugins and a visually appealing prompt.
- **Features**:
  - Installs and configures Zsh, Oh My Zsh, and Starship prompt.
  - Adds plugins like `zsh-autosuggestions` and `zsh-syntax-highlighting`.
  - Installs the JetBrainsMono Nerd Font for improved terminal rendering.
  - Configures `.zshrc` and `starship.toml` with customized settings.

### setup-zsh-proxmox.sh

- **Purpose**: Optimize your server environment with Zsh, including essential plugins and Proxmox-specific aliases.
- **Features**:
  - Installs Zsh and Oh My Zsh.
  - Configures a minimal prompt suitable for servers.
  - Includes useful server and Proxmox-specific aliases.
  - Excludes graphical components and font installations to keep the setup lightweight.

## Prerequisites

- **Operating System**: Linux distribution with one of the following package managers:
  - `apt-get` (Debian, Ubuntu, Proxmox)
  - `yum` / `dnf` (CentOS, Fedora)
  - `pacman` (Arch Linux)
- **Internet Connection**: Required to download packages and fonts.
- **Sudo Privileges**: Necessary for installing packages and changing the default shell.

## Installation

### For Desktop Environments

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/0xCcmndhd/setup_zsh_script.git
   cd setup_zsh_script
   ```

2. **Make the Script Executable**:

   ```bash
   chmod +x setup-zsh-desktop.sh
   ```

3. **Run the Script**:

   ```bash
   ./setup-zsh-desktop.sh
   ```

### For Proxmox or Server Environments

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/0xCcmndhd/setup_zsh_script.git
   cd setup_zsh_script
   ```

2. **Make the Script Executable**:

   ```bash
   chmod +x setup-zsh-proxmox.sh
   ```

3. **Run the Script**:

   ```bash
   ./setup-zsh-proxmox.sh
   ```

## Usage

- **Restart Your Terminal**: After running the script, it's recommended to close and reopen your terminal or log out and log back in to fully apply the changes.
- **Default Shell**: The script sets Zsh as the default shell. If it doesn't take effect immediately, you may need to manually change it or log out and log back in.

## Configuration

### Desktop Version Configuration

- **`.zshrc` Configuration**:
  - Sets up environment variables, aliases, and functions for enhanced productivity.
  - Configures Oh My Zsh with plugins like `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `autojump`, and more.
  - Includes helpful aliases and custom functions (`extract`, `mcd`).

- **`starship.toml` Configuration**:
  - Customizes the Starship prompt with modules for Git status, directories, programming languages, and more.
  - Includes visual enhancements using icons (requires Nerd Font).

### Proxmox/Server Version Configuration

- **`.zshrc` Configuration**:
  - Focuses on essential options and server-specific aliases.
  - Configures Oh My Zsh with plugins like `git`, `sudo`, and `debian`.
  - Includes Proxmox-specific aliases for efficient management.

- **`starship.toml` Configuration**:
  - Simplified prompt configuration suitable for server environments.
  - Avoids graphical elements not relevant for command-line servers.

## Included Plugins and Tools

- **Common to Both Scripts**:
  - **[Oh My Zsh](https://ohmyz.sh/)**: Framework for managing Zsh configuration.
  - **Essential Plugins**: Includes `git`, `sudo`, and others as appropriate.
  - **Aliases**: A set of helpful command-line shortcuts.

- **Desktop Version Only**:
  - **[Starship Prompt](https://starship.rs/)**: Fast, customizable, and intelligent prompt.
  - **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**: Suggests commands as you type.
  - **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**: Provides syntax highlighting.
  - **[autojump](https://github.com/wting/autojump)**: Faster directory navigation.
  - **[JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)**: Font with a huge number of glyphs/icons.

- **Proxmox/Server Version Only**:
  - **Proxmox Aliases**: Shortcuts for common Proxmox commands.
  - **Server Monitoring Aliases**: For system administration tasks.
  - Excludes plugins that require graphical support.

## Fonts (Desktop Only)

- The `setup-zsh-desktop.sh` script installs the JetBrainsMono Nerd Font to your local fonts directory.
- **After installation**, configure your terminal emulator to use `JetBrainsMono Nerd Font`.
  - **Example**: In your terminal settings, select `JetBrainsMono Nerd Font` as the font.

## Proxmox-Specific Aliases (Server Only)

The `setup-zsh-proxmox.sh` script includes several aliases to simplify Proxmox management:

- **System Monitoring and Administration**:
  - `ll`: `ls -alF` (detailed list)
  - `la`: `ls -A` (list all files except `.` and `..`)
  - `l`: `ls -CF` (list entries by columns)
  - `df`: `df -h` (disk free space)
  - `free`: `free -h` (memory usage)
  - `top`: `htop` (interactive processes viewer)
  - `ports`: `netstat -tulanp` (list open ports)
  - `update`: `apt update && apt upgrade` (system update)
  - `syslog`: `tail -f /var/log/syslog` (follow system log)

- **Proxmox-Specific Commands**:
  - `pct`: `pct list` (list LXC containers)
  - `qm`: `qm list` (list virtual machines)
  - `vzlist`: `vzlist -a` (list OpenVZ containers)
  - `vzbackup`: `vzdump` (backup containers/VMs)
  - `checkbackup`: `ls -l /var/lib/vz/dump/` (check backup files)
  - `storage`: `pvesm status` (check storage status)
  - `nets`: `ip a` (network interfaces)
  - `logs`: `journalctl -xen 50` (view system logs)

- **Other Useful Aliases**:
  - `..`: `cd ..` (up one directory)
  - `...`: `cd ../..` (up two directories)
  - `grep`: `grep --color=auto` (highlight search term)

These aliases are intended to streamline common tasks and make server management more efficient.

## Troubleshooting

- **Zsh Not Set as Default Shell**:
  - If Zsh isn't your default shell after running the script, log out and log back in, or manually change it:
    ```bash
    chsh -s $(which zsh)
    ```
- **Font Issues (Desktop Version)**:
  - If icons or characters don't display correctly, ensure your terminal is set to use `JetBrainsMono Nerd Font`.
  - Rebuild font cache if necessary:
    ```bash
    fc-cache -f ~/.local/share/fonts
    ```
- **Plugin Errors**:
  - Ensure plugins are installed in `~/.oh-my-zsh/custom/plugins/`.
  - Restart your terminal session to reload configurations.
- **Unsupported Package Manager**:
  - If your system uses a different package manager, you may need to manually install required packages.

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute these scripts.
