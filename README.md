# CentOS Workstation

CentOS Stream-based image with @Workstation preinstalled. How this is expected to be consumed:

```Dockerfile
FROM ghcr.io/centos-workstation/main:latest # (or whatever tag you want)
RUN dnf -y install fastfetch

$your_hopes_and_dreams_go_here.

RUN bootc container lint
```
