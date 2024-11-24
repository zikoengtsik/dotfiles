# Dotfiles

Manage my dotfiles across multiple diverse machines.

## Features

- Designed to work on macOS.
- Use [Homebrew](https://brew.sh)(macOS) for package management.
- Use Zsh as default shell, manage Zsh plugin by [zinit](https://github.com/zdharma-continuum/zinit).
- Customizable prompt by [starship](https://github.com/starship/starship).
- Git configuration and ignore files.
- Manage all runtime versions with [asdf](https://asdf-vm.com/).
  - Python, use [poetry](https://python-poetry.org) for dependency management and packaging.
  - Node.js, use [npm](https://docs.npmjs.com/) as package manager.
  - Golang, use [Go Modules](https://golang.org/ref/mod) for dependency management.

## Usage

1. Install [chezmoi](https://github.com/twpayne/chezmoi) to manage dotfiles.

    ```shell
    export PATH="${HOME}/.local/bin:$PATH"
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${HOME}/.local/bin
    ```

2. Run `chezmoi init` to initialize dotfiles.

    ```shell
    chezmoi init --apply --source="$(pwd -P)"
    ```

3. Restart your shell. Now you can use `chezmoi` to manage dotfiles.

## License

[MIT](LICENSE)
