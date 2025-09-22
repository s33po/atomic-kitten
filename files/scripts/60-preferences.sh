#!/usr/bin/env bash

set -xeuo pipefail

# Set some bash aliases
cat << 'EOF' > /etc/profile.d/bash_aliases.sh
alias ls='ls --color=auto'
alias ll='ls -la'
alias ..='cd ..'                 
alias ...='cd ../..'             
alias grep='grep --color=auto'  
alias myip='curl ifconfig.me'              
alias fixperms='sudo chown -R $USER:$USER'
alias please='sudo $(fc -ln -1)'
alias defpaks='xargs -a /etc/flatpak/defpaks.list -r flatpak install -y --noninteractive flathub && echo "Flatpak installation complete!"'
EOF

# Set up dconf system profile
mkdir -p /etc/dconf/profile
cat <<EOF > /etc/dconf/profile/user
user-db:user
system-db:local
EOF

# Set GNOME system-wide defaults
mkdir -p /etc/dconf/db/local.d
cat <<EOF > /etc/dconf/db/local.d/00-gnome
[org/gnome/desktop/interface]
color-scheme='prefer-dark'
gtk-theme='Adwaita'
font-name='Noto Sans 11'
document-font-name='Noto Sans 11'
monospace-font-name='JetBrains Mono 12'
icon-theme='Adwaita'
cursor-theme='Adwaita'
accent-color='blue'
clock-format='24h'
clock-show-weekday=true

[org/gnome/desktop/wm/preferences]
button-layout='appmenu:minimize,maximize,close'
center-new-windows=true

[org/gnome/desktop/peripherals/mouse]
accel-profile='flat'

[org/gnome/shell]
enable-hot-corners=false

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings]
custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/']

[org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0]
name='Launch Ptyxis'
binding='<Super>Return'
command='/usr/bin/ptyxis --new-window'

[org/gnome/nautilus/preferences]
sort-directories-first=true
default-folder-viewer='list-view'

[org/gnome/desktop/calendar]
show-weekdate=true
EOF

# Apply settings
dconf update