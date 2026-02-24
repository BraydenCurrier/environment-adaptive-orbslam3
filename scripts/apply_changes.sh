#!/usr/bin/env bash

# =====================================================
# apply_changes.sh
#
# Applies environment-adaptive ORBextractor modifications
# to an existing ORB-SLAM3 clone.
#
# Usage:
#   ./scripts/apply_changes.sh /path/to/ORB_SLAM3
# =====================================================

set -e

ORB_DIR="$1"

if [ -z "$ORB_DIR" ]; then
    echo "Usage: $0 /path/to/ORB_SLAM3"
    exit 1
fi

if [ ! -d "$ORB_DIR" ]; then
    echo "ERROR: Directory does not exist -> $ORB_DIR"
    exit 1
fi

TARGET_SRC="$ORB_DIR/src"
LOCAL_MODIFIED_DIR="$(cd "$(dirname "$0")/../src/modified_files" && pwd)"

if [ ! -d "$TARGET_SRC" ]; then
    echo "ERROR: Could not find ORB_SLAM3/src inside $ORB_DIR"
    exit 1
fi

echo "---------------------------------------"
echo " Applying Adaptive ORBextractor Changes"
echo "---------------------------------------"

echo "Source repo: $ORB_DIR"
echo "Modified files: $LOCAL_MODIFIED_DIR"
echo ""

echo "Copying ORBextractor.h ..."
cp "$LOCAL_MODIFIED_DIR/ORBextractor.h" "$TARGET_SRC/"

echo "Copying ORBextractor.cc ..."
cp "$LOCAL_MODIFIED_DIR/ORBextractor.cc" "$TARGET_SRC/"

echo ""
echo "✅ Changes applied successfully."
echo "You can now rebuild ORB-SLAM3."
