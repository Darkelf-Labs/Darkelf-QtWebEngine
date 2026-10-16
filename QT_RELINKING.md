# Replacing LGPL Qt Libraries in Darkelf Shadow 7.0.30 (macOS)

Darkelf Shadow 7.0.30 uses dynamically linked **Qt / PySide6 6.12.0** and custom **QtWebEngine 6.12.0** on macOS ARM64. This describes a possible developer-controlled replacement workflow, not a completed compatibility test.

## Source and build

Obtain the corresponding Qt 6.12.0 source and verified Darkelf patches described in [QT_SOURCE.md](QT_SOURCE.md). Build replacement QtWebEngine 6.12.0 libraries using matching Qt, ABI, architecture, deployment target, and build settings. Do not mix QtWebEngine 6.11.x and Qt 6.12.0 components.

## Replacement procedure

1. Keep the original signed DMG intact and create a separate working copy of `Darkelf Shadow.app`.
2. Identify the actual embedded Qt frameworks, helpers, and resources; Nuitka bundle paths may differ.
3. Replace the matching Qt libraries in the working copy, preserving versioned framework layout, symlinks, install names, helper binaries, resources, and dependency compatibility.
4. Inspect `otool -L` dependencies and runtime paths. Repair broken links only in the working copy.
5. Re-sign modified nested frameworks and helper applications before signing the outer app using an appropriate local signing identity and entitlements. The original Developer ID signature and notarization will no longer be valid.
6. Verify the modified app launches and test page loading, WebGL, H.264 playback, and WebAuthn registration and authentication.

## Read-only checks

```sh
APP="/path/to/working-copy/Darkelf Shadow.app"
find "$APP/Contents" \( -name 'QtWebEngineCore.framework' -o -name 'QtWebEngineProcess.app' \) -print
# Replace this example with the actual path found above:
FW="$APP/Contents/Frameworks/PySide6/Qt/lib/QtWebEngineCore.framework"
file "$FW/Versions/A/QtWebEngineCore"
otool -L "$FW/Versions/A/QtWebEngineCore"
codesign --verify --strict --verbose=2 "$FW"
codesign --verify --strict --verbose=2 "$APP"
```

## Touch ID caveat

The custom WebAuthn integration uses the Keychain access group `C7352X2Z2S.com.darkelfbrowser.shadow`. Independently re-signed copies may lack authorization to use this group. Use an authorized group and corresponding entitlements where necessary. A failed Touch ID test alone does not prove library replacement failed.

## Licensing and limitations

Qt, Chromium, FFmpeg, and other bundled components may have different license conditions. Follow their applicable license texts and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). A source URL alone does not establish exact corresponding source for the shipped binary.

**Not yet verified:** End-to-end library replacement and launch against the released Darkelf Shadow 7.0.30 app.
