# ⚛️ Atomic Kitten 🐱

An opinionated atomic workstation based on the AlmaLinux OS Kitten 10 bootc image.

_Intended for personal use and testing only._ Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).

## Key changes 🏗️

- Switched the base image from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) to the `kitten-10` bootc image  
- Carried over most of the configuration from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) base image  
- Included multimedia codecs from EPEL (Negativo17 as a secondary source)  
- Minimal GNOME base (from [`Bluefin LTS`](https://github.com/ublue-os/bluefin-lts)) instead of the full `@workstation` install  
- Added virtualization support (QEMU/KVM) and VSCodium  
- Integrated settings and features like hibernation from [`atomic-workstation`](https://github.com/AlmaLinux/atomic-workstation)  
- Added an opinionated selection of basic tools, utilities, and fonts  
- Installs a small, opinionated set of system Flatpaks on first boot  

## Planned changes 🚧  

- Re-evaluate the use of [`Bluefin LTS`](https://github.com/ublue-os/bluefin-lts)’s minimal GNOME base — possibly switch back to a full `@workstation` install and remove unnecessary programs  
- Backport GNOME 48 from COPR  
- Consider including Steam in the image to avoid Flatpak-related Steam issues — probably not feasible 🤔  

## ⚠️ This WILL break — do not use ⚠️

Instead, use the [`atomic-respin-template`](https://github.com/AlmaLinux/atomic-respin-template) to create your own repo, stick with AlmaLinux’s official [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) builds, or explore Fedora-based alternatives:

- [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/)  
- [Universal Blue (uBlue)](https://universal-blue.org/)  

Instead, use the [`atomic-respin-template`](https://github.com/AlmaLinux/atomic-respin-template) to create your own repo, stick with AlmaLinux’s official [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) builds, or explore Fedora-based alternatives:

- [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/)  
- [Universal Blue (uBlue)](https://universal-blue.org/)

You may also be interested in [Helium OS](https://heliumos.org/) — an AlmaLinux-based atomic operating system with a KDE desktop and long-term support.


## Resources 📚

- [AlmaLinux Atomic Desktop Images](https://github.com/AlmaLinux/atomic-desktop) 
- [AlmaLinux Atomic SIG](https://wiki.almalinux.org/sigs/Atomic.html)  
- [bootc documentation](https://github.com/containers/bootc)  
- [Podman documentation](https://podman.io/)  
