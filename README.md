## Released GSIs
Telegram channel: https://t.me/BrodGSI

## How to use

### Download tools
```
git clone https://github.com/leefshitz2/BrodGSI.git
cd BrodGSI
git submodule update --init --recursive
```

### For setting up requirements
```
sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract rename liblzma-dev python3-pip brotli lz4 protobuf-compiler git gawk
pip3 install backports.lzma protobuf twrpdtgen extract-dtb pycryptodome
```

### Generating GSI from stock firmware URL
Example: for making HyperOS 3 of Redmi A7 Pro firmware, you can use this command
```
sudo bash LinkToGSI.sh "https://cdnorg.d.miui.com/OS3.0.3.0.WBVIDXM/arctic_id_global-images-OS3.0.3.0.WBVIDXM-user-20260522.0000.00-16.0-id-b2351f6de5.tgz" Generic
```




