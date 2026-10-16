#!/bin/zsh
set -euo pipefail

SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.12.0}"
BUILD="${2:-$HOME/Desktop/qtwebengine-darkelf-6.12.0-build}"
QT_PREFIX="${QT_PREFIX:-$(qtpaths6 --query QT_INSTALL_PREFIX 2>/dev/null || true)}"

fail() { print -u2 "ERROR: $1"; exit 1; }
[[ -d "$SRC/src/3rdparty/chromium" ]] || fail "Missing QtWebEngine source tree: $SRC"
[[ "${SRC:t}" == *6.12.0* ]] || fail "Source path must identify QtWebEngine 6.12.0: $SRC"
[[ -n "$QT_PREFIX" && -x "$QT_PREFIX/bin/qt-configure-module" ]] || fail "Set QT_PREFIX to a complete Qt 6.12.0 installation."
[[ -x "$QT_PREFIX/bin/qtpaths6" ]] && QT_VERSION="$("$QT_PREFIX/bin/qtpaths6" --query QT_VERSION 2>/dev/null || true)" || QT_VERSION=""
if [[ -n "$QT_VERSION" && "$QT_VERSION" != 6.12.0 ]]; then
  fail "Qt version mismatch: $QT_VERSION (expected 6.12.0)"
fi
[[ "$(uname -s)" == Darwin ]] || fail "macOS build host required"
[[ "$(uname -m)" == arm64 ]] || fail "Native Apple Silicon (arm64) build host required"
command -v cmake >/dev/null || fail "cmake is required"

mkdir -p "$BUILD"
cd "$BUILD"
print "Darkelf QtWebEngine 6.12.0 | Shadow 7.0.30 | macOS ARM64"
print "Source: $SRC"
print "Build:  $BUILD"
print "Qt:     $QT_PREFIX"
print "Features: proprietary codecs ON, WebRTC OFF, Release"

"$QT_PREFIX/bin/qt-configure-module" "$SRC" \
  -webengine-proprietary-codecs \
  -no-webengine-webrtc \
  -DCMAKE_BUILD_TYPE=Release

cmake --build . --parallel "$(sysctl -n hw.logicalcpu)"
print "Build completed. Validate features and stage frameworks before signing."
print "This script does not build, sign, or notarize a Darkelf Shadow DMG."

