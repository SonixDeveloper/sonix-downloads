#!/bin/sh
set -eu

version=${1:-0.1.4}
output=${2:-.}
root=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
package="${TMPDIR:-/tmp}/sonix-deb-package-$$"
trap 'rm -rf "$package"' EXIT HUP INT TERM

install -Dm755 "$root/source/linux/sonix" "$package/usr/bin/sonix"
install -Dm644 "$root/source/linux/io.github.SonixDeveloper.Sonix.desktop" \
    "$package/usr/share/applications/io.github.SonixDeveloper.Sonix.desktop"
install -Dm644 "$root/assets/sonix.svg" \
    "$package/usr/share/icons/hicolor/scalable/apps/io.github.SonixDeveloper.Sonix.svg"
install -Dm644 "$root/source/linux/debian/control" "$package/DEBIAN/control"
sed -i "s/^Version: .*/Version: $version/" "$package/DEBIAN/control"
mkdir -p "$output"
dpkg-deb --root-owner-group --build "$package" "$output/sonix-chat_${version}_amd64.deb"
