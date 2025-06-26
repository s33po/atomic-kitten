#!/usr/bin/env bash

set -xeuo pipefail

# Remove firefox
dnf autoremove -y \
    firefox \

# Install stuff
dnf -y install \
   steam-devices \
   distrobox \
   buildah \
   fastfetch \
   nvtop \
   btop \
   just \
   neovim \
   zsh \
   fzf \
   tmux \
   wl-clipboard \
   jetbrains-mono-fonts-all \
   google-noto-sans-fonts \
   google-noto-color-emoji-fonts \
   powerline-fonts \
   systemd-{resolved,container,oomd}

# GNOME extensions
dnf -y install \
  -x gnome-extensions-app \
   gnome-shell-extension-{blur-my-shell,caffeine,appindicator} \

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
update-crypto-policies --set LEGACY
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode install code
update-crypto-policies --set DEFAULT

# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

