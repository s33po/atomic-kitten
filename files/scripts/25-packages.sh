#!/usr/bin/env bash

set -xeuo pipefail

# Install stuff
dnf -y install \
   powertop \
   fuse \
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
   fpaste \
   uv \
   ramalama \
   cockpit-podman

# Fonts
dnf -y install \
   jetbrains-mono-fonts \
   google-noto-sans-fonts \
   powerline-fonts

# Virtualization
dnf group install -y \
   "Virtualization Host"

dnf -y install \
   libvirt-daemon-kvm \
   libvirt-nss \
   virt-install \
   virt-manager \
   cockpit-machines
  
### External repos ###

# VSCode
dnf config-manager --add-repo "https://packages.microsoft.com/yumrepos/vscode"
dnf config-manager --set-disabled packages.microsoft.com_yumrepos_vscode
dnf -y --enablerepo packages.microsoft.com_yumrepos_vscode --nogpgcheck  install code
