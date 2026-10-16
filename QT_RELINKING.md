# Replacing LGPL Qt Libraries in Darkelf Shadow (macOS)

Darkelf Shadow's native macOS application uses dynamically linked Qt frameworks. This document explains a possible **developer-controlled replacement workflow** for LGPL-covered Qt libraries. It does not claim that a replacement build has been successfully tested, or that every component of the application is covered by LGPL.

## Obtain corresponding source

Follow [QT_SOURCE.md](QT_SOURCE.md) to obtain the QtWebEngine 6.11.2 source, the exact Darkelf patches, and other corresponding source/build materials for the specific binary release. See [BUILDING.md](BUILDING.md) for the repository's configure/build steps.

## Replacement workflow (on a copy)

1. **Do not modify the installed, signed release.** Make a separate working copy of the application and retain the original DMG.
2. Build compatible replacement Qt libraries from the corresponding source. Preserve architecture, ABI, framework identifiers, install names and the Qt/PySide6 version compatibility expected by the app.
3. Replace only the relevant libraries in the **working copy**. Check associated frameworks, helpers, resources and load paths; QtWebEngine may depend on matching components.
4. Because replacing framework contents invalidates the existing app's code signature, sign the modified nested components and then the outer app with a **local development or ad-hoc signature**, as appropriate for local testing. The original Developer ID signature and Apple's notarization cannot be preserved after modification.
5. Verify the modified copy and test launch, page loading, WebGL, media and any WebAuthn functionality that remains available with the chosen signing identity and entitlements.

A locally modified app may not be eligible for the original vendor's Keychain access group or associated Apple entitlements. Passkey/Touch ID features may therefore behave differently after local re-signing; this is not evidence that the LGPL library replacement itself failed.

## Useful inspection commands

```sh
APP="/path/to/working-copy/Darkelf Shadow.app"
FW="$APP/Contents/Frameworks/PySide6/Qt/lib/QtWebEngineCore.framework"

file "$FW/Versions/A/QtWebEngineCore"
otool -L "$FW/Versions/A/QtWebEngineCore"
codesign --verify --strict --verbose=2 "$FW"
codesign --verify --strict --verbose=2 "$APP"
```

These commands are read-only. They do not replace or re-sign any binary.

## macOS signing and LGPL considerations

The official Darkelf release may be Developer ID signed and notarized. Those mechanisms establish the identity/integrity of the **original release**, not a guarantee that a user-modified copy will retain the original signature or Apple-granted entitlements. Local replacement and re-signing must not be prohibited by the distribution's terms or technical controls where the applicable LGPL requires the ability to modify/relink the covered library.

**Not yet verified:** a complete, documented replacement-and-launch test against the distributed Darkelf Shadow v7.0.29 app. Until that test is performed, this document is guidance rather than proof of practical replaceability.

## Limitations

- QtWebEngine, Qt modules, Chromium, FFmpeg and other bundled code can carry **different licenses and conditions**.
- An upstream source URL by itself may not provide the exact corresponding modified source for a shipped build.
- A locally modified copy may require additional macOS security approvals or a suitable signing identity.
- Consult the actual LGPL/GPL texts and the distribution's third-party notices for the governing requirements.

For issues with the documented source or replacement procedure, open an issue at <https://github.com/Darkelf-Labs/Darkelf-QtWebEngine/issues>.
