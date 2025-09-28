#!/usr/bin/env bash

set -xeuo pipefail

# Search for the latest installed kernel version:
KERNEL_SUFFIX=""
QUALIFIED_KERNEL=$(rpm -q kernel${KERNEL_SUFFIX:+-}${KERNEL_SUFFIX} | \
  sed -E 's/kernel(-'"$KERNEL_SUFFIX"')?-(.*)/\2/' | \
  sort -V | tail -n 1)

echo "Generating initramfs for kernel version: $QUALIFIED_KERNEL"

# Generate initramfs for the newest kernel
INITRAMFS_PATH="/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
/usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree --omit /root -f "$INITRAMFS_PATH"

# Validate the initramfs was created successfully
if [[ ! -s "$INITRAMFS_PATH" ]]; then
  echo "Error: Initramfs generation failed or produced an empty file at $INITRAMFS_PATH"
  exit 1
fi

echo "Initramfs generation completed successfully at $INITRAMFS_PATH"