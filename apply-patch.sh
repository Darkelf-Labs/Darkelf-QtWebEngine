#!/bin/zsh
set -euo pipefail

SRC="${1:-$HOME/Desktop/qtwebengine-everywhere-src-6.11.2}"
HERE="$(cd "$(dirname "$0")" && pwd)"

[[ -f "$SRC/src/core/authenticator_request_client_delegate_qt.cpp" ]] || {
    echo "QtWebEngine source not found at: $SRC" >&2
    exit 1
}

PATCHES=(
    "001-darkelf-macos-touchid.patch"
    "002-darkelf-icloud-webauthn.patch"
    "003-darkelf-native-webgl.patch"
)

# Check every input before modifying the source tree.
for patch_name in "${PATCHES[@]}"; do
    [[ -f "$HERE/patches/$patch_name" ]] || {
        echo "Missing patch: $HERE/patches/$patch_name" >&2
        exit 1
    }
done

cd "$SRC"
for patch_name in "${PATCHES[@]}"; do
    patch_file="$HERE/patches/$patch_name"

    if patch -p1 --batch --forward -F 0 --dry-run < "$patch_file" >/dev/null 2>&1; then
        echo "Applying: $patch_name"
        patch -p1 --batch --forward -F 0 < "$patch_file"
    elif patch -p1 --batch --reverse -F 0 --dry-run < "$patch_file" >/dev/null 2>&1; then
        echo "Already applied: $patch_name"
    else
        echo "Cannot safely apply or recognize: $patch_name" >&2
        echo "The source may differ or the patch may be partially applied." >&2
        echo "Earlier patches may already be applied; resolve this conflict before continuing." >&2
        patch -p1 --batch --forward -F 0 --dry-run < "$patch_file" >&2 || true
        exit 1
    fi
done

echo "All three Darkelf native patches are applied."

