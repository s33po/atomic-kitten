# Atomic Kitten 🐱

An opinionated atomic workstation based on the AlmaLinux OS Kitten 10 `bootc` image.

**Intended for personal use and testing only.**

Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).


## Key changes from the template

- Switched the base image from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) to the `kitten-10` `bootc` image  
- Carried over most of the configuration from the original [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) base image  
- Added multimedia codecs from Negativo17  
- Removed rpm Firefox and some default GNOME programs in favor of Flatpaks  
- Added virtualization support, VS Code, and an opinionated selection of tools, utilities, and fonts  
- Added hibernation fixes from [`atomic-workstation`](https://github.com/AlmaLinux/atomic-workstation)  


## Experimenting

- Backported GNOME 48 from COPR  
- Adding Steam in to the image – probably not feasible..


## ⚠️ This WILL break — do not use ⚠️

Instead, use the [`atomic-respin-template`](https://github.com/AlmaLinux/atomic-respin-template) to create your own repo, stick with AlmaLinux’s official [`atomic-desktop`](https://github.com/AlmaLinux/atomic-desktop) builds, or explore other alternatives:

- [Fedora Atomic Desktops](https://fedoraproject.org/atomic-desktops/)  
- [Universal Blue (uBlue)](https://universal-blue.org/)  
- [HeliumOS](https://heliumos.org/)
