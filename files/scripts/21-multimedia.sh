#!/usr/bin/env bash

set -xeuo pipefail

# Multimedia codecs
#dnf -y install \
#    @multimedia \
#    gstreamer1-plugins-{base,bad-free-libs} \
#    ffmpegthumbnailer \
#    lame{,-libs} \
#    libjxl

# Multimedia codecs from negativo17
dnf config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
dnf config-manager --set-disabled epel-multimedia
dnf -y install --enablerepo=epel-multimedia \
   ffmpeg libavcodec @multimedia gstreamer1-plugins-{bad-free,bad-free-libs,good,base} lame{,-libs} libjxl ffmpegthumbnailer