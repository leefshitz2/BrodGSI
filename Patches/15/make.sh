#!/bin/bash

BASE_DIR=$1
SCRIPT_DIR=$(dirname "$0")

product="$BASE_DIR/product"

if [ ! -d "$product" ]; then
    echo "error: Missing PHH product dir"
    exit 1
fi

rsync -ra "$SCRIPT_DIR/system/" "$BASE_DIR/system/"
mkdir -p "$product/overlay"
rsync -ra "$SCRIPT_DIR/overlay/" "$product/overlay/"
