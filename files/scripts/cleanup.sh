#!/usr/bin/env bash

set -xeuo pipefail

# Image cleanup
# Specifically called by build.sh

# Image-layer cleanup
shopt -s extglob

dnf clean all

# Clean /var without removing mounted tmpfs directories
rm -rf /var/* /var/.* 2>/dev/null || true
rm -rf /.gitkeep /boot
mkdir -p /boot /var

# Make /usr/local writeable
mv /usr/local /var/usrlocal
ln -s /var/usrlocal /usr/local
