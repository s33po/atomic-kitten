# ⚛️ Atomic Kitten 🐱

An opinionated atomic workstation based on the AlmaLinux OS Kitten 10 bootc image.

_Intended for personal use and testing only._ Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).


## Key changes 🏗️

- Switched the base image from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) to the `kitten-10` bootc image  
- Carried over most of the configuration from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) base image  
- Included multimedia codecs from EPEL (Negativo17 as secondary option)
- Minimal GNOME base (from Bluefin-LTS) instead of the full `@workstation` install  
- Added virtualization support (QEMU/KVM) and VSCodium  
- Added some stuff like hibernation config from [`atomic-workstation`](https://github.com/AlmaLinux/atomic-workstation)  
- Added an opinionated selection of basic tools, utilities, and some fonts  
- Installs an small opinionated set of system Flatpaks on first boot  

## Planned changes 🚧  

- Re-evaluate the use of Bluefin-LTS's "minimal" GNOME base — possibly switch back to a full `@workstation` install and just remove unnecessary programs  
- Backport GNOME 48 from COPR  
- Consider including Steam in the image to avoid Flatpak-related Steam issues, but it might not be feasible 🤔

## ⚠️ This WILL break, do not use ⚠️

Instead, use [`atomic-respin-template`](https://github.com/AlmaLinux/atomic-respin-template) to create your own repo, or use AlmaLinux's official atomic-desktop images, or ready-to-go Fedora alternatives like Universal Blue's images.

## Check out 👀

- [AlmaLinux Atomic Desktop Images](https://github.com/AlmaLinux/atomic-desktop)  
- [Bluefin LTS](https://github.com/ublue-os/bluefin-lts)
- [HeliumOS](https://heliumos.org/)
- [Atomic Desktops for Fedora](https://fedoraproject.org/atomic-desktops/)  
- [Universal Blue (uBlue)](https://universal-blue.org//)  

## Resources 📚

- [AlmaLinux Atomic SIG](https://wiki.almalinux.org/sigs/Atomic.html)  
- [bootc documentation](https://github.com/containers/bootc)  
- [Podman documentation](https://podman.io/)  
