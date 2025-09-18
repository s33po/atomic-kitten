## Atomic Kitten Workstation

An opinionated atomic workstation based on the AlmaLinux OS 10 Kitten `bootc` image.

Built using the [AlmaLinux atomic-respin-template](https://github.com/AlmaLinux/atomic-respin-template).

### Changes from the template:

- Switched the base image from the original `atomic-desktop` to the `kitten-10` bootc image
- Carried over most of the basic configuration from the original `atomic-desktop` base image
- Added multimedia codecs
- Removed Firefox in favor of Flatpak version 
- Added virtualization support, VS Code, and some tools, utilities, and fonts
- Experimental `g48` branch with newer kmods kernel, backported GNOME 48 and other goodies

**Intended for personal use and testing only.**
