# Building Darkelf QtWebEngine 6.12.0 (macOS ARM64)

Target: **Darkelf Shadow 7.0.30**, Qt/PySide6 **6.12.0**, Python **3.14.8**, Nuitka **4.1.3**.

## Requirements

- Apple Silicon Mac, Xcode command-line tools, CMake/Ninja and QtWebEngine's upstream build dependencies.
- Official `qtwebengine-everywhere-src-6.12.0` source and a complete matching Qt 6.12.0 development installation.
- A patch series **validated against the exact QtWebEngine 6.12.0 source**. The presence of patch files alone does not establish compatibility.

## Apply patches and build

```sh
export QT_PREFIX="/path/to/Qt/6.12.0/macos"
./apply-patch.sh "$HOME/Desktop/qtwebengine-everywhere-src-6.12.0"
./build-darkelf-qtwebengine.sh "$HOME/Desktop/qtwebengine-everywhere-src-6.12.0"
```

The build script requests a Release build, proprietary codecs, and disabled WebRTC. Verify actual compiled feature flags and media behavior. H.264 enablement does not imply DRM support or patent licensing.

## Package and verify

This repository builds QtWebEngine, **not** the final Nuitka app or DMG. Stage the matching ARM64 Qt frameworks in the Darkelf Shadow release workflow, sign nested binaries and helpers before the outer app, then notarize and staple the distributable.

```sh
./verify-darkelf-webauthn.sh "/Applications/Darkelf Shadow.app"
```

Perform real passkey registration and authentication. Preserve the exact source revision, patch set, configuration, dependency versions, and build artifacts for corresponding-source compliance; see `QT_SOURCE.md` and `QT_RELINKING.md`.
