# Corresponding Qt / QtWebEngine Source — Darkelf Shadow 7.0.30

Darkelf Shadow 7.0.30 uses Qt / PySide6 **6.12.0** and a custom macOS ARM64 QtWebEngine **6.12.0** build.

## Obtain source

Obtain the matching official Qt 6.12.0 sources, including `qtwebengine-everywhere-src-6.12.0`, from the [Qt archives](https://download.qt.io/archive/qt/6.12/6.12.0/) if available. Match the Qt modules, PySide6 bindings, architecture, and compiler environment used for the release. Chromium/FFmpeg source must correspond to the QtWebEngine build rather than arbitrary current revisions.

## Darkelf modifications

The repository documents this patch series:

1. `patches/001-darkelf-macos-touchid.patch`
2. `patches/002-darkelf-icloud-webauthn.patch`
3. `patches/003-darkelf-native-webgl.patch`

**Do not assume 6.11.2 patches work on 6.12.0.** Port and verify each patch against a clean QtWebEngine 6.12.0 source tree. When compatible, apply using:

```sh
./apply-patch.sh "$HOME/Desktop/qtwebengine-everywhere-src-6.12.0"
```

Stop on patch failures. See [BUILDING.md](BUILDING.md) for build instructions.

## Release provenance checklist

For each shipped binary, record the exact upstream source archive URLs and SHA-256 hashes or Git revisions, Darkelf patch repository commit, all local changes, build flags, compiler/SDK/toolchain versions, macOS deployment target, Chromium/FFmpeg source versions, and license notices. Make corresponding LGPL-covered modifications and necessary build scripts available.

**Not yet verified:** The exact upstream source checksums and Darkelf patch commit used for the Shadow 7.0.30 binary. Fill these from the actual build records before describing this as an exact corresponding-source manifest.

See [QT_RELINKING.md](QT_RELINKING.md), [LICENSE.md](LICENSE.md), and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
