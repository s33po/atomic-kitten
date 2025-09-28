# Local testing Makefile for atomic-kitten
SUDO = sudo
PODMAN = $(SUDO) podman

IMAGE_NAME ?= localhost/myimage
CONTAINER_FILE ?= ./Containerfile
VARIANT ?= gnome
IMAGE_CONFIG ?= ./iso.toml

IMAGE_TYPE ?= iso
QEMU_DISK_RAW ?= ./output/disk.raw
QEMU_DISK_QCOW2 ?= ./output/qcow2/disk.qcow2
QEMU_ISO ?= ./output/bootiso/install.iso
OVMF_PATH ?= /usr/share/OVMF/x64/OVMF.4m.fd

.ONESHELL:
.PHONY: clean image bib_image iso qcow2 run-qemu-qcow run-qemu-iso run-qemu help

help:
	@echo "Local testing targets:"
	@echo "  make image     - Build container image"
	@echo "  make iso       - Build bootable ISO"
	@echo "  make qcow2     - Build QCOW2 disk"
	@echo "  make run-qemu-iso  - Run ISO in QEMU"
	@echo "  make run-qemu-qcow - Run QCOW2 in QEMU"
	@echo "  make clean     - Clean output"

clean:
	$(SUDO) rm -rf ./output

image:
	test -f $(CONTAINER_FILE) || { echo "Error: $(CONTAINER_FILE) not found"; exit 1; }
	$(PODMAN) build \
	    --security-opt=label=disable \
	    --cap-add=all \
	    --device /dev/fuse \
	    --build-arg IMAGE_NAME=$(IMAGE_NAME) \
	    --build-arg IMAGE_REGISTRY=localhost \
	    --build-arg VARIANT=$(VARIANT) \
	    -t $(IMAGE_NAME) \
	    -f $(CONTAINER_FILE) \
	    .

bib_image:
	$(SUDO) rm -rf ./output
	mkdir -p ./output

	test -f $(IMAGE_CONFIG) || { echo "Error: $(IMAGE_CONFIG) not found"; exit 1; }
	cp $(IMAGE_CONFIG) ./output/config.toml
	sed -i '/bootc switch/d' ./output/config.toml

	if [ "$(IMAGE_TYPE)" = "iso" ]; then \
	    LIBREPO=False; \
	else \
	    LIBREPO=True; \
	fi;

	$(PODMAN) run \
		--rm \
		-it \
		--privileged \
		--pull=newer \
		--security-opt label=type:unconfined_t \
		-v ./output:/output \
		-v ./output/config.toml:/config.toml:ro \
		-v /var/lib/containers/storage:/var/lib/containers/storage \
		quay.io/centos-bootc/bootc-image-builder:latest \
		--type $(IMAGE_TYPE) \
		--use-librepo=$$LIBREPO \
		--progress verbose \
		$(IMAGE_NAME)

	# Fix ownership of output directory
	$(SUDO) chown -R $(shell id -u):$(shell id -g) ./output
iso:
	make bib_image IMAGE_TYPE=iso

qcow2:
	make bib_image IMAGE_TYPE=qcow2

run-qemu-qcow:
	test -f $(QEMU_DISK_QCOW2) || { echo "Error: $(QEMU_DISK_QCOW2) not found"; exit 1; }
	qemu-system-x86_64 \
	    -M accel=kvm \
	    -cpu host \
	    -smp 2 \
	    -m 4096 \
	    -bios $(OVMF_PATH) \
	    -serial stdio \
	    -snapshot $(QEMU_DISK_QCOW2)

run-qemu-iso:
	mkdir -p ./output
	# Make a disk to install to
	[[ ! -e $(QEMU_DISK_RAW) ]] && dd if=/dev/null of=$(QEMU_DISK_RAW) bs=1M seek=20480

	test -f $(QEMU_ISO) || { echo "Error: $(QEMU_ISO) not found"; exit 1; }
	qemu-system-x86_64 \
	    -M accel=kvm \
	    -cpu host \
	    -smp 2 \
	    -m 4096 \
	    -bios $(OVMF_PATH) \
	    -serial stdio \
	    -boot d \
	    -cdrom $(QEMU_ISO) \
	    -hda $(QEMU_DISK_RAW)

run-qemu:
	test -f $(QEMU_DISK_RAW) || { echo "Error: $(QEMU_DISK_RAW) not found"; exit 1; }
	qemu-system-x86_64 \
	    -M accel=kvm \
	    -cpu host \
	    -smp 2 \
	    -m 4096 \
	    -bios $(OVMF_PATH) \
	    -serial stdio \
	    -hda $(QEMU_DISK_RAW)
