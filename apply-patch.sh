#!/bin/zsh
set -euo pipefail

SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.12.0}"
HERE="$(cd "$(dirname "$0")" && pwd)"
PATCHES=(001-darkelf-macos-touchid.patch 002-darkelf-icloud-webauthn.patch 003-darkelf-native-webgl.patch)

[[ -d "$SRC/src/core" && -d "$SRC/src/3rdparty/chromium" ]] || {
  print -u2 "ERROR: QtWebEngine source tree not found: $SRC"; exit 1
}
[[ "${SRC:t}" == *6.12.0* ]] || {
  print -u2 "ERROR: Expected a QtWebEngine 6.12.0 source directory, got: $SRC"; exit 1
}
for name in "${PATCHES[@]}"; do
  [[ -f "$HERE/patches/$name" ]] || { print -u2 "ERROR: Missing patches/$name"; exit 1; }
done

cd "$SRC"
# Each patch is dry-run checked before application. A failure stops the series.
for name in "${PATCHES[@]}"; do
  file="$HERE/patches/$name"
  if patch -p1 --batch --forward -F 0 --dry-run < "$file" >/dev/null 2>&1; then
    print "Applying $name"
    patch -p1 --batch --forward -F 0 < "$file"
  elif patch -p1 --batch --reverse -F 0 --dry-run < "$file" >/dev/null 2>&1; then
    print "Already applied: $name"
  else
    print -u2 "ERROR: $name is not verified against this QtWebEngine 6.12.0 source tree."
    print -u2 "No forced patching. Check patch hunks against the actual 6.12.0 sources."
    exit 1
  fi
done
print "Patch series applied or already present. Build and runtime validation still required."


