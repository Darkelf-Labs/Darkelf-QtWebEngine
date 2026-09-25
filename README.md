# Darkelf QtWebEngine 6.11.2 macOS WebAuthn Patch Kit

This kit patches QtWebEngine 6.11.2's `WebAuthenticationDelegateQt` to provide Chromium's macOS Touch ID authenticator configuration for Darkelf Shadow.

## Why

Qt's delegate currently overrides `SupportsResidentKeys()` but not `GetTouchIdAuthenticatorConfig()`. Chromium's default implementation returns `std::nullopt`, so `isUserVerifyingPlatformAuthenticatorAvailable()` reports false even though the WebAuthn API itself exists.

## Design

- Keychain access group: `C7352X2Z2S.com.darkelfbrowser.shadow`
- A random 32-byte metadata secret is generated once per persistent Qt profile and stored as 64 hex characters in `.darkelf-webauthn-secret` inside the profile data directory.
- File permissions are restricted to the owner.
- Off-the-record profiles deliberately return `nullopt` so they do not create persistent Touch ID credentials.
- The application must be signed with the matching `keychain-access-groups` entitlement.

## Apply

Extract the official `qtwebengine-everywhere-src-6.11.2` source tree, then run:

    ./apply-patch.sh ~/Desktop/qtwebengine-everywhere-src-6.11.2

The script performs `patch --dry-run` before changing the source.

## Build

A matching complete Qt 6.11.2 development installation is required. Set `QT_PREFIX` if `qtpaths6` does not resolve the correct installation:

    export QT_PREFIX=/path/to/Qt/6.11.2/macos
    ./build-darkelf-qtwebengine.sh

The build enables Qt's existing `webengine-proprietary-codecs` option. Qt's CMake configuration passes Chromium `proprietary_codecs`, `rtc_use_h264`, and `ffmpeg_branding="Chrome"`.

This is a build configuration change, not an FFmpeg source patch.

## Signing

Use `darkelf-webauthn.entitlements.plist` as the basis for the main Darkelf Shadow application entitlements.

The keychain access group must remain identical to the value defined in the C++ patch.

Sign nested QtWebEngine frameworks and helper applications before signing the outer Darkelf Shadow application. Do not modify an already signed QtWebEngine framework.

## Verification

After building Darkelf Shadow with the custom QtWebEngine framework and signing it correctly, test:

    PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()

On a compatible Mac with Touch ID/Secure Enclave and correct signing, the expected result is:

    true

A real WebAuthn registration and authentication should also be performed. Darkelf Shadow has been tested with passkey registration and authentication using the custom QtWebEngine build.

A `true` capability result by itself should not be treated as sufficient verification of the complete integration.

## Darkelf Shadow Integration

This QtWebEngine build is used by the native macOS ARM64 distribution of **Darkelf Shadow 7.0.9**.

The custom engine provides:

- macOS Touch ID / platform WebAuthn integration
- Passkey registration and authentication support
- QtWebEngine 6.11.2 integration
- Proprietary codec build configuration for expanded media compatibility
- H.264-related Chromium media capability

The standard cross-platform PyPI distribution of Darkelf Shadow uses the standard PySide6/QtWebEngine packages rather than this custom macOS framework.

## Licensing

Qt WebEngine, Chromium, FFmpeg, and their bundled components remain subject to their respective upstream licenses.

Darkelf's modifications do not change the licenses of those upstream projects.

H.264/AVC patent licensing and other patent considerations are separate from the open-source licenses governing Darkelf Shadow, Qt, Chromium, and FFmpeg.

## Status

This patch is part of the **Darkelf Shadow 7.0.9 macOS ARM64 engine configuration**.

The custom QtWebEngine framework has been integrated into the Darkelf Shadow native macOS application and used with its signed and notarized distribution.
