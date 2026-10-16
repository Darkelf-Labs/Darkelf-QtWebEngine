# Corresponding Qt / QtWebEngine Source — Darkelf Shadow

This document identifies the source and modifications for the **custom macOS QtWebEngine 6.11.2** integration used in Darkelf Shadow. It is intended to help recipients obtain and rebuild the LGPL-covered components. It does not replace the licenses and notices supplied with Qt and its dependencies.

## Source components

- **Qt / QtWebEngine:** obtain the official **Qt 6.11.2** source distribution, including `qtwebengine-everywhere-src-6.11.2`, from the [Qt source archives](https://download.qt.io/archive/qt/6.11/6.11.2/), subject to availability. Ensure the other Qt modules match the installed Qt 6.11.2 development environment.
- **Darkelf modifications:** this repository, <https://github.com/Darkelf-Labs/Darkelf-QtWebEngine>, contains the patch series and build scripts.
- **Chromium / FFmpeg and other bundled dependencies:** consult the source trees, license manifests and third-party notices corresponding to the exact QtWebEngine build. QtWebEngine's source/build system manages Chromium dependencies; do not substitute arbitrary current Chromium or FFmpeg revisions.

## Darkelf patch series (apply in order)

1. `patches/001-darkelf-macos-touchid.patch`
2. `patches/002-darkelf-icloud-webauthn.patch`
3. `patches/003-darkelf-native-webgl.patch`

Apply with:

```sh
./apply-patch.sh "$HOME/Desktop/qtwebengine-everywhere-src-6.11.2"
```

The script first checks each patch with a dry run, applies it if possible, and recognizes an already-applied patch. It stops on conflicts. See [BUILDING.md](BUILDING.md).

## Exact corresponding-source record for each binary release

A version label and patch list alone are not sufficient to prove that source exactly corresponds to every shipped binary. Before publishing a release, record:

- The **exact upstream Qt source archive URL and SHA-256**, or Git commit identifiers for every relevant Qt module.
- The **exact Git commit/tag of this patch repository** used to build the binary.
- Any additional local changes not represented in the published patches; publish those changes too.
- The relevant Chromium/FFmpeg source and license information for the actual QtWebEngine build.
- The macOS/SDK, compiler, CMake, Ninja and Qt toolchain versions, and any build-time configuration beyond the checked-in script.
- A source archive or reliable access instructions for all corresponding LGPL-covered modifications and required build scripts.

**Release-specific values not independently established:** the precise upstream source checksums/commits and the exact Darkelf-QtWebEngine commit used to produce Shadow **v7.0.29**. Fill these in from the release build records before presenting this as a complete corresponding-source manifest.

## Licensing

Darkelf-specific code and scripts are described in [LICENSE.md](LICENSE.md) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). Qt and bundled dependencies retain their own licenses. See [QT_RELINKING.md](QT_RELINKING.md) for the practical implications of replacing LGPL libraries in the macOS application.
