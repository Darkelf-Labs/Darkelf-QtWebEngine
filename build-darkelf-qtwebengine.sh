#!/bin/zsh
set -euo pipefail
SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.11.2}"
BUILD="${2:-$HOME/Desktop/qtwebengine-darkelf-build}"
QT_PREFIX="${QT_PREFIX:-$(qtpaths6 --query QT_INSTALL_PREFIX 2>/dev/null || true)}"
[[ -n "$QT_PREFIX" ]] || { echo "Set QT_PREFIX to the matching Qt 6.11.2 installation prefix."; exit 1; }
[[ -x "$QT_PREFIX/bin/qt-configure-module" ]] || { echo "Missing $QT_PREFIX/bin/qt-configure-module"; exit 1; }
mkdir -p "$BUILD"
cd "$BUILD"
"$QT_PREFIX/bin/qt-configure-module" "$SRC" -webengine-proprietary-codecs -webengine-webrtc -DCMAKE_BUILD_TYPE=Release
cmake --build . --parallel "$(sysctl -n hw.logicalcpu)"
echo "Build completed in $BUILD"
echo "Do not overwrite PySide6 yet; test/stage the resulting QtWebEngine frameworks first."
