#!/bin/bash

SCRIPT_DIR=$(dirname "$0")
BASE_DIR="$1"

product="$BASE_DIR/system/product"

    system_ext="$BASE_DIR/system/system_ext"

sed -i "/dataservice_app/d" $product/etc/selinux/product_seapp_contexts
sed -i "/dataservice_app/d" $system_ext/etc/selinux/system_ext_seapp_contexts

# Delete Google apps
sudo rm -rf $BASE_DIR/system/app/datastatusnotification
sudo rm -rf $BASE_DIR/system/app/QAS_DVC_MSP_VZW
sudo rm -rf $BASE_DIR/system/app/VZWAPNLib
sudo rm -rf $BASE_DIR/system/app/vzw_msdc_api
sudo rm -rf $BASE_DIR/system/priv-app/CNEService
sudo rm -rf $BASE_DIR/system/priv-app/DMService
sudo rm -rf $BASE_DIR/system/priv-app/VzwOmaTrigger
sudo rm -rf $BASE_DIR/system/etc/permissions/com.google.android.camera.experimental2017.xml
sudo rm -rf $product/app/YouTube
sudo rm -rf $product/app/YouTubeMusicPrebuilt
sudo rm -rf $product/app/PrebuiltGmail
sudo rm -rf $product/app/Maps
sudo rm -rf $product/app/Drive
sudo rm -rf $product/app/DiagnosticsToolPrebuilt
sudo rm -rf $product/app/CalendarGooglePrebuilt
sudo rm -rf $product/app/NgaResources
sudo rm -rf $product/app/GoogleCamera
sudo rm -rf $product/app/WallpapersBReel*
sudo rm -rf $product/app/Music2
sudo rm -rf $product/app/Photos
sudo rm -rf $product/app/Videos
sudo rm -rf $product/app/DevicePolicyPrebuilt
sudo rm -rf $product/app/GoogleTTS
sudo rm -rf $product/app/MobileFeliCaMenuMainApp
sudo rm -rf $product/app/MobileFeliCaClient
sudo rm -rf $product/priv-app/TurboPrebuilt
sudo rm -rf $product/priv-app/TipsPrebuilt
sudo rm -rf $product/priv-app/BetaFeedback
sudo rm -rf $product/priv-app/HelpRtcPrebuilt
sudo rm -rf $product/priv-app/MyVerizonServices
sudo rm -rf $product/priv-app/OTAConfigPrebuilt
sudo rm -rf $product/priv-app/RecorderPrebuilt
sudo rm -rf $product/priv-app/SafetyHubLprPrebuilt
sudo rm -rf $product/priv-app/ScribePrebuilt
sudo rm -rf $product/priv-app/ConnMO
sudo rm -rf $product/priv-app/DCMO
sudo rm -rf $product/priv-app/SprintDM
sudo rm -rf $product/priv-app/SprintHM
sudo rm -rf $product/priv-app/EuiccSupportPixel
sudo rm -rf $product/priv-app/EuiccGoogle
sudo rm -rf $product/priv-app/WfcActivation
sudo rm -rf $product/priv-app/AmbientSensePrebuilt
sudo rm -rf $product/priv-app/GoogleCamera
sudo rm -rf $product/priv-app/CarrierServices
sudo rm -rf $system_ext/priv-app/GoogleFeedback
sudo rm -rf $system_ext/priv-app/PixelNfc
sudo rm -rf $BASE_DIR/system/app/NfcNci
sudo rm -rf $system_ext/priv-app/YadaYada
sudo rm -rf $BASE_DIR/system/priv-app/TagGoogle
sudo rm -rf $product/app/VZWAPNLib
sudo rm -rf $product/priv-app/AndroidAutoStubPrebuilt
sudo rm -rf $product/priv-app/SafetyHubPrebuilt
sudo rm -rf $product/priv-app/DreamlinerDreamsPrebuilt*
sudo rm -rf $product/priv-app/DreamlinerPrebuilt*
sudo rm -rf $product/priv-app/DreamlinerUpdater
sudo rm -rf $system_ext/priv-app/HbmSVManager
sudo rm -rf $product/overlay/PixelDocumentsUIOverlay
sudo rm -rf $product/priv-app/Velvet
sudo rm -rf $product/priv-app/RecorderPrebuilt*
sudo rm -rf $product/app/arcore-1.42
sudo rm -rf $product/app/talkback
sudo rm -rf $product/priv-app/GoogleRestorePrebuilt*
sudo rm -rf $product/priv-app/AdaptiveVPNPrebuilt*
sudo rm -rf $product/priv-app/AndroidAutoStubPrebuilt
sudo rm -rf $product/priv-app/PrebuiltDeskClockGoogle*
sudo rm -rf $product/priv-app/PixelSupportPrebuilt
sudo rm -rf $product/priv-app/PixelSupportPrebuilt
sudo rm -rf $product/priv-app/WeatherPixelPrebuilt*
sudo rm -rf $product/app/WallpaperEmojiPrebuilt*
sudo rm -rf $product/app/WallpaperAIPrebuilt*

# Hotword
sudo rm -rf $product/priv-app/HotwordEnrollment*
sudo rm -rf $system_ext/framework/com.android.hotwordenrollment*
sudo rm -rf $system_ext/framework/oat/arm/com.android.hotwordenrollment*
sudo rm -rf $system_ext/framework/oat/arm64/com.android.hotwordenrollment*
