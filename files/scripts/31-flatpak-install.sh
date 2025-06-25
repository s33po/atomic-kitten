#!/usr/bin/env bash

set -xeuo pipefail

# Install system Flatpaks
cat << 'EOF' >> /etc/flatpak/default-flatpaks/system/install
com.mattjakeman.ExtensionManager
page.tesk.Refine
com.github.tchx84.Flatseal
io.github.flattool.Warehouse
com.ranfdev.DistroShelf
com.github.marhkb.Pods
org.gnome.Calendar
org.gnome.Loupe
org.gnome.NautilusPreviewer
org.gnome.Papers
org.gnome.World.PikaBackup
org.gtk.Gtk3theme.adw-gtk3
org.gtk.Gtk3theme.adw-gtk3-dark
org.kde.KStyle.Adwaita
org.mozilla.firefox
com.github.neithern.g4music
io.github.spacingbat3.webcord
org.libreoffice.LibreOffice
io.mpv.Mpv
it.mijorus.gearlever
org.nickvision.tubeconverter
EOF