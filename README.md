## Atomic Kitten Workstation

An opinionated atomic workstation based on the AlmaLinux OS 10 Kitten `bootc` image.

### Features

- Backported GNOME 48 from the CentOS Hyperscale SIG  
- Newer mainline kernel from the CentOS Kmods SIG  
  - Intention to track the next LTS kernel (most likely 6.18) when available  
- Multimedia codecs from Negativo17  
- Firefox ESR removed in favor of the Flatpak version  
- Full virtualization host support  
- Web-based system administration via Cockpit  
- Visual Studio Code included in the image  
- Curated set of tools, utilities, and fonts  
- Some pre-configured system-wide settings and bash aliases (including `defpaks` to install default flatpaks)  
- `lts` branch with the default 6.12 kernel and a bit more "vanilla" setup  

&nbsp;<br>

**This image is intended only for my personal use**

While it's still somewhat experimental, it has been stable enough to serve as my daily driver for couple of months without major issues.

&nbsp;<br>
---
&nbsp;<br>

<p align="center">
  Built using the <a href="https://github.com/AlmaLinux/atomic-respin-template">AlmaLinux atomic-respin-template</a>.<br>
  Inspired by <a href="https://github.com/ublue-os/bluefin-lts">Bluefin LTS</a> and <a href="https://github.com/tuna-os/tunaos">TunaOS</a>.
</p>