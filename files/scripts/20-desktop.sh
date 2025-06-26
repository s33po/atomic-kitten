#!/usr/bin/env bash

set -xeuo pipefail

# TESTING: GNOME 48 backport from COPR
#dnf -y copr enable @centoshyperscale/c10s-gnome-48
#dnf -y install glib2

# Ensure 'kvm' group exists before installing QEMU
getent group kvm >/dev/null || groupadd -r kvm

dnf install -y \
    @"Workstation" \
    @"Virtualization Host" \
    @"Network File System Client" \

systemctl enable gdm
systemctl set-default graphical.target

dnf -y remove \
    setroubleshoot