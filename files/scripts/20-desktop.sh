#!/usr/bin/env bash

set -xeuo pipefail

# Workstation without GNOME
dnf group install -y --nobest \
  -x rsyslog* \
  -x cockpit \
  -x cronie* \
  -x crontabs \
  -x PackageKit \
  -x PackageKit-command-not-found \
   "Common NetworkManager submodules" \
   "Core" \
   "Fonts" \
   "Guest Desktop Agents" \
   "Hardware Support" \
   "Printing Client" \
   "Standard" \
   "Workstation product core"

# Minimal GNOME group with some very basic tools and utilies
dnf -y install \
  -x PackageKit \
  -x PackageKit-command-not-found \
  -x gnome-software-fedora-langpacks \
   "NetworkManager-adsl" \
   "gdm" \
   "gnome-bluetooth" \
   "gnome-color-manager" \
   "gnome-control-center" \
   "gnome-initial-setup" \
   "gnome-remote-desktop" \
   "gnome-session-wayland-session" \
   "gnome-settings-daemon" \
   "gnome-shell" \
   "gnome-software" \
   "gnome-system-monitor" \
   "gnome-tweaks" \
   "gnome-user-docs" \
   "gvfs-fuse" \
   "gvfs-goa" \
   "gvfs-gphoto2" \
   "gvfs-mtp" \
   "gvfs-smb" \
   "libsane-hpaio" \
   "nautilus" \
   "orca" \
   "sane-backends-drivers-scanners" \
   "xdg-desktop-portal-gnome" \
   "xdg-user-dirs-gtk" \
   "ptyxis" \
   "gedit" \
   "yelp-tools"

# Remove fluff
dnf -y remove \
    setroubleshoot

# Extras
dnf -y install \
  -x gnome-extensions-app \
   gnome-disk-utility \
   gnome-shell-extension-{blur-my-shell,caffeine,appindicator} \
   steam-devices \
   distrobox \
   buildah \
   tuned-ppd \
   nss-mdns \
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
   fira-code-fonts \
   powerline-fonts \
   systemd-{resolved,container,oomd} \
   libcamera{,-{v4l2,gstreamer,tools}}


# Virtualization

# Ensure 'kvm' group exists before installing QEMU
getent group kvm >/dev/null || groupadd -r kvm

dnf -y install \
  qemu-kvm \
  libvirt \
  virt-install \
  virt-manager \
  virt-viewer

# ----------External repos----------

# Install VSCodium: Import GPG key, add repository and install codium
rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg

cat << 'EOF' > /etc/yum.repos.d/vscodium.repo
[gitlab.com_paulcarroty_vscodium_repo]
name=VSCodium packages
baseurl=https://download.vscodium.com/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
metadata_expire=1h
EOF

dnf -y install codium

# Install Nerd fonts from COPR
dnf -y copr enable che/nerd-fonts centos-stream-10-x86_64
dnf -y copr disable che/nerd-fonts
dnf -y --enablerepo="copr:copr.fedorainfracloud.org:che:nerd-fonts" install \
    nerd-fonts

# Clean up external repos
rm -f /etc/yum.repos.d/_copr*_nerd-fonts.repo
rm -f /etc/yum.repos.d/vscodium.repo


# ----------Services----------

# Enable gdm
systemctl enable gdm
systemctl set-default graphical.target

# Enable countme service
systemctl enable rpm-ostree-countme.service

# Enable polkit rules for fingerprint sensors via fprintd
authselect enable-feature with-fingerprint

# Disable lastlog display on previous failed login in GDM (This makes logins slow)
authselect enable-feature with-silent-lastlog