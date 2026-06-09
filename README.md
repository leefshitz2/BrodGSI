## Released GSIs
Telegram channel: https://t.me/BrodGSI

## How to use

### Download tools
```
git clone https://github.com/leefshitz2/BrodGSI.git
cd BrodGSI
```

### For setting up requirements
```
sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract rename liblzma-dev python3-pip brotli lz4 protobuf-compiler git gawk
pip3 install backports.lzma protobuf twrpdtgen extract-dtb pycryptodome
```

### Generating GSI from stock firmware URL (Only recovery ROMs are supported, don't use it with fastboot ROM)
Example: for making HyperOS 3 of Redmi A7 Pro firmware, you can use this command
```
sudo bash LinkToGSI.sh "https://cdnorg.d.miui.com/OS3.0.3.0.WBVIDXM/arctic_id_global-ota_full-OS3.0.3.0.WBVIDXM-user-16.0-0997a3c45e.zip" Generic
```

### If you have an this error: `Error: Directory UnpackedROMs/system does not exist`

Type this in the your terminal window:
```
git submodule update --init --recursive
```
And then run the script again.


