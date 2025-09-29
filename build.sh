#!/usr/bin/env bash

set -xeuo pipefail

dnf -y remove subscription-manager

dnf config-manager --set-enabled crb
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

# Backported GNOME 48 from HyperScale SIG
dnf -y copr enable @centoshyperscale/c10s-gnome-48
dnf -y install glib2

# install "Workstation" without firefox
dnf -y group install --nobest "Workstation" \
    --exclude=firefox

# Install multimedia codecs
dnf -y --skip-broken install \
    ffmpeg-free \
    ffmpeg-thumbnailer \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-libs \
    gstreamer1-plugins-good \
    gstreamer1-plugins-base \
    lame \
    lame-libs \
    libjxl \
    libheif \
    libwebp \
    gdk-pixbuf2-modules-extra \
    webp-pixbuf-loader \
    avif-pixbuf-loader 

# Install other stuff
dnf -y install \
	systemd-container \
	system-reinstall-bootc \
	btop \
	nvtop \
	distrobox \
	fuse \
	fastfetch \
	just \
	plymouth \
	plymouth-system-theme \
	steam-devices \
	powertop \
	buildah \
	neovim \
	zsh \
	fzf \
	tmux \
	fpaste \
	uv \
	ramalama	

# Remove fluff
dnf -y remove console-login-helper-messages setroubleshoot redhat-flatpak-repo

# Enable services
systemctl enable gdm.service
systemctl enable bootc-fetch-apply-updates.timer
systemctl enable firewalld
systemctl enable podman.socket

# Install fonts
dnf -y install \
   jetbrains-mono-fonts

# Add Flathub
mkdir -p /etc/flatpak/remotes.d
curl --retry 3 -o /etc/flatpak/remotes.d/flathub.flatpakrepo "https://dl.flathub.org/repo/flathub.flatpakrepo"

# Disable lastlog display 
authselect enable-feature with-silent-lastlog

# Enable quiet boot with spinner
mkdir -p /usr/lib/bootc/kargs.d
cat > /usr/lib/bootc/kargs.d/quiet.conf <<EOF
quiet
splash
EOF

# Set image pretty name
VERSION_ID="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
IMAGE_PRETTY_NAME="Atomic Kitten"

# Add image name as VARIANT_ID.
sed -i -f - /usr/lib/os-release <<EOF
s/^NAME=.*/NAME="${IMAGE_PRETTY_NAME}"/
s/^PRETTY_NAME=.*/PRETTY_NAME="${IMAGE_PRETTY_NAME} ${VERSION_ID}"/
s/^VARIANT_ID=.*/VARIANT_ID="${IMAGE_NAME}"/
EOF

# Clean up
dnf clean all
rm -rf /.gitkeep
find /var -mindepth 1 -delete
find /boot -mindepth 1 -delete
mkdir -p /var /boot

# Make /usr/local writeable
ln -s /var/usrlocal /usr/local