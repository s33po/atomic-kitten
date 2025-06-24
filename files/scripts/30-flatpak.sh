#!/usr/bin/env bash

set -xeuo pipefail

# Install system Flatpaks
cat << 'EOF' >> /etc/flatpak/default-flatpaks/system/install
com.mattjakeman.ExtensionManager
com.github.tchx84.Flatseal
io.github.flattool.Warehouse
org.mozilla.Firefox
org.libreoffice.LibreOffice
EOF

systemctl enable -f system-flatpak-setup.timer
systemctl enable -f --global user-flatpak-setup.timer
