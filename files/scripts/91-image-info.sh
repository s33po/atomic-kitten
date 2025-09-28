#!/usr/bin/env bash

# DO NOT MODIFY THIS FILE UNLESS YOU KNOW WHAT YOU ARE DOING

set -xeuo pipefail

VERSION_ID="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID')"
IMAGE_PRETTY_NAME="Atomic Kitten"

# Add image name as VARIANT_ID. This may get some usage stats through countme data.
sed -i "s/^NAME=.*/NAME=\"${IMAGE_PRETTY_NAME}\"/" /usr/lib/os-release
sed -i "s/^PRETTY_NAME=.*/PRETTY_NAME=\"${IMAGE_PRETTY_NAME} ${VERSION_ID}\"/" /usr/lib/os-release
sed -i "s/^VARIANT_ID=.*/VARIANT_ID=\"${IMAGE_NAME}\"/" /usr/lib/os-release