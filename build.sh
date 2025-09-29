#!/usr/bin/env bash

set -xeuo pipefail

# Enable centos-bootc compose repos
curl --retry 3 -Lo /etc/yum.repos.d/compose.repo https://gitlab.com/redhat/centos-stream/containers/bootc/-/raw/c10s/cs.repo
sed -r \
    -e 's@\[rhel-10-for-\$basearch-@[@' \
    -e 's@-rpms\]@-compose]@' \
    -e 's@- (BaseOS|AppStream)@& - Compose@' \
    -e 's@/usr/share/distribution-gpg-keys/centos/RPM-GPG-KEY-CentOS-Official@/etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial-SHA256@' \
    -i /etc/yum.repos.d/compose.repo

dnf -y remove subscription-manager

dnf config-manager --set-enabled crb
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-10.noarch.rpm

dnf -y install @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl plymouth plymouth-system-theme

# Install "Workstation"
dnf -y group install "Workstation"

# Install stuff
dnf -y install \
	systemd-container \
    system-reinstall-bootc \
	btop \
	nvtop \
	distrobox \
	fuse \
	fastfetch \
	just

# Remove fluff
dnf -y remove console-login-helper-messages setroubleshoot redhat-flatpak-repo

systemctl enable gdm.service

# Add Flathub
mkdir -p /etc/flatpak/remotes.d
curl --retry 3 -o /etc/flatpak/remotes.d/flathub.flatpakrepo "https://dl.flathub.org/repo/flathub.flatpakrepo"

# Disable lastlog display 
authselect enable-feature with-silent-lastlog

# Disable compose repos
dnf config-manager --set-disabled baseos-compose,appstream-compose

# Clean up
dnf clean all

rm -rf /.gitkeep
find /var -mindepth 1 -delete
find /boot -mindepth 1 -delete
mkdir -p /var /boot

# Make /usr/local writeable
ln -s /var/usrlocal /usr/local