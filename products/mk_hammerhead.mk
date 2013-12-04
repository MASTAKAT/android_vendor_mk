# Copyright (C) 2013 ParanoidAndroid Project, adapted.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Check for target product

ifeq (mk_hammerhead,$(TARGET_PRODUCT))

# Define bootanimation size
BOOTANIMATION_NAME := XXHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := mk_xxhdpi

# Include common configuration
include vendor/mk/main.mk

# Inherit AOSP device configuration
$(call inherit-product, device/lge/hammerhead/full_hammerhead.mk)

# Override AOSP build properties
PRODUCT_NAME := mk_hammerhead
PRODUCT_BRAND := Google
PRODUCT_MODEL := Nexus 5
PRODUCT_MANUFACTURER := LGE
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=hammerhead BUILD_FINGERPRINT="google/hammerhead/hammerhead:4.4/KRT16M/737497:user/release-keys" PRIVATE_BUILD_DESC=“hammerhead-user 4.4 KRT16M 737497 release-keys"

endif
