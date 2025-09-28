#!/usr/bin/env bash

set -xeuo pipefail

systemctl enable bootc-fetch-apply-updates.timer
systemctl enable firewalld
systemctl enable podman.socket
systemctl enable cockpit.socket
systemctl enable libvirtd.service

# Mask atd.service to prevent failures
systemctl mask atd.service

# Disable lastlog display 
authselect enable-feature with-silent-lastlog