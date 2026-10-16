# Darkelf QtWebEngine 6.12.0 — macOS WebAuthn Patch Kit

Custom **QtWebEngine 6.12.0 ARM64** integration for **Darkelf Shadow 7.0.30**, providing native macOS Touch ID, WebAuthn/passkey support, and enhanced Chromium engine capabilities.

## What's New in Darkelf Shadow 7.0.30

- **QtWebEngine 6.12.0** — Upgraded custom Chromium-based engine.
- **Qt / PySide6 6.12.0** — Updated native GUI framework.
- **Python 3.14.8** — Upgraded application runtime.
- **Nuitka 4.1.3** — Native macOS application compilation.
- **Apple Silicon ARM64** — Native macOS distribution.
- **Improved startup** — Fixed the black-screen delay between splash screen and homepage.
- **Touch ID / WebAuthn** — Preserved native macOS passkey integration.
- **Native WebGL** — Maintained custom WebGL integration.
- **Developer ID signing and notarization** — Maintained the macOS distribution workflow.

## Why

Darkelf's custom QtWebEngine integration addresses Chromium platform-authenticator configuration within Qt's `WebAuthenticationDelegateQt`.

Without the appropriate Touch ID authenticator configuration, Chromium's default `GetTouchIdAuthenticatorConfig()` implementation can return `std::nullopt`, causing:

`PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()`

to report `false`, even when the WebAuthn API exists.

The Darkelf patch provides the configuration required for macOS Touch ID and platform passkey integration.

## Design

- **Keychain access group:** `C7352X2Z2S.com.darkelfbrowser.shadow`
- A random 32-byte metadata secret is generated once per persistent Qt profile.
- The secret is stored as 64 hexadecimal characters in `.darkelf-webauthn-secret` within the profile data directory.
- File permissions are restricted to the owner.
- Off-the-record profiles return `nullopt` to avoid creating persistent Touch ID credentials.
- The application requires matching `keychain-access-groups` signing entitlements.

## Apply

Obtain the official **QtWebEngine 6.12.0** source tree:

`qtwebengine-everywhere-src-6.12.0`

For a patch series ported and validated against QtWebEngine 6.12.0, apply it using:

```bash
./apply-patch.sh "$HOME/Desktop/qtwebengine-everywhere-src-6.12.0"
```

The patch application script should perform a dry run before modifying source files.

**Compatibility:** The checked-in patches must target QtWebEngine 6.12.0. Patches created for 6.11.2 should not be assumed compatible without verification.

## Build

A matching **Qt 6.12.0** development installation is required.

```bash
export QT_PREFIX="/path/to/Qt/6.12.0/macos"
./build-darkelf-qtwebengine.sh
```

The custom build configuration includes:

- QtWebEngine proprietary codec support.
- Chromium `proprietary_codecs` configuration.
- H.264-related media capabilities.
- FFmpeg Chrome branding configuration.
- Native WebGL integration.

These features depend on the actual compiled configuration of the 6.12.0 framework. Proprietary codec support does not automatically provide DRM/Widevine functionality.

## Signing

Use `darkelf-webauthn.entitlements.plist` as the reference for Darkelf Shadow's macOS signing configuration.

The Keychain access group must match the value compiled into the C++ WebAuthn integration.

Sign nested QtWebEngine frameworks and helper applications before signing the main Darkelf Shadow application.

The macOS release workflow includes:

- Developer ID Application signing.
- Hardened runtime.
- WebAuthn/Touch ID entitlements.
- Apple notarization.
- Signed DMG distribution.

Do not modify the framework after signing.

## Verification

After building and signing Darkelf Shadow with the custom QtWebEngine 6.12.0 framework, test:

```javascript
PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()
  .then(console.log);
```

On a compatible Mac with correctly configured Touch ID, Secure Enclave, and signing entitlements, the expected result is:

```text
true
```

Also verify actual passkey registration and authentication. A `true` capability result alone does not confirm that the complete integration works.

## Darkelf Shadow Integration

The custom **QtWebEngine 6.12.0** framework is integrated into the native macOS ARM64 distribution of **Darkelf Shadow 7.0.30**.

### Technology Stack

| Component | Version |
|---|---|
| Darkelf Shadow | 7.0.30 |
| Python | 3.14.8 |
| Nuitka | 4.1.3 |
| Qt / PySide6 | 6.12.0 |
| Custom QtWebEngine | 6.12.0 |
| Architecture | macOS ARM64 |

The standard cross-platform PyPI distribution uses stock PySide6/QtWebEngine packages rather than this custom macOS framework.

## Licensing

Qt WebEngine, Chromium, FFmpeg, and their bundled components retain their respective upstream licenses.

Darkelf's modifications do not change the licenses of upstream projects.

H.264/AVC patent licensing and other patent considerations remain separate from applicable open-source licenses.

See the repository's `LICENSE.md`, `THIRD_PARTY_NOTICES.md`, `QT_SOURCE.md`, and `QT_RELINKING.md` for licensing and corresponding-source information.

## Status

**Current release: Darkelf Shadow 7.0.30**

- Python 3.14.8 runtime integration.
- Qt / PySide6 6.12.0 upgrade.
- Custom QtWebEngine 6.12.0 ARM64 integration.
- Nuitka 4.1.3 compilation.
- Improved splash-to-homepage startup transition.
- Native macOS security and privacy architecture maintained.

**Darkelf Shadow 7.0.30 — Modernized QtWebEngine. Native macOS integration. Privacy-focused browsing.**
