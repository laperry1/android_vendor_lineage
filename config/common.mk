PRODUCT_BRAND ?= crdroidandroid

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.selinux=1

# Default notification/alarm sounds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.config.notification_sound=Chime.ogg \
    ro.config.alarm_alert=Argon.ogg

ifeq ($(BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE),)
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/data/cache
else
  PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.device.cache_dir=/cache
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/lineage/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/lineage/prebuilt/common/bin/50-lineage.sh:system/addon.d/50-lineage.sh \
    vendor/lineage/prebuilt/common/bin/blacklist:system/addon.d/blacklist

ifeq ($(AB_OTA_UPDATER),true)
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/backuptool_ab.sh:system/bin/backuptool_ab.sh \
    vendor/lineage/prebuilt/common/bin/backuptool_ab.functions:system/bin/backuptool_ab.functions \
    vendor/lineage/prebuilt/common/bin/backuptool_postinstall.sh:system/bin/backuptool_postinstall.sh
endif

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Lineage-specific broadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/lineage-sysconfig.xml:system/etc/sysconfig/lineage-sysconfig.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Copy all Lineage-specific init rc files
$(foreach f,$(wildcard vendor/lineage/prebuilt/common/etc/init/*.rc),\
	$(eval PRODUCT_COPY_FILES += $(f):system/etc/init/$(notdir $f)))

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:system/usr/keylayout/Vendor_045e_Product_0719.kl

# Copy Magisk zip
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/magisk.zip:system/addon.d/magisk.zip

#LMT
PRODUCT_COPY_FILES += \
    vendor/lineage/prebuilt/common/app/LMT_v2.9.apk:system/priv-app/LMT/LMT_v2.9.apk \
 	vendor/lineage/prebuilt/common/app/libTouchServiceNative.so:system/lib64/libTouchServiceNative.so

# This is Lineage!
PRODUCT_COPY_FILES += \
    vendor/lineage/config/permissions/org.lineageos.android.xml:system/etc/permissions/org.lineageos.android.xml \
    vendor/lineage/config/permissions/privapp-permissions-lineage.xml:system/etc/permissions/privapp-permissions-lineage.xml

# Include Lineage audio files
include vendor/lineage/config/lineage_audio.mk

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
# Lineage SDK
include vendor/lineage/config/lineage_sdk_common.mk
endif

# TWRP
ifeq ($(WITH_TWRP),true)
include vendor/lineage/config/twrp.mk
endif

# Required Lineage packages
PRODUCT_PACKAGES += \
    BluetoothExt \
    LineageParts \
    Development \
    Profiles

# Optional packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \
    PhotoTable \
    Terminal

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom Lineage packages
PRODUCT_PACKAGES += \
    LineageSettingsProvider \
    ExactCalculator \
    Jelly \
    LockClock \
    WallpaperPicker \
    WeatherProvider

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Berry styles
PRODUCT_PACKAGES += \
    LineageAmberAccent \
    LineageBlackAccent \
    LineageBlueAccent \
    LineageBrownAccent \
    LineageCyanAccent \
    LineageDemonAccent \
    LineageDenimAccent \
    LineageGreenAccent \
    LineageGoldAccent \
    LineageGreyAccent \
    LineageOrangeAccent \
    LineagePinkAccent \
    LineagePurpleAccent \
    LineageRedAccent \
    LineageTealAccent \
    LineageTurquoiseAccent \
    LineageYellowAccent

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    7z \
    awk \
    bash \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    htop \
    lib7z \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    oprofiled \
    pigz \
    powertop \
    sqlite3 \
    strace \
    tune2fs \
    unrar \
    unzip \
    vim \
    wget \
    zip

# Charger
PRODUCT_PACKAGES += \
    charger_res_images

# Custom off-mode charger
ifeq ($(WITH_LINEAGE_CHARGER),true)
PRODUCT_PACKAGES += \
    lineage_charger_res_images \
    font_log.png \
    libhealthd.lineage
endif

# exFAT tools
PRODUCT_PACKAGES += \
    fsck.exfat \
    mkfs.exfat

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Storage manager
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.storage_manager.enabled=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank

# Conditionally build in su
ifneq ($(WITH_SU),false)
PRODUCT_PACKAGES += \
    su
endif
endif

DEVICE_PACKAGE_OVERLAYS += vendor/lineage/overlay/common

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/lineage/build/target/product/security/lineage

-include vendor/lineage-priv/keys/keys.mk

-include $(WORKSPACE)/build_env/image-auto-bits.mk
-include vendor/lineage/config/partner_gms.mk

$(call prepend-product-if-exists, vendor/extra/product.mk)
$(call inherit-product, vendor/lineage/config/crdroid.mk)
$(call inherit-product, vendor/addons/config.mk)
