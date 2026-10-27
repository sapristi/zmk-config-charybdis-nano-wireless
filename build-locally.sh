#!/usr/bin/env bash

set -euxo pipefail

# Requirements:
# 1. https://zmk.dev/docs/development/setup
# 2. checkout zmk main (Zephyr 4.1) and the badjeff/zmk-pmw3610-driver module

build_and_copy () {
    local side=$1
    west build \
        -b nice_nano//zmk -- \
        -DSHIELD=charybdis_$side \
        -DZMK_CONFIG="$CONFIG_DIR" \
        -DZMK_EXTRA_MODULES="$PMW3610_MODULE_DIR"

    cp "./build/zephyr/zmk.uf2" "$CURRENT_DIR/build/charybdis_$side.uf2"
}

CURRENT_DIR="$(pwd)"
CONFIG_DIR="$(pwd)/config"

DEFAULTZMKAPPDIR="$HOME/GitRepos/zmk/app"
ZMK_APP_DIR="${1:-$DEFAULTZMKAPPDIR}"
PMW3610_MODULE_DIR="${2:-$HOME/GitRepos/zmk-pmw3610-driver}"

mkdir -p $CURRENT_DIR/build

pushd $ZMK_APP_DIR

build_and_copy left
build_and_copy right

popd

