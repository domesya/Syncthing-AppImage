#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q syncthing | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
#export ICON=https://github.com/syncthing/syncthing/blob/main/assets/logo-only.svg
#export DESKTOP=https://github.com/syncthing/syncthing/blob/main/etc/linux-desktop/syncthing-ui.desktop
export MAIN_BIN=syncthing-launch
export APPNAME=syncthing
export STARTUPWMCLASS=syncthing

# Deploy dependencies
quick-sharun \
  /usr/bin/zenity       \
  /usr/lib/libanl.so*   \
  /usr/bin/syncthing

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage
