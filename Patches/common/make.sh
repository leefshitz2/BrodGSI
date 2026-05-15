#!/bin/bash

BASE_DIR=$1
SCRIPT_DIR=$(dirname "$0")
TEMP_DIR="$SCRIPT_DIR/../../Temp"

product="$BASE_DIR/system/product"
system_ext="$BASE_DIR/system/system_ext"
SYSTEM_PROP="$BASE_DIR/system/build.prop"

sed -i \
's/^ro.build.display.id=.*/ro.build.display.id=PortedByRofikKernel/' \
"$SYSTEM_PROP"

sed -i \
's/^ro.system.build.display.id=.*/ro.system.build.display.id=PortedByRofikKernel/' \
"$SYSTEM_PROP"
mkdir -p "$product"
mkdir -p "$system_ext"

rsync -ra "$SCRIPT_DIR/system/" "$BASE_DIR/system/"
rsync -ra "$SCRIPT_DIR/system_ext/" "$system_ext/"

sed -i "/ro.secure/d" $BASE_DIR/system/build.prop
sed -i "/ro.adb.secure/d" $BASE_DIR/system/build.prop
sed -i "/ro.debuggable/d" $BASE_DIR/system/build.prop
sed -i "/ro.force.debuggable/d" $BASE_DIR/system/build.prop
sed -i "/media.settings.xml/d" $BASE_DIR/system/build.prop
sed -i "/ro.arch/d" $BASE_DIR/system/build.prop
sed -i "/persist.sys.usb.config/d" $BASE_DIR/system/build.prop
sed -i "/ro.actionable_compatible_property.enabled/d" $BASE_DIR/system/build.prop
sed -i "/ro.setupwizard.mode/d" $BASE_DIR/system/build.prop
if [ -f "$product/etc/build.prop" ]; then
    sed -i "/ro.setupwizard.mode/d" "$product/etc/build.prop"
    sed -i "/ro.product.ab_ota_partitions/d" "$product/etc/build.prop"
    cat "$SCRIPT_DIR/product_build.prop" >> "$product/etc/build.prop"
fi

cat $SCRIPT_DIR/system_build.prop >> $BASE_DIR/system/build.prop
cat $SCRIPT_DIR/product_build.prop >> $product/etc/build.prop
cat $SCRIPT_DIR/file_contexts >> $BASE_DIR/system/etc/selinux/plat_file_contexts


rm -rf $system_ext/etc/permissions/qti_permissions.xml
rm -rf $system_ext/etc/permissions/com.qti.dpmframework.xml

rm -rf $system_ext/app/QesdkSysService
rm -rf $system_ext/priv-app/com.qualcomm.qti.services.systemhelper
rm -rf $system_ext/priv-app/com.qualcomm.location

rm -rf $system_ext/priv-app/QtiWifiService
rm -rf $system_ext/priv-app/dpmserviceapp


rm -rf $BASE_DIR/system/app/DiracManager

$SCRIPT_DIR/../../Tools/sepolicy/sepolicy_prop_remover.sh $BASE_DIR/system/etc/selinux/plat_property_contexts "device/qcom/sepolicy" > $TEMP_DIR/plat_property_contexts
mv $TEMP_DIR/plat_property_contexts $BASE_DIR/system/etc/selinux/plat_property_contexts
sed -i "/typetransition location_app/d" $BASE_DIR/system/etc/selinux/plat_sepolicy.cil

sed -i "/reboot_on_failure/d" $BASE_DIR/system/etc/init/hw/init.rc
sed -i "/reboot_on_failure/d" $BASE_DIR/system/etc/init/apexd.rc
sed -i "/reserved_disk/d" $BASE_DIR/system/etc/init/vold.rc

system_ext_plat_property=$system_ext/etc/selinux/system_ext_property_contexts
sed -i "/persist.vendor.camera/d" $system_ext_plat_property
sed -i "/ro.vendor.camera/d" $system_ext_plat_property
sed -i "/vendor.camera/d" $system_ext_plat_property

sed -i "/persist.vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/ro.vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/vendor.camera/d" $system_ext/etc/selinux/system_ext_sepolicy.cil
sed -i "/genfscon/d" $system_ext/etc/selinux/system_ext_sepolicy.cil

rm -rf $system_ext/etc/selinux/mapping/*
rm -rf $product/etc/selinux/mapping/*

rm -rf $BASE_DIR/system/bin/update_engine
rm -rf $BASE_DIR/system/bin/update_verifier
rm -rf $BASE_DIR/system/etc/init/recovery-persist.rc
rm -rf $BASE_DIR/system/etc/init/recovery-refresh.rc
rm -rf $BASE_DIR/system/etc/init/update_engine.rc
rm -rf $BASE_DIR/system/etc/init/update_verifier.rc
rm -rf $BASE_DIR/system/etc/init/cppreopts.rc
rm -rf $BASE_DIR/system/etc/init/otapreopt.rc

rm -rf $BASE_DIR/system/merge_config_*
rm -rf $system_ext/apex/com.android.vndk.v*

find "$BASE_DIR" -type d \( -name "app" -o -name "priv-app" \) | while read -r dir; do
    find "$dir" -type d -name "oat" -exec rm -rf {} + 2>/dev/null
    find "$dir" -type f -name "*.prof" -exec rm -f {} + 2>/dev/null
done

find "$BASE_DIR" -type f -name "fstab.*" -exec rm -f {} + 2>/dev/null
find "$BASE_DIR" -type f -name "verity_key" -exec rm -f {} + 2>/dev/null


