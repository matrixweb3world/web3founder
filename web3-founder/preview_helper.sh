#!/bin/bash

# 确保安装了 xcbeautify 工具
if ! command -v xcbeautify &> /dev/null; then
    echo "正在安装 xcbeautify..."
    brew install xcbeautify
fi

# 设置 Xcode 预览环境
defaults write com.apple.dt.Xcode IDELivePreviewEnabled -bool true

# 打开指定文件
PREVIEW_FILE=$1
if [ -z "$PREVIEW_FILE" ]; then
    PREVIEW_FILE="web3-founder/Modules/Discover/Views/DiscoverView.swift"
fi

# 使用 Xcode 打开预览
echo "正在 Xcode 中打开 $PREVIEW_FILE 预览..."
open -a Xcode "$PREVIEW_FILE"

# 输出提示信息
echo "预览已在 Xcode 中打开。请在 Xcode 中:"
echo "1. 点击编辑器右上角的 '预览' 按钮"
echo "2. 使用 Canvas 预览查看 SwiftUI 组件" 