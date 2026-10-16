#!/bin/zsh
set -euo pipefail
APP="${1:-/Applications/Darkelf Shadow.app}"
GROUP="C7352X2Z2S.com.darkelfbrowser.shadow"
ENTITLEMENT="com.apple.developer.web-browser.public-key-credential"

[[ -d "$APP" ]] || { print -u2 "ERROR: App not found: $APP"; exit 1; }
print "Darkelf Shadow 7.0.30 | QtWebEngine 6.12.0 | WebAuthn verification"
print "App: $APP"

codesign --verify --deep --strict --verbose=2 "$APP"
ENT="$(mktemp "${TMPDIR:-/tmp/}darkelf-entitlements.XXXXXXXX.plist")"
trap 'rm -f "$ENT"' EXIT
codesign -d --entitlements "$ENT" "$APP" 2>/dev/null || {
  print -u2 "ERROR: Could not extract app entitlements"; exit 1
}
/usr/libexec/PlistBuddy -c 'Print :keychain-access-groups' "$ENT" | grep -Fq "$GROUP" || {
  print -u2 "ERROR: Missing keychain access group $GROUP"; exit 1
}
/usr/libexec/PlistBuddy -c "Print :$ENTITLEMENT" "$ENT" | grep -qx true || {
  print -u2 "ERROR: Missing or disabled $ENTITLEMENT"; exit 1
}
print "PASS: App signature, keychain access group, and public-key credential entitlement"
if spctl --assess --type execute --verbose=2 "$APP"; then
  print "PASS: Gatekeeper assessment"
else
  print -u2 "WARNING: Gatekeeper assessment did not pass (check notarization/distribution)"
fi
print "Next: Test PublicKeyCredential.isUserVerifyingPlatformAuthenticatorAvailable()"
print "Then complete real passkey registration and authentication on a Touch ID Mac."
