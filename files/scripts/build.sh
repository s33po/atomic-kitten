#!/bin/bash

set -xeuo pipefail

CONTEXT_PATH="$(realpath "$(dirname "$0")/..")" # should return /ctx
BUILD_SCRIPTS_PATH="$(realpath "$(dirname "$0")")"

# Skip kernel install during package installation in rpm-ostree
export OSTREE_SKIP_KERNEL_INSTALL=1

printf "::group:: === Copying files ===\n"
cp -avf "${CONTEXT_PATH}/system_files/." /
printf "::endgroup::\n"

for script in $(find ${BUILD_SCRIPTS_PATH} -maxdepth 1 -iname "*-*.sh" -type f | sort --sort=human-numeric); do
  printf "::group:: === $(basename "$script") ===\n"
  "$(realpath $script)"
  printf "::endgroup::\n"
done

printf "::group:: === Image Cleanup ===\n"
# Ensure these get run at the _end_ of the build no matter what
"${BUILD_SCRIPTS_PATH}/cleanup.sh"
printf "::endgroup::\n"