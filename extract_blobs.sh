#!/bin/bash

# Check if the lineage directory exists; create it if it doesn't
if [ ! -d "lineage" ]; then
    mkdir -p lineage
fi

# Step 3: Extract Blobs

echo "Checking and cloning or updating Xiaomi Marble device tree..."
if [ -d "lineage/device/xiaomi/marble" ]; then
    echo "Xiaomi Marble device tree already exists, updating..."
    cd lineage/device/xiaomi/marble
    git pull
    cd ../../../..
else
    git clone https://github.com/cupid-development/android_device_xiaomi_marble.git -b lineage-21 lineage/device/xiaomi/marble
fi

echo "Checking and cloning or updating Xiaomi SM8450-common device tree..."
if [ -d "lineage/device/xiaomi/sm8450-common" ]; then
    echo "Xiaomi SM8450-common device tree already exists, updating..."
    cd lineage/device/xiaomi/sm8450-common
    git pull
    cd ../../../..
else
    git clone https://github.com/cupid-development/android_device_xiaomi_sm8450-common.git -b lineage-21 lineage/device/xiaomi/sm8450-common
fi

echo "Running setup-makefiles.sh in the marble directory..."
cd lineage/device/xiaomi/marble
bash setup-makefiles.sh

echo "Running extract-files.sh using output from lineage/DumprX..."
bash extract-files.sh ../../../DumprX/out

echo "Blobs extracted successfully!"

