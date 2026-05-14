#!/bin/bash

BASE_DIR=$1
SCRIPT_DIR=$(dirname "$0")

# Prefer PHH/SAR layout first
if [ -d "$BASE_DIR/system/product" ] && [ ! -L "$BASE_DIR/system/product" ]; then
    product="$BASE_DIR/system/product"

# Fallback for old layouts
elif [ -d "$BASE_DIR/product" ] && [ ! -L "$BASE_DIR/product" ]; then
    product="$BASE_DIR/product"

else
    echo "error: No product dir"
    exit 1
fi

# PHH Patches
rsync -ra "$SCRIPT_DIR/system/" "$BASE_DIR/system/"
mkdir -p "$product/overlay"
rsync -ra "$SCRIPT_DIR/overlay/" "$product/overlay/"
