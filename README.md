[![License Badge](https://img.shields.io/github/license/theweak1/dotfiles)](https://github.com/theweak1/dotfiles/blob/main/LICENSE)
[![Issues Badge](https://img.shields.io/github/issues/theweak1/dotfiles)](https://github.com/theweak1/dotfiles/issues)
[![Pull Requests Badge](https://img.shields.io/github/issues-pr/theweak1/dotfiles)](https://github.com/theweak1/dotfiles/pulls)
[![Contributors Badge](https://img.shields.io/github/contributors/theweak1/dotfiles)](https://github.com/theweak1/dotfiles/graphs/contributors)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/theweak1/dotfiles/issues)

# dotfiles
Dotfiles are configuration files used to customize and personalize your Unix-based system. This repository contains my dotfiles for WSL and Ubuntu.

I'm learning about dotfiles at [dotfiles.eieio.xyz](http://dotfiles.eieio.xyz).

## Table of Contents
- [Quick Start](#quick-start)
- [Manual Installation](#manual-installation)
- [Dependencies](#dependencies)
- [What Gets Installed](#what-gets-installed)
- [Dotbot Integration](#dotbot-integration)
- [Credits](#credits)
- [TODO](#todo)
- [Tmux](#tmux)
- [gitconfig](#gitconfig)
- [LICENSE](#license)

## Quick Start

Install on a new device with a single command:

```bash
curl -sL https://raw.githubusercontent.com/theweak1/dotfiles/main/bootstrap.sh | bash
```

Or if you already have the repo cloned:

```bash
cd ~/.dotfiles && ./bootstrap.sh
```

## Manual Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/theweak1/dotfiles.git ~/.dotfiles
   ```
2. Navigate to the repository directory:
   ```bash
   cd ~/.dotfiles
   ```
3. Run the installation script:
   ```bash
   ./install
   ```

This will create the necessary symbolic links and set up your environment using Dotbot.

## Dependencies
- Ensure you have the required software installed, such as Git, etc.
- Some configurations may be specific to certain terminals or shells. Ensure you have the necessary tools installed.

## What Gets Installed

This dotfiles setup automatically installs and configures:

### Shell & Terminal
- **Fish Shell** - Modern shell with intelligent autosuggestions
- **Starship** - Fast, customizable prompt
- **Fisher** - Plugin manager for Fish
- **Tmux** - Terminal multiplexer
- **Tmuxifier** - Tmux session management

### Development Tools
- **Git** - Version control
- **Lazygit** - TUI for Git
- **Delta** - Git pager with syntax highlighting
- **Node.js** - JavaScript runtime (via n)
- **Go** - Go programming language
- **Docker** - Container platform
- **Lazydocker** - Docker TUI

### CLI Utilities
- **bat** - Cat clone with syntax highlighting
- **eza** - Modern ls replacement (maintained fork of exa)
- **fzf** - Fuzzy finder
- **tree** - Directory listing
- **ripgrep** - Fast grep alternative
- **jq** - JSON processor

### Desktop Applications
- **Backdrop** - Desktop wallpaper manager
- **Brave Browser** - Privacy-focused web browser
- **Discord** - Voice and text chat
- **WhatsApp** - Messaging app (via Flatpak)
- **Spotify** - Music streaming

### Editor
- **Neovim** - Hyperextensible Vim-based editor

## Configuration Files

The following configuration files are managed:
- `~/.aliases` - Bash/Fish aliases and PATH exports
- `~/.config/fish/config.fish` - Fish shell main config
- `~/.config/fish/config-linux.fish` - Linux-specific Fish config
- `~/.tmux.conf` - Tmux configuration
- `~/.gitconfig` - Git configuration
- `~/.config/starship/starship.toml` - Starship prompt config
- `~/.config/bat/` - Bat configuration

### Credits

Dotbot was created by [Anish Athalye][Anish]. Special thanks to him for developing such a useful tool for the dotfiles community.

## TODO
- Terminal Preferences
- Git (config and SSH)

## Tmux
To finish the Tmux setup, run the following command in a Tmux session:
```bash
tmux source ~/.config/tmux/tmux.conf
```

## gitconfig
If you fork this project, update the `gitconfig` file with your own user information. Specifically, update the `name` and `email` fields. You can find your own non-reply email on GitHub under `setting -> Emails`. Below your primary email, you'll see this message:

![no-reply image message][no-reply]

Additionally, while in the `Emails` section of your settings, ensure you have these options marked:

![protect email options][email-options]

## License

Copyright (c) Lenier Ortiz. Released under the MIT License. See [LICENSE.md][license] for details.


[dotbot]: https://github.com/anishathalye/dotbot
[no-reply]: ./assets/no-reply-email.png
[email-options]: ./assets/email-options.png
[license]: ./LICENSE.md
[Anish]: https://github.com/anishathalye
