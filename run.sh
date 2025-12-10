#!/usr/bin/env bash
set -euo pipefail

# Usage: ./run.sh [system] [config_dir]
# system: the flake system (e.g., desktop, laptop, server)
# config_dir: directory containing flake.nix (optional, defaults to current dir)

SYSTEM="${1:-desktop}"
CONFIG_DIR="${2:-$(pwd)}"
FLAKE_FILE="${CONFIG_DIR}/flake.nix"

if [[ ! -f "$FLAKE_FILE" ]]; then
  echo "❌ No flake.nix found in $CONFIG_DIR"
  exit 1
fi

echo "🔧 Building NixOS configuration from: $FLAKE_FILE (system: $SYSTEM)"

# Run the build

if [[ "$SYSTEM" == "surface" ]]; then
  echo "📡 Using remote build host: micaht@micahtronserver"
  sudo nixos-rebuild switch --flake ".#${SYSTEM}" --upgrade --build-host micaht@micahtronserver
else
  sudo nixos-rebuild switch --flake ".#${SYSTEM}" --upgrade
fi

echo "✅ Build completed and switched."