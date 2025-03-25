#!/bin/bash

# 手动构建和安装 Web3-Founder 应用脚本
# 此脚本用于在热更新脚本不工作或需要完全重新构建时使用

# 设置项目和模拟器信息
PROJECT_NAME="web3-founder"
SCHEME_NAME="web3-founder"
CONFIGURATION="Debug"
BUNDLE_ID="matrix.web3-founder"

# 显示脚本使用说明
echo "======================================================"
echo "  Web3-Founder 手动构建与安装脚本"
echo "======================================================"
echo "此脚本将执行以下操作："
echo "1. 查找并启动 iPhone 16 Pro 模拟器"
echo "2. 构建应用程序"
echo "3. 将应用程序安装到模拟器"
echo "4. 启动应用程序"
echo "======================================================"

# 获取 iPhone 16 Pro 模拟器的 UDID
echo "正在查找 iPhone 16 Pro 模拟器..."
SIMULATOR_UDID=$(xcrun simctl list devices | grep "iPhone 16 Pro" | grep -o -E '([A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12})' | head -1)

if [ -z "$SIMULATOR_UDID" ]; then
    echo "错误: 未找到 iPhone 16 Pro 模拟器。请确保已在 Xcode 中安装此模拟器。"
    exit 1
fi

echo "找到模拟器: $SIMULATOR_UDID"

# 检查模拟器是否已启动
IS_BOOTED=$(xcrun simctl list devices | grep "$SIMULATOR_UDID" | grep "Booted")
if [ -z "$IS_BOOTED" ]; then
    echo "正在启动模拟器..."
    xcrun simctl boot "$SIMULATOR_UDID"
    
    # 等待模拟器启动
    echo "等待模拟器启动..."
    sleep 5
    
    # 打开模拟器窗口
    open -a Simulator
else
    echo "模拟器已经启动。"
fi

# 获取当前工作目录的绝对路径
CURRENT_DIR=$(pwd)

# 构建项目
echo "正在构建项目..."
xcodebuild -project "${CURRENT_DIR}/${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME_NAME}" -destination "platform=iOS Simulator,id=${SIMULATOR_UDID}" -configuration "${CONFIGURATION}" build

# 检查构建是否成功
if [ $? -ne 0 ]; then
    echo "错误: 构建失败，请检查上面的错误信息。"
    exit 1
fi

# 获取构建产物路径
echo "正在确定构建路径..."
BUILD_DIR=$(xcodebuild -project "${CURRENT_DIR}/${PROJECT_NAME}.xcodeproj" -scheme "${SCHEME_NAME}" -configuration "${CONFIGURATION}" -showBuildSettings | grep "BUILT_PRODUCTS_DIR" | awk '{print $3}')

# 检查 APP_PATH 是否存在
APP_PATH="${BUILD_DIR}/${PROJECT_NAME}.app"
echo "查找应用路径: $APP_PATH"

if [ ! -d "$APP_PATH" ]; then
    echo "警告: 在预期路径找不到应用 bundle，尝试在 DerivedData 目录中查找..."
    
    # 尝试在 DerivedData 目录中查找
    DERIVED_DATA_DIR="${HOME}/Library/Developer/Xcode/DerivedData"
    echo "搜索 DerivedData 目录: $DERIVED_DATA_DIR"
    
    # 搜索包含 web3-founder 的目录
    PROJECT_DERIVED_DATA=$(find "$DERIVED_DATA_DIR" -name "*web3-founder*" -type d -depth 1 | head -1)
    
    if [ -n "$PROJECT_DERIVED_DATA" ]; then
        echo "找到项目的 DerivedData 目录: $PROJECT_DERIVED_DATA"
        
        # 查找 .app 文件
        APP_PATH=$(find "$PROJECT_DERIVED_DATA/Build/Products" -name "${PROJECT_NAME}.app" -type d | head -1)
        
        if [ -z "$APP_PATH" ]; then
            echo "错误: 无法找到应用 bundle。"
            exit 1
        fi
    else
        echo "错误: 无法找到项目的 DerivedData 目录。"
        exit 1
    fi
fi

echo "使用应用路径: $APP_PATH"

# 验证 APP_PATH 是否存在
if [ ! -d "$APP_PATH" ]; then
    echo "错误: 应用路径不存在: $APP_PATH"
    exit 1
fi

# 安装应用到模拟器
echo "正在安装应用到模拟器..."
xcrun simctl install "${SIMULATOR_UDID}" "${APP_PATH}"

# 检查安装是否成功
if [ $? -ne 0 ]; then
    echo "错误: 安装失败，请检查上面的错误信息。"
    exit 1
fi

# 启动应用
echo "正在启动应用..."
xcrun simctl launch "${SIMULATOR_UDID}" "${BUNDLE_ID}"

# 检查启动是否成功
if [ $? -ne 0 ]; then
    echo "错误: 启动应用失败。尝试重新安装应用..."
    xcrun simctl uninstall "${SIMULATOR_UDID}" "${BUNDLE_ID}"
    xcrun simctl install "${SIMULATOR_UDID}" "${APP_PATH}"
    xcrun simctl launch "${SIMULATOR_UDID}" "${BUNDLE_ID}"
fi

echo "======================================================"
echo "  应用已成功构建、安装并启动！"
echo "======================================================" 