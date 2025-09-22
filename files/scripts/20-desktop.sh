#!/usr/bin/env bash

set -xeuo pipefail

# Backported GNOME 48 from HyperScale SIG
dnf -y copr enable @centoshyperscale/c10s-gnome-48
dnf -y install glib2

# Add Negativo17 for multimedia codecs
dnf config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
dnf config-manager --set-disabled epel-multimedia

# Install multimedia codecs and plugins
dnf -y install --enablerepo=epel-multimedia \
    ffmpeg \
    libavcodec \
    @multimedia \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-bad-free-libs \
    gstreamer1-plugins-good \
    gstreamer1-plugins-base \
    gstreamer1-plugin-vaapi \
    gstreamer1-plugin-libav \
    lame \
    lame-libs \
    libjxl \
    ffmpegthumbnailer \
    libheif \
    libwebp \
    webp-pixbuf-loader \
    avif-pixbuf-loader

# "Workstation" package group includes all the basics for a desktop system
dnf group install -y \
    "Workstation"

dnf -y install \
    systemd-container \
    system-reinstall-bootc

systemctl enable gdm
systemctl set-default graphical.target

# Remove some unnecessary packages
dnf -y remove setroubleshoot console-login-helper-messages PackageKit redhat-flatpak-repo firefox