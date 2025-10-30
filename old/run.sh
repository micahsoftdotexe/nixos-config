#!/usr/bin/env bash
set -euo pipefail

# Directory containing the NixOS configuration (defaults to current dir)
CONFIG_DIR="${1:-$(pwd)}"

# Use configuration.nix in the directory
CONFIG_FILE="${CONFIG_DIR}/configuration.nix"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ No configuration.nix found in $CONFIG_DIR"
  exit 1
fi

echo "🔧 Building NixOS configuration from: $CONFIG_FILE"

# Run the build
sudo nixos-rebuild switch -I nixos-config="${CONFIG_FILE}"

echo "✅ Build completed. Result link: ./result"


