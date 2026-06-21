# 使用前必看 | Getting Started

> 📖 其他语言版本: [English](GETTING_STARTED_EN.md) | [繁體中文](GETTING_STARTED_TW.md)

---

## 📋 项目简介

FurCircle 是一个 Furry 社区 APP 的 Android 原型项目，采用 Kotlin + Jetpack Compose 技术栈开发。
可以作为 Android 开发的学习参考或原型基础。

### 技术栈
- **语言**: Kotlin
- **UI**: Jetpack Compose + XML（启动页）
- **最低版本**: Android 9.0 (API 28)
- **目标版本**: Android 16 (API 36)
- **构建工具**: Gradle 8.5 + AGP 8.2.0
- **NDK**: CMake + C++17

---

## 💻 环境要求

### 方式一：Android Studio（推荐）
- Android Studio Hedgehog (2023.1.1) 或更高版本
- JDK 17（Android Studio 自带）
- Android SDK Platform 36
- Android SDK Build-Tools 33.0.3
- NDK 25.2.9519653
- CMake 3.22.1

### 方式二：命令行
- JDK 17+
- Android SDK
- Gradle 8.5（项目自带 Wrapper，首次构建自动下载）

---

## 🚀 快速开始

### 方法一：使用 Android Studio（推荐新手）

1. **克隆项目**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **打开项目**
   - 启动 Android Studio
   - 选择 `File` → `Open`
   - 选择 FurCircle 项目文件夹
   - 等待 Gradle 同步完成（首次会自动下载依赖）

3. **运行项目**
   - 连接 Android 设备或启动模拟器
   - 点击工具栏的 ▶️ Run 按钮
   - 选择目标设备，等待安装完成

### 方法二：使用自动安装脚本（Linux/macOS）

1. **克隆项目**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   cd FurCircle
   ```

2. **运行依赖检测脚本**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   脚本会自动检测并安装 JDK、Android SDK、NDK、CMake 等依赖。

3. **加载环境变量**
   ```bash
   source ~/furcircle-env/env.sh
   ```

4. **构建项目**
   ```bash
   ./gradlew assembleDebug
   ```

5. **安装 APK**
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

### 方法三：Windows 系统

1. **克隆项目**
   ```cmd
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **运行检测脚本**
   - 双击 `setup.bat`
   - 根据提示安装缺失的依赖

3. **使用 Android Studio 打开项目**
   - 参考方法一

---

## ❓ 常见问题

### Q1: Gradle 同步失败怎么办？
A: 检查网络连接，确保能访问 Google 的 Maven 仓库。国内用户建议配置镜像源。

### Q2: NDK 编译失败怎么办？
A: 确保已安装 NDK 25.2.9519653 和 CMake 3.22.1。可以在 Android Studio 的 SDK Manager 中安装。

### Q3: 签名密钥怎么配置？
A: 项目默认使用 debug 签名。如需正式签名，请在 `app/build.gradle` 中配置签名信息，并将密钥文件放入项目目录。

### Q4: 如何修改包名？
A: 修改 `app/build.gradle` 中的 `applicationId`，并同步修改 Kotlin 文件的包名和 AndroidManifest 中的 `package`。

### Q5: 混淆规则在哪里？
A: 混淆规则文件位于 `app/proguard-rules.pro`，默认采用方案 A（保留组件类名和生命周期，混淆内部逻辑）。

---

## ⚠️ 重要声明

### 禁止二次贩卖

**本项目开源仅供学习、研究和非商业用途使用，严禁将本项目或其衍生作品用于任何形式的二次贩卖、收费分发或商业牟利。**

✅ **你可以：**
- 下载学习、参考研究
- 基于此项目二次开发（非商业用途）
- 提交 Issue 和 PR 贡献代码
- 转发分享（请保留原作者信息和仓库链接）

❌ **你不可以：**
- 将本项目或其修改版本进行售卖、收费下载
- 将本项目用于商业产品或服务
- 移除或修改本声明及原作者信息
- 声称本项目为你自己的原创作品

### 免责声明

本项目按"原样"提供，不提供任何形式的保证。使用本项目造成的任何后果，由使用者自行承担。

---

## 📄 License

本项目采用自定义开源协议，核心原则：**免费开源，禁止商用，禁止二次贩卖**。

使用本项目即表示你同意以上所有条款。
