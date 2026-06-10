# BrodGSI — Build GSI from stock firmware

BrodGSI is a set of scripts to convert stock Recovery ROMs into universal GSI.  
Based on OriginGSITool, but improved — supports Android 16/17 and automatically creates two versions of the image: EXT4 and EROFS.

---

## Result

- `*_ext4.zip` — classic EXT4 image (~3.5 GB)
- `*_erofs.zip` — compressed EROFS image (~2.5–3.0 GB) — perfect for devices with a small system partition (Infinix Smart 8, etc.)

---

## Dependencies

### Arch Linux / Manjaro

sudo pacman -S unace unrar zip unzip p7zip sharutils uudeview arj cabextract perl-rename lzma python-pip brotli lz4 protobuf git gawk base-devel android-tools
pip install --break-system-packages protobuf twrpdtgen extract-dtb pycryptodome

### Ubuntu / Debian

sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract rename liblzma-dev python3-pip brotli lz4 protobuf-compiler git gawk
pip3 install backports.lzma protobuf twrpdtgen extract-dtb pycryptodome

---

## Clone the repository

git clone https://github.com/leefshitz2/BrodGSI.git
cd BrodGSI
git submodule update --init --recursive

---

## Build GSI

### 1. Download a Recovery ROM (ZIP)

The script works **only with Recovery ROM** (ZIP file containing `payload.bin`).  
Fastboot ROMs (TGZ) are not supported.

### 2. Run the script

sudo bash LinkToGSI.sh "DIRECT_ZIP_LINK" Generic

Example:
sudo bash LinkToGSI.sh "https://cdnorg.d.miui.com/OS3.0.3.0.WBVIDXM/arctic_id_global-ota_full-OS3.0.3.0.WBVIDXM-user-16.0-0997a3c45e.zip" Generic

### 3. Done

The result is in the `Output/` folder:

ls -lh Output/

---

## Manual extraction (if `LinkToGSI.sh` fails)

If you get the error `Directory UnpackedROMs/system does not exist`, extract the firmware manually:

bash extractRomonly.sh "DownloadedROMs/rom.zip" "UnpackedROMs"

Then run the GSI builder directly:

**sudo bash FoxetGSITool.sh "UnpackedROMs" Generic**

The result will also appear in `Output/`.

---

## Notes

- The `LinkToGSI.sh` script deletes the `UnpackedROMs` folder before each run. To keep it — rename it.
- After a successful build, you'll get two ZIP archives in `Output`:  
  `*_ext4.zip` and `*_erofs.zip`
- For devices with a small `system` partition, use the **EROFS version**. No manual conversion needed.

---

## Common errors

### `7z: command not found`

Install `p7zip`:

**Arch:** `sudo pacman -S p7zip`  
**Ubuntu/Debian:** `sudo apt install p7zip-full`

### `ModuleNotFoundError: No module named 'google'`

Install the correct version of `protobuf`:

pip install --break-system-packages protobuf==3.20.3

### `error: externally-managed-environment`

Use a virtual environment or the `--break-system-packages` flag.

---

## Ready-made GSI channel

Subscribe to our Telegram channel: [@BrodGSI](https://t.me/BrodGSI)

## Credits

- [defnotegor](https://github.com/defnotegor) for OriginGSITool
- [rofikkerneldev](https://github.com/rofikkerneldev) for the Android 16/17 fork
- All testers and users

---

**Happy building! 🔥**
