# Dotfiles

Manage my dotfiles across multiple diverse machines.

## Introduction

This repository serves as my dotfiles for managing and configuring various tools and applications. It includes a collection of configuration files that I use to set up and maintain a consistent development environment across different machines.

My primary focus is on macOS, but some of the configuration files may also be applicable to Linux.

## Features

- Manage dotfiles using [chezmoi](https://www.chezmoi.io).
- Package management:
  - [Homebrew](https://brew.sh) for macOS to manage packages and applications.
- Terminal: [WezTerm](https://wezfurlong.org/wezterm/) for terminal emulator.
- Shell:
  - [Zsh](https://zsh.org) as the default shell, manage plugins with [zinit](https://github.com/zdharma-continuum/zinit).
  - Configure [starship](https://starship.rs) for prompt customization.
- Manage all runtime versions with [asdf](https://asdf-vm.com).

## Usage

1. Install [chezmoi](https://www.chezmoi.io) and dotfiles.

    ```shell
    export PATH="${HOME}/.local/bin:$PATH"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${HOME}/.local/bin"
    chezmoi init --apply zikoengtsik
    ```

2. Restart shell to initialize shell.
3. Wait for zinit to finish installing plugins.
4. All done! :)

## License

Distributed under the MIT License. See [LICENSE.txt](LICENSE.txt) for more information.
