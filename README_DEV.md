# Web3-Founder 开发指南

本文档提供了在 Web3-Founder 项目中进行开发的相关指南，包括如何使用脚本实现热更新和实时预览。

## 基本命令

以下是在 Web3-Founder 项目中使用热更新和启动模拟器的基本命令：

### 启动模拟器并运行应用

```bash
./web3-founder/run_simulator.sh
```

这个脚本会自动构建应用并在 iPhone 16 Pro 模拟器上启动它。

### 启用热更新（监控文件变化并自动重构）

```bash
./web3-founder/hot_reload.sh
```

此脚本会监控 Swift 文件的变化，并在检测到更改时自动重新构建和安装应用。

### 设置 Cursor 编辑器预览环境

```bash
./web3-founder/setup_preview.sh
```

这个脚本会配置必要的设置，使你能够在 Cursor 编辑器中查看 SwiftUI 预览。

## 热更新开发工作流

1. **启动模拟器**：

   ```bash
   ./web3-founder/run_simulator.sh
   ```

   这会构建应用并在 iPhone 16 Pro 模拟器上启动它。

2. **开启热更新监控**：

   ```bash
   ./web3-founder/hot_reload.sh
   ```

   此脚本会监控 Swift 文件的变化，并在检测到更改时自动重新构建和安装应用。

3. **在 Cursor 编辑器中修改代码**：
   - 打开 `web3-founder.code-workspace` 文件
   - 修改 Swift 文件（例如 `SentimentAnalysisView.swift`）
   - 保存文件

4. **查看更改效果**：
   - 热更新脚本会自动检测文件变化
   - 模拟器中的应用会自动更新以显示新的更改

## 手动构建与安装

如果热更新脚本不能正常工作，可以使用以下命令手动构建和安装应用：

```bash
# 获取模拟器ID
SIMULATOR_ID=$(xcrun simctl list devices | grep "iPhone 16 Pro" | grep "Booted" | grep -o -E '([A-Z0-9]{8}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{12})')

# 构建应用
xcodebuild -project web3-founder.xcodeproj -scheme web3-founder -destination "platform=iOS Simulator,id=$SIMULATOR_ID" -configuration Debug build

# 获取构建路径
BUILD_DIR=$(xcodebuild -project web3-founder.xcodeproj -scheme web3-founder -configuration Debug -showBuildSettings | grep "BUILT_PRODUCTS_DIR" | awk '{print $3}')
APP_PATH="${BUILD_DIR}/web3-founder.app"

# 安装并启动应用
xcrun simctl install "$SIMULATOR_ID" "$APP_PATH"
xcrun simctl launch "$SIMULATOR_ID" matrix.web3-founder
```

## 预览功能

### 在 Cursor 中使用 SwiftUI 预览

1. 打开 Cursor 编辑器，加载 `web3-founder.code-workspace`
2. 打开包含 `PreviewProvider` 的 Swift 文件
3. 使用 `Cmd+Shift+P` 打开命令面板
4. 搜索并选择 "Swift: Start SwiftUI Preview"

### 使用 Xcode 预览

如果 Cursor 的预览功能不可用，可以使用我们的辅助脚本：

```bash
./web3-founder/preview_helper.sh web3-founder/Modules/Discover/Components/SentimentAnalysisView.swift
```

这会在 Xcode 中打开文件，你可以使用 Xcode 的 Canvas 功能查看预览。

## 项目结构

项目主要包含以下模块：

- **Discover**: Twitter KOL 监控与 AI 分析系统
  - `Components/`: 包含各种组件，如情感分析、最新推文、AI 解读等
  - `Views/`: 包含主视图入口

## 常见问题与解决方案

### 热更新脚本没有响应文件变化

可能原因：

- 文件监控服务 `fswatch` 未正确运行
- 没有正确保存文件

解决方案：

1. 重新启动热更新脚本
2. 确保保存文件后等待几秒钟
3. 如果问题持续，使用手动构建命令

### 模拟器无法启动或安装应用

可能原因：

- 模拟器未运行
- 构建路径不正确

解决方案：

1. 确认模拟器 ID：

   ```bash
   xcrun simctl list devices | grep "iPhone 16"
   ```

2. 使用 `open -a Simulator` 命令启动模拟器
3. 重新运行 `run_simulator.sh` 脚本

### 应用在模拟器中没有更新

可能原因：

- 构建未成功
- 安装命令失败

解决方案：

1. 检查构建日志是否有错误
2. 手动运行构建和安装命令
3. 在模拟器中手动关闭并重新启动应用

## 项目编辑建议

- 在 `Components` 目录中添加新组件
- 在 `Views` 目录中定义页面布局
- 在 `Models` 目录中定义数据模型
- 使用预览功能测试 UI 组件在不同环境下的显示效果
- 利用热更新快速查看更改效果

## 脚本说明

### run_simulator.sh

这个脚本会自动执行以下操作：

- 构建项目
- 安装应用到 iPhone 16 Pro 模拟器
- 启动应用

### hot_reload.sh

这个脚本会：

- 首次构建并运行应用
- 监控文件变化
- 在检测到 Swift 文件变化时自动重新构建并更新应用

**注意**: 此脚本需要安装 `fswatch`，如果没有安装，脚本会自动尝试使用 Homebrew 安装。

### setup_preview.sh

这个脚本会：

- 设置 Cursor 编辑器的配置
- 创建工作区文件
- 配置 SwiftUI 预览环境
