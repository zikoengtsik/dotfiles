#!/bin/bash

# -e: exit on error
set -e

if [ $OSTYPE = darwin* ]; then
  # Install Xcode Command Line Tools
  if [ ! -d $(xcode-select -p) ]; then
    echo "Installing Xcode Command Line Tools..."
    xcode-select --install
  fi
fi

BIN_DIR="${HOME}/.local/bin"
export PATH="${BIN_DIR}:${PATH}"

if ! chezmoi="$(command -v chezmoi)"; then
  chezmoi="${BIN_DIR}/chezmoi"
  echo "Installing chezmoi to '${chezmoi}'" >&2
  if command -v curl >/dev/null; then
    chezmoi_install_script="$(curl -fsSL https://chezmoi.io/get)"
  elif command -v wget >/dev/null; then
    chezmoi_install_script="$(wget -qO- https://chezmoi.io/get)"
  else
    echo "To install chezmoi, you must have curl or wget installed."
    exit 1
  fi
  sh -c "${chezmoi_install_script}" -- -b "${BIN_DIR}"
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

set -- init --apply --source="${script_dir}"

echo "Running 'chezmoi $*'"
# exec: replace current process with chezmoi
exec "$chezmoi" "$@"
