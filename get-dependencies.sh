#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
  syncthing

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

make-aur-package zenity-rs-bin

mkdir -p /usr/share/applications
wget -O /usr/share/applications/syncthing-start.desktop "https://github.com/syncthing/syncthing/blob/main/etc/linux-desktop/syncthing-start.desktop"
