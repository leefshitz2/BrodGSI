#!/bin/bash

BASE_DIR=$1
SCRIPT_DIR=$(dirname "$0")


    product="$BASE_DIR/system/product"


# PHH Patches
rsync -ra "$SCRIPT_DIR/system/" "$BASE_DIR/system/"
mkdir -p "$product/overlay"
rsync -ra "$SCRIPT_DIR/overlay/" "$product/overlay/"
