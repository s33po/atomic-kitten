#!/usr/bin/env bash

set -xeuo pipefail

### TESTING: GNOME 48 backport from HyperScale SIG ###
dnf -y copr enable @centoshyperscale/c10s-gnome-48
dnf -y install glib2

dnf -y install \
    @"Workstation" \
    @"Virtualization Host" 
    
systemctl enable gdm
systemctl set-default graphical.target

dnf -y remove \
    setroubleshoot
    
