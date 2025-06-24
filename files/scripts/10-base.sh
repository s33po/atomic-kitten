#!/usr/bin/env bash

set -xeuo pipefail

# Remove subscription manager
dnf remove -y subscription-manager

# Enable epel and crb
dnf install -y 'dnf-command(config-manager)' epel-release
dnf config-manager --set-enabled crb

# Multimedia codecs..

# ..from epel
dnf -y install \
    @multimedia \
    gstreamer1-plugins-{bad-free,bad-free-libs,good,base} \
    lame{,-libs} \
    libjxl \
    ffmpegthumbnailer

# ..from negativo
#dnf config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
#dnf config-manager --set-disabled epel-multimedia
#dnf -y install --enablerepo=epel-multimedia \
#   ffmpeg libavcodec @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl ffmpegthumbnailer

# Some base packages
dnf -y install \
    system-reinstall-bootc \
    plymouth-theme-spinner \
    powertop \
    fuse 

# Remove fluff
dnf -y remove \
    console-login-helper-messages
