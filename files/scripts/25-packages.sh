#!/usr/bin/env bash

set -xeuo pipefail

# Remove fluff
dnf remove -y \
    firefox \
    PackageKit \
    console-login-helper-messages \
    redhat-flatpak-repo

# Install stuff
dnf -y install \
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
   fpaste \
   ramalama

# Virtualization
dnf -y install \
  libvirt \
  libvirt-daemon-kvm \
  libvirt-nss \
  virt-install \
  virt-manager

# Fonts
dnf -y install \
    jetbrains-mono-fonts \
    google-noto-sans-fonts \
    powerline-fonts

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode --nogpgcheck  install code

# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

# Enable services
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable firewalld
systemctl enable podman.socket
systemctl enable libvirtd.service
