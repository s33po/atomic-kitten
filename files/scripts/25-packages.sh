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
   steam-devices \
   python3-ramalama \
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

# Comment these out if testing GNOME 48!
dnf -y install \
  -x gnome-extensions-app \
   gnome-shell-extension-{blur-my-shell,caffeine,appindicator} \


# ----------External repos----------

# Set up repo for Visual Studio Code. Fix the code when Microsoft provides a key that doesn't use SHA1.
# rpm --import https://packages.microsoft.com/keys/microsoft.asc
cat << 'EOF' >> /etc/yum.repos.d/vscode.repo
# Visual Studio Code repository
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=0
# gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf -y install code

# Install Nerd fonts from COPR
dnf -y copr enable che/nerd-fonts centos-stream-10-x86_64
dnf -y copr disable che/nerd-fonts
dnf -y --enablerepo="copr:copr.fedorainfracloud.org:che:nerd-fonts" install \
    nerd-fonts

# Clean up external repos
rm -f /etc/yum.repos.d/_copr*_nerd-fonts.repo
rm -f /etc/yum.repos.d/vscode.repo


# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog

