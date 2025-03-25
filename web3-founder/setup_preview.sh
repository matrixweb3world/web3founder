#!/bin/bash

# 设置项目信息
PROJECT_NAME="web3-founder"
SCHEME_NAME="web3-founder"

# 检查是否安装了 Cursor 编辑器
if [ ! -d "/Applications/Cursor.app" ]; then
    echo "未找到 Cursor 编辑器，请先安装 Cursor: https://cursor.sh/"
    exit 1
fi

# 确保项目已经设置为支持 SwiftUI 预览
echo "正在设置 SwiftUI 预览环境..."

# 检查是否已经安装了必要的工具
if ! command -v xcrun &> /dev/null; then
    echo "xcrun 命令未找到，请确保已安装 Xcode 命令行工具。"
    exit 1
fi

# 设置 Xcode 环境变量，启用实时预览
defaults write com.apple.dt.Xcode IDELivePreviewEnabled -bool true

# 确保项目的 scheme 是可共享的
if [ ! -f "${PROJECT_NAME}.xcodeproj/xcshareddata/xcschemes/${SCHEME_NAME}.xcscheme" ]; then
    echo "警告: 未找到共享的 scheme，可能会影响预览功能。"
    echo "请在 Xcode 中打开项目，然后选择 Product > Scheme > Manage Schemes..."
    echo "确保 ${SCHEME_NAME} scheme 被设为'Shared'。"
fi

# 生成 Cursor 编辑器配置文件
mkdir -p .vscode
cat > .vscode/settings.json << EOL
{
    "swift.swiftFormat.enable": true,
    "swift.swiftlint.enable": true,
    "swift.path.swift_driver_bin": "/usr/bin/swift",
    "swift.disableAutoResolve": false,
    "editor.formatOnSave": true,
    "swift.enableSourceKitLSP": true
}
EOL

# 创建工作区文件
cat > ${PROJECT_NAME}.code-workspace << EOL
{
    "folders": [
        {
            "path": "."
        }
    ],
    "settings": {
        "swift.swiftFormat.enable": true,
        "swift.swiftlint.enable": true,
        "swift.path.swift_driver_bin": "/usr/bin/swift",
        "swift.disableAutoResolve": false,
        "editor.formatOnSave": true,
        "swift.enableSourceKitLSP": true
    },
    "extensions": {
        "recommendations": [
            "swift.swift",
            "vadimcn.vscode-lldb"
        ]
    }
}
EOL

echo "SwiftUI 预览环境设置完成！"
echo "使用说明:"
echo "1. 在 Cursor 编辑器中打开 ${PROJECT_NAME}.code-workspace 文件"
echo "2. 打开任何包含 PreviewProvider 的 Swift 文件"
echo "3. 使用热更新脚本: ./hot_reload.sh"
echo "4. 每次修改文件后，预览将自动更新" 