#!/usr/bin/env bash

# Exit on error
set -e

# Set the bin directory
bin_dir="$(mktemp -d)"

# Clean up on exit or error
trap 'rm -rf ${bin_dir}' EXIT SIGINT SIGTERM

# Install chezmoi
export PATH="${bin_dir}:${PATH}"
if [ ! "$(command -v chezmoi)" ]; then
  chezmoi="${bin_dir}/chezmoi"
  if [ "$(command -v curl)" ]; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "${bin_dir}"
  elif [ "$(command -v wget)" ]; then
    sh -c "$(wget -qO- get.chezmoi.io)" -- -b "${bin_dir}"
  else
    echo "To install chezmoi, you must have curl or wget installed." >&2
    exit 1
  fi
else
    chezmoi="chezmoi"
fi

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

# Exec: replace current process with chezmoi init
exec "${chezmoi}" init --apply "--source=${script_dir}"
