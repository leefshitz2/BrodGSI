#/bin/bash

SCRIPT_DIR=$(dirname "$0")
BASE_DIR="$1"

SOURCE_VENDOR="UnpackedROMs/vendor"
ROFIKKERNEL_DIR="$BASE_DIR/system/rofikkernel"

echo "========== ADDVO =========="
#echo "BASE_DIR=$BASE_DIR"
echo "SOURCE_VENDOR=$SOURCE_VENDOR"
#echo "ROFIKKERNEL_DIR=$ROFIKKERNEL_DIR"

mkdir -p "$ROFIKKERNEL_DIR"

echo "Created:"
ls -ld "$ROFIKKERNEL_DIR"

# Overlay
if [ -d "$SOURCE_VENDOR/overlay" ]; then

    echo "Vendor overlay found"

    mkdir -p "$ROFIKKERNEL_DIR/vo"

    cp -av "$SOURCE_VENDOR/overlay/." \
            "$ROFIKKERNEL_DIR/vo/"

    echo "Overlay copied"

    #ls -l "$ROFIKKERNEL_DIR/vo" | head

else
    echo "Vendor overlay NOT found"
fi

# passwd
if [ -f "$SOURCE_VENDOR/etc/passwd" ]; then

    cp -v "$SOURCE_VENDOR/etc/passwd" \
           "$ROFIKKERNEL_DIR/passwd"

    echo "passwd copied"

else
    echo "passwd NOT found"
fi

# group
if [ -f "$SOURCE_VENDOR/etc/group" ]; then

    cp -v "$SOURCE_VENDOR/etc/group" \
           "$ROFIKKERNEL_DIR/group"

    echo "group copied"

else
    echo "group NOT found"
fi

echo "Appending rw-system-add.sh"

sudo cat "$SCRIPT_DIR/rw-system-add.sh" \
>> "$BASE_DIR/system/bin/rw-system.sh"

echo "rw-system-add.sh appended"

echo "===== FINAL RESULT ====="

ls -l "$ROFIKKERNEL_DIR"

echo "========== ADDVO DONE =========="
