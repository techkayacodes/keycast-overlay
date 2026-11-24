#!/usr/bin/env bash
# Install keycast-overlay to ~/.local/bin.
set -euo pipefail

missing=()
command -v showmethekey-cli >/dev/null || missing+=("showmethekey")
[ -e /usr/lib/libgtk4-layer-shell.so ] || missing+=("gtk4-layer-shell")
python3 -c "import gi, cairo" 2>/dev/null || missing+=("python-gobject python-cairo")
if [ ${#missing[@]} -gt 0 ]; then
  echo "Missing dependencies: ${missing[*]}"
  echo "On Arch: sudo pacman -S --needed showmethekey gtk4-layer-shell python-gobject python-cairo"
  exit 1
fi

mkdir -p "$HOME/.local/bin"
install -m 755 "$(dirname "$0")/keycast-overlay" "$HOME/.local/bin/keycast-overlay"
echo "Installed to ~/.local/bin/keycast-overlay. Run: keycast-overlay"
