---

# Setup Zsh Script

This script automates the setup and configuration of the Zsh shell with Oh My Zsh, Starship prompt, and various useful plugins, as well as installs the JetBrainsMono Nerd Font for enhanced terminal visuals.

## Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Configuration](#configuration)
- [Included Plugins and Tools](#included-plugins-and-tools)
- [Font Installation](#font-installation)
- [Troubleshooting](#troubleshooting)
- [License](#license)

## Features

- **Automated Installation**: Installs Zsh, Oh My Zsh, Starship prompt, essential plugins, and the JetBrainsMono Nerd Font automatically.
- **Custom Configuration**: Sets up `.zshrc` and `starship.toml` with optimized settings and aliases.
- **Plugin Integration**: Incorporates useful Zsh plugins for an enhanced command-line experience.
- **Cross-Package Manager Support**: Supports `apt-get`, `yum`, `dnf`, and `pacman` package managers.

## Prerequisites

- **Operating System**: Linux distribution with one of the following package managers:
  - `apt-get` (Debian, Ubuntu)
  - `yum` / `dnf` (CentOS, Fedora)
  - `pacman` (Arch Linux)
- **Internet Connection**: Required to download packages and fonts.
- **Sudo Privileges**: Necessary for installing packages and changing the default shell.

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/yourusername/setup-zsh-script.git
   cd setup-zsh-script
   ```

2. **Make the Script Executable**:

   ```bash
   chmod +x setup-zsh.sh
   ```

3. **Run the Script**:

   ```bash
   ./setup-zsh.sh
   ```

   *Alternatively, if you prefer to run it with `bash`:*

   ```bash
   bash setup-zsh.sh
   ```

## Usage

- **Restart Your Terminal**: After running the script, it's recommended to close and reopen your terminal or log out and log back in to fully apply the changes.
- **Default Shell**: The script attempts to set Zsh as the default shell. If it doesn't take effect immediately, you may need to manually change it or log out and log back in.

## Configuration

- **`.zshrc` Configuration**:
  - Sets up environment variables, aliases, and functions.
  - Configures Oh My Zsh plugins.
  - Includes useful settings like history sharing and auto-correction.

- **`starship.toml` Configuration**:
  - Customizes the Starship prompt appearance.
  - Configures modules for Git status, directory display, programming languages, and more.

- **Custom Functions**:
  - `extract`: Easily extract various archive file types.
  - `mcd`: Create a directory and navigate into it immediately.

## Included Plugins and Tools

- **[Oh My Zsh](https://ohmyz.sh/)**: Framework for managing your Zsh configuration.
- **[Starship Prompt](https://starship.rs/)**: Fast, customizable, and intelligent prompt for any shell.
- **[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**: Suggests commands as you type based on history and completions.
- **[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)**: Provides syntax highlighting for the command line.
- **[autojump](https://github.com/wting/autojump)**: A faster way to navigate your filesystem from the command line.
- **[JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)**: A font that includes a high number of glyphs/icons for a better terminal experience.

## Font Installation

- The script installs the JetBrainsMono Nerd Font to your local fonts directory.
- **After installation**, you may need to configure your terminal emulator to use the JetBrainsMono Nerd Font.
  - **Example**: In GNOME Terminal or other terminal applications, go to the preferences/settings and set the font to `JetBrainsMono Nerd Font`.

## Troubleshooting

- **Zsh Not Set as Default Shell**:
  - If Zsh isn't your default shell after running the script, log out and log back in, or manually change it:
    ```bash
    chsh -s $(which zsh)
    ```
- **Font Issues**:
  - If the font isn't displaying correctly, ensure your terminal is set to use the JetBrainsMono Nerd Font.
  - Rebuild the font cache:
    ```bash
    fc-cache -f ~/.local/share/fonts
    ```
- **Plugin Errors**:
  - If you experience issues with plugins, ensure they are properly installed in the `~/.oh-my-zsh/custom/plugins/` directory.
- **Unsupported Package Manager**:
  - The script currently supports `apt-get`, `yum`, `dnf`, and `pacman`. If your system uses a different package manager, you may need to install the required packages manually.

## License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this script.

---
