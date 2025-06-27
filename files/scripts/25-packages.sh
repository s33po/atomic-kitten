#!/usr/bin/env bash

set -xeuo pipefail

# Remove fluff
dnf autoremove -y \
    PackageKit \
    firefox \
    loupe \
    papers

# Install stuff
dnf -y install \
   distrobox \
   buildah \
   fastfetch \
   fpaste \
   nvtop \
   btop \
   neovim \
   just \
   zsh \
   fzf \
   tmux \
   glow \
   wl-clipboard \
   gum \
   jetbrains-mono-fonts-all \
   google-noto-sans-fonts \
   google-noto-color-emoji-fonts \
   powerline-fonts \
   systemd-{resolved,container,oomd} \
   libcamera{,-{v4l2,gstreamer,tools}}

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
update-crypto-policies --set LEGACY
rpm --import https://packages.microsoft.com/keys/microsoft.asc
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode install code
update-crypto-policies --set DEFAULT


# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

