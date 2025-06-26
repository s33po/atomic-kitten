#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
dnf -y install \
    @multimedia \
    gstreamer1-plugins-{base,bad-free-libs} \
    ffmpegthumbnailer \
    lame{,-libs} \
    libjxl
    