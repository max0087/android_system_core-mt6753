#
# Copyright (C) 2014 MediaTek Inc.
# Modification based on code covered by the mentioned copyright
# and/or permission notice(s).
#
# Copyright 2011 The Android Open Source Project

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= fs_mgr.c fs_mgr_verity.c fs_mgr_fstab.c
LOCAL_SRC_FILES += fs_mgr_format.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include \
    system/vold \
    system/extras/ext4_utils \
    external/openssl/include

LOCAL_MODULE:= libfs_mgr
LOCAL_STATIC_LIBRARIES := liblogwrap libmincrypt libext4_utils_static libsquashfs_utils
LOCAL_C_INCLUDES += system/extras/ext4_utils system/extras/squashfs_utils
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_CFLAGS := -Werror

# Vanzo:tanglei on: Thu, 18 Feb 2016 11:31:29 +0800
ifeq ($(strip $(ADUPS_FOTA_SUPPORT)), yes)
LOCAL_CFLAGS += -DADUPS_FOTA_SUPPORT
endif
# End of Vanzo:tanglei

ifneq (,$(filter userdebug,$(TARGET_BUILD_VARIANT)))
LOCAL_CFLAGS += -DALLOW_ADBD_DISABLE_VERITY=1
endif

# add mtk fstab flags support
LOCAL_CFLAGS += -DMTK_FSTAB_FLAGS
# end

ifeq ($(strip $(MTK_NAND_UBIFS_SUPPORT)),yes)
LOCAL_CFLAGS += -DMTK_UBIFS_SUPPORT
endif

#add for ipoh
ifeq ($(MTK_MLC_NAND_SUPPORT),yes)
LOCAL_CFLAGS += -DBOARD_UBIFS_IPOH_VOLUME_SIZE=$(BOARD_UBIFS_IPOH_VOLUME_SIZE)
endif

include $(BUILD_STATIC_LIBRARY)

# ========================================================
# Shared library
# ========================================================
include $(CLEAR_VARS)
LOCAL_SRC_FILES:= fs_mgr.c fs_mgr_verity.c fs_mgr_fstab.c
LOCAL_SRC_FILES += fs_mgr_format.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include \
    system/vold \
    system/extras/ext4_utils \
    external/openssl/include

LOCAL_MODULE:= libfs_mgr
LOCAL_STATIC_LIBRARIES := liblogwrap libmincrypt libext4_utils_static libsquashfs_utils
LOCAL_STATIC_LIBRARIES += libcutils liblog libsparse_static libz libselinux
LOCAL_C_INCLUDES += system/extras/ext4_utils system/extras/squashfs_utils
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/include
LOCAL_CFLAGS := -Werror

ifneq (,$(filter userdebug,$(TARGET_BUILD_VARIANT)))
LOCAL_CFLAGS += -DALLOW_ADBD_DISABLE_VERITY=1
endif

# add mtk fstab flags support
LOCAL_CFLAGS += -DMTK_FSTAB_FLAGS
# end

ifeq ($(strip $(MTK_NAND_UBIFS_SUPPORT)),yes)
LOCAL_CFLAGS += -DMTK_UBIFS_SUPPORT
endif

#add for ipoh
ifeq ($(MTK_MLC_NAND_SUPPORT),yes)
LOCAL_CFLAGS += -DBOARD_UBIFS_IPOH_VOLUME_SIZE=$(BOARD_UBIFS_IPOH_VOLUME_SIZE)
endif
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= fs_mgr_main.c

LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_MODULE:= fs_mgr

LOCAL_MODULE_TAGS := optional
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_MODULE_PATH := $(TARGET_ROOT_OUT)/sbin
LOCAL_UNSTRIPPED_PATH := $(TARGET_ROOT_OUT_UNSTRIPPED)

LOCAL_STATIC_LIBRARIES := libfs_mgr liblogwrap libcutils liblog libc libmincrypt libext4_utils_static libsquashfs_utils
LOCAL_STATIC_LIBRARIES += libsparse_static libz libselinux
LOCAL_CXX_STL := libc++_static

LOCAL_CFLAGS := -Werror

include $(BUILD_EXECUTABLE)

