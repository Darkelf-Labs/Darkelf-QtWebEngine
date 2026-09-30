#!/bin/zsh
set -euo pipefail

APP="${1:-/Applications/Darkelf Shadow.app}"

echo "=============================================="
echo " Darkelf Shadow 7.0.11"
echo " WebAuthn / Signing Verification"
echo "=============================================="
echo
echo "Application:"
echo "  $APP"
echo

if [[ ! -d "$APP" ]]; then
    echo "Application not found:"
    echo "  $APP"
    return 1 2>/dev/null || false
fi

echo "== Main app entitlements =="
codesign -d --entitlements :- "$APP" 2>/dev/null || true

echo
echo "== WebAuthn / Keychain entitlements =="
codesign -d --entitlements :- "$APP" 2>/dev/null | \
    grep -A6 -E \
    'keychain-access-groups|application-identifier|com\.apple\.developer\.web-browser\.public-key-credential' \
    || true

echo
echo "== Expected Darkelf keychain access group =="
echo "C7352X2Z2S.com.darkelfbrowser.shadow"

echo
echo "== iCloud / Passkey WebAuthn entitlement =="
if codesign -d --entitlements :- "$APP" 2>/dev/null | \
    grep -q 'com.apple.developer.web-browser.public-key-credential'; then
    echo "FOUND: com.apple.developer.web-browser.public-key-credential"
else
    echo "NOT FOUND: com.apple.developer.web-browser.public-key-credential"
fi

echo
echo "== Bluetooth declaration =="
/usr/libexec/PlistBuddy \
    -c 'Print :NSBluetoothAlwaysUsageDescription' \
    "$APP/Contents/Info.plist" \
    2>/dev/null || true

echo
echo "== Signature verification =="
codesign --verify --deep --strict --verbose=2 "$APP"

echo
echo "== Gatekeeper assessment =="
spctl --assess --type execute --verbose=2 "$APP" || true

echo
echo "=============================================="
echo " Native verification complete"
echo "=============================================="
echo
echo "Then test in Darkelf Shadow DevTools/console:"
echo
echo "PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()"
echo
echo "Expected platform-authenticator result on a compatible,"
echo "correctly signed Mac:"
echo "  true"
echo
echo "Also perform a real passkey registration and authentication."
