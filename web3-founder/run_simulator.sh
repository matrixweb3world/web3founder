#!/bin/bash

# 设置项目和模拟器信息
PROJECT_NAME="web3-founder"
SCHEME_NAME="web3-founder"
CONFIGURATION="Debug"
BUNDLE_ID="matrix.web3-founder"

# 获取 iPhone 16 Pro 模拟器的 UDID
SIMULATOR_UDID=$(xcrun simctl list devices | grep "iPhone 16 Pro" | grep "Booted" | grep -o -E '([A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12})')

if [ -z "$SIMULATOR_UDID" ]; then
    echo "没有找到已启动的 iPhone 16 Pro 模拟器，正在启动..."
    xcrun simctl boot "iPhone 16 Pro"
    SIMULATOR_UDID=$(xcrun simctl list devices | grep "iPhone 16 Pro" | grep "Booted" | grep -o -E '([A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12})')
    
    if [ -z "$SIMULATOR_UDID" ]; then
        echo "未能启动 iPhone 16 Pro 模拟器，请检查是否安装了此模拟器。"
        exit 1
    fi
fi

echo "使用模拟器: $SIMULATOR_UDID"

# 构建项目
echo "正在构建项目..."
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME_NAME}" -destination "platform=iOS Simulator,id=${SIMULATOR_UDID}" -configuration "${CONFIGURATION}" build

# 获取构建产物路径
BUILD_DIR=$(xcodebuild -project "${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME_NAME}" -configuration "${CONFIGURATION}" -showBuildSettings | grep "BUILT_PRODUCTS_DIR" | awk '{print $3}')
APP_PATH="${BUILD_DIR}/${PROJECT_NAME}.app"

# 安装应用到模拟器
echo "正在安装应用到模拟器..."
xcrun simctl install "${SIMULATOR_UDID}" "${APP_PATH}"

# 启动应用
echo "正在启动应用..."
xcrun simctl launch "${SIMULATOR_UDID}" "${BUNDLE_ID}"

echo "应用已成功启动！" 