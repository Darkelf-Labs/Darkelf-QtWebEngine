#!/bin/zsh
set -euo pipefail
APP="${1:-/Applications/Darkelf Shadow.app}"
echo "== Main app entitlements =="
codesign -d --entitlements :- "$APP" 2>/dev/null | grep -A4 -E 'keychain-access-groups|application-identifier' || true
echo "== Bluetooth declaration =="
/usr/libexec/PlistBuddy -c 'Print :NSBluetoothAlwaysUsageDescription' "$APP/Contents/Info.plist" 2>/dev/null || true
echo "== Signature =="
codesign --verify --deep --strict --verbose=2 "$APP"
echo "Then test in DevTools/console: PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()"
