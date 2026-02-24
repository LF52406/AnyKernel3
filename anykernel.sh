### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
## bachnxuan @ esk-project

### AnyKernel setup
# global properties
properties() { '
kernel.string=ESK Kernel by bachxuan @ esk-project
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot shell variables
block=boot
is_slot_device=auto
ramdisk_compression=auto
patch_vbmeta_flag=auto
no_magisk_check=1

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh

ui_print "[*] Verifying kernel image"
"$BIN/busybox" sha256sum -cs Image.zst.sha256 \
  || abort "[!] SHA256 mismatch"
ui_print "[+] SHA256 OK"

ui_print "[*] Unpacking kernel image"
"$BIN/zstd" -d -q --no-progress -o "$AKHOME/Image" "$AKHOME/Image.zst" \
  || abort "[!] Decompress failed"
ui_print "[+] Unpacked kernel successfully"

# boot install
split_boot
if [ -f "split_img/ramdisk.cpio" ]; then
    unpack_ramdisk
    write_boot
else
    flash_boot
fi
## end boot install
