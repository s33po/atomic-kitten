#!/usr/bin/env bash

set -xeuo pipefail

# Search for the latest installed kernel version:
KERNEL_SUFFIX=""
QUALIFIED_KERNEL=$(rpm -qa | \
  grep -P 'kernel-(|'"$KERNEL_SUFFIX"'-)(\d+\.\d+\.\d+)' | \
  sed -E 's/kernel-(|'"$KERNEL_SUFFIX"'-)//' | \
  sort -V | tail -n 1)

# Generate initramfs for the newest kernel:
usr/bin/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible --zstd -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"