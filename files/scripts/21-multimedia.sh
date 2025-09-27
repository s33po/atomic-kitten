#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
dnf -y install \
    @multimedia \
    ffmpeg \
    libavcodec \
    ffmpegthumbnailer \
    gstreamer1-plugins-{base,bad-free-libs} \
    lame{,-libs} \
    libjxl \
    libheif \
    libwebp \
    webp-pixbuf-loader \
    avif-pixbuf-loader
