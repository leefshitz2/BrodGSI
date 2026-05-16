#!/bin/bash

ROM_LINK=$1
ROM_TYPE=$2

# =========================
# PRIVILEGE HELPER (ADD THIS)
# =========================
if [[ "$EUID" -ne 0 ]]; then
    exec sudo bash "$0" "$@"
fi

partitions="vendor system system_ext product optics prism mi_ext my_bigball my_engineering my_manifest my_region my_carrier my_heytap my_product my_stock"

if [[ -d "Tools/Firmware_extractor" ]]; then
    echo "already..."
else
    echo "Cloning Firmware_extractor..."
    git clone -q --recurse-submodules https://github.com/erfanoabdi/Firmware_extractor.git "Tools"/Firmware_extractor
fi

usage() {
  echo "Usage: $0 [rom_link] [rom_type]"
  echo ""
  echo "Parameters:"
  echo "  rom_link  - Link to the base ROM"
  echo "  rom_type  - Type of rom"
  echo ""
  echo "Example:"
  echo "  sudo bash $0 https://dl.google.com/dl/android/aosp/redfin-tq3a.230901.001.c2-factory-ca20bd02.zip Pixel"
  echo ""
}

supported_roms() {
    echo "Available ROMs:"
    echo ""
    declare -a versions=(12 12.1 13 14 15 16 17)
    for version in "${versions[@]}"; do
        rom_dir="ROMsPatches/$version"
        if [ -d "$rom_dir" ]; then
            names=$(find "$rom_dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' 2>/dev/null)
            filtered=$(echo "$names" | grep -vxF -f <(printf '%s\n' "${versions[@]}"))
            if [ -n "$filtered" ]; then
                echo "Android $version:"
                echo "$filtered" | sed 's|^|  - |' | tr '\n' '\n'
                echo ""
            fi
        fi
    done
}

if [ -z "$2" ]; then
  usage
  supported_roms
  exit 0
fi

# Clean unpack only
sudo rm -rf UnpackedROMs
mkdir -p UnpackedROMs

# Handle ROM source
if [ -f "$ROM_LINK" ]; then

    echo "Using local ROM file:"
    echo "$ROM_LINK"

    ROM_FILE="$ROM_LINK"

else

    echo "Downloading ROM..."

    
    mkdir -p DownloadedROMs
    #rm -rf DownloadedROMs
    mv DownloadedROMs/rom.zip DownloadedROMs/rom_backup.zip
    wget -O "DownloadedROMs/rom.zip" "$ROM_LINK"

    ROM_FILE="DownloadedROMs/rom.zip"

fi

# Extract firmware
Tools/Firmware_extractor/extractor.sh "$ROM_FILE" "UnpackedROMs/"

# Extract partitions
for partition in $partitions; do
    if [[ -f "UnpackedROMs/$partition.img" ]]; then
        echo "Unpacking file: UnpackedROMs/$partition.img"

        mkdir -p "UnpackedROMs/temp_mount"
        mkdir -p "UnpackedROMs/$partition"

        fs_type=$(blkid -o value -s TYPE "UnpackedROMs/$partition.img" 2>/dev/null)

        if [[ "$fs_type" == "ext2" || "$fs_type" == "ext4" ]]; then
            sudo mount -o loop,ro -t ext4 \
                "UnpackedROMs/$partition.img" \
                "UnpackedROMs/temp_mount"
        else
            sudo mount \
                "UnpackedROMs/$partition.img" \
                "UnpackedROMs/temp_mount"
        fi

       sudo cp -a "UnpackedROMs/temp_mount/." "UnpackedROMs/$partition/"

        sudo umount -R "UnpackedROMs/temp_mount"
    fi
done

# Internalize dynamic partitions into system/system
for partition in product system_ext; do

    TARGET="UnpackedROMs/system/system/$partition"

    # Replace symlink placeholder
    if [ -L "$TARGET" ]; then

        echo "Replacing symlinked $partition with real partition"

       sudo rm -f "$TARGET"

        if [ -d "UnpackedROMs/$partition" ]; then
         sudo   mv "UnpackedROMs/$partition" "$TARGET"
        fi

    # Missing inside system/system
    elif [ ! -e "$TARGET" ] && \
         [ -d "UnpackedROMs/$partition" ]; then

        echo "Embedding standalone $partition into system/system"

       sudo mv "UnpackedROMs/$partition" "$TARGET"

    else
        echo "$partition already embedded in system/system"
       sudo rm -rf "UnpackedROMs/$partition"
    fi
done

# Create PHH-style root symlinks
echo "Creating root symlinks..."

sudo rm -rf UnpackedROMs/system/product
sudo rm -rf UnpackedROMs/system/system_ext

sudo ln -s /system/product \
    UnpackedROMs/system/product

sudo ln -s /system/system_ext \
    UnpackedROMs/system/system_ext
    
    
echo "===== VERIFY ====="
#ls -l UnpackedROMs/system/system/


bash FoxetGSITool.sh "UnpackedROMs/system" "$ROM_TYPE"
