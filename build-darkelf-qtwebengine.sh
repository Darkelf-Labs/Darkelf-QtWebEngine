#!/bin/zsh
set -euo pipefail

SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.11.2}"
BUILD="${2:-$HOME/Desktop/qtwebengine-darkelf-build}"
QT_PREFIX="${QT_PREFIX:-$(qtpaths6 --query QT_INSTALL_PREFIX 2>/dev/null || true)}"

[[ -n "$QT_PREFIX" ]] || {
    echo "Set QT_PREFIX to the matching Qt 6.11.2 installation prefix."
    return 1 2>/dev/null || false
}

[[ -x "$QT_PREFIX/bin/qt-configure-module" ]] || {
    echo "Missing $QT_PREFIX/bin/qt-configure-module"
    return 1 2>/dev/null || false
}

[[ -d "$SRC" ]] || {
    echo "QtWebEngine source directory not found:"
    echo "$SRC"
    return 1 2>/dev/null || false
}

mkdir -p "$BUILD"
cd "$BUILD"

echo "=============================================="
echo " Darkelf QtWebEngine 6.11.2"
echo " Darkelf Shadow 7.0.11"
echo "=============================================="
echo
echo "Source:"
echo "  $SRC"
echo
echo "Build:"
echo "  $BUILD"
echo
echo "Qt:"
echo "  $QT_PREFIX"
echo
echo "Configuration:"
echo "  Proprietary codecs: ENABLED"
echo "  H.264 media support: ENABLED via Qt/Chromium codec configuration"
echo "  WebRTC: DISABLED"
echo "  Build type: Release"
echo

"$QT_PREFIX/bin/qt-configure-module" "$SRC" \
    -webengine-proprietary-codecs \
    -no-webengine-webrtc \
    -DCMAKE_BUILD_TYPE=Release

echo
echo "QtWebEngine configuration completed."
echo "Starting build..."
echo

cmake --build . --parallel "$(sysctl -n hw.logicalcpu)"

echo
echo "=============================================="
echo " Darkelf QtWebEngine build completed"
echo "=============================================="
echo
echo "Build directory:"
echo "  $BUILD"
echo
echo "Configuration:"
echo "  QtWebEngine 6.11.2"
echo "  Proprietary codecs enabled"
echo "  WebRTC disabled"
echo "  Release build"
echo
echo "Do not overwrite the PySide6 QtWebEngine framework yet."
echo "Test and stage the resulting QtWebEngine frameworks first."
