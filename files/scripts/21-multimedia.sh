#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
dnf -y install \
    @multimedia \
    ffmpegthumbnailer \
    gstreamer1-plugins-{base,bad-free-libs} \
    lame{,-libs} \
    libjxl \
    libheif \
    libwebp \
    webp-pixbuf-loader \
    gdk-pixbuf2-modules-extra \
    avif-pixbuf-loader
