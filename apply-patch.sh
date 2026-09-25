#!/bin/zsh
set -euo pipefail
SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.11.2}"
HERE="$(cd "$(dirname "$0")" && pwd)"
[[ -f "$SRC/src/core/authenticator_request_client_delegate_qt.cpp" ]] || { echo "QtWebEngine 6.11.2 source not found at: $SRC"; exit 1; }
cd "$SRC"
patch -p1 --dry-run < "$HERE/patches/001-darkelf-macos-touchid.patch"
patch -p1 < "$HERE/patches/001-darkelf-macos-touchid.patch"
echo "Darkelf Touch ID patch applied."
