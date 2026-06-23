#!/bin/bash
# ============================================================
# FurCircle - 依赖检测与自动安装脚本
# 支持: Linux / macOS
# 功能: 自动检测 JDK、Android SDK、Gradle、NDK 等依赖，
#       缺失则自动下载安装
# ============================================================

set -e

# ========== 颜色输出 ==========
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; }

# ========== 版本配置 ==========
JAVA_VERSION="21"
JAVA_VERSION_FULL="21.0.3+9"
GRADLE_VERSION="8.5"
ANDROID_COMPILE_SDK="36"
ANDROID_BUILD_TOOLS="33.0.3"
NDK_VERSION="25.2.9519653"
CMAKE_VERSION="3.22.1"

# 安装目录
INSTALL_DIR="$HOME/furcircle-env"
mkdir -p "$INSTALL_DIR"

# ========== 检测操作系统 ==========
detect_os() {
    OS_TYPE="unknown"
    case "$(uname -s)" in
        Linux*)     OS_TYPE="linux";;
        Darwin*)    OS_TYPE="macos";;
        CYGWIN*)    OS_TYPE="windows";;
        MINGW*)     OS_TYPE="windows";;
    esac
    info "检测到操作系统: $OS_TYPE"
}

# ========== 检测并安装 JDK ==========
check_java() {
    info "检测 JDK..."

    if command -v java &> /dev/null; then
        CURRENT_JAVA=$(java -version 2>&1 | head -n 1 | grep -o '"[^"]*"' | tr -d '"')
        info "当前 Java 版本: $CURRENT_JAVA"
        if echo "$CURRENT_JAVA" | grep -q "^$JAVA_VERSION"; then
            success "JDK $JAVA_VERSION 已安装"
            return 0
        else
            warn "Java 版本不匹配，需要 JDK $JAVA_VERSION"
        fi
    else
        warn "未检测到 JDK"
    fi

    # 自动下载安装
    info "正在下载 JDK $JAVA_VERSION_FULL..."
    JAVA_DIR="$INSTALL_DIR/jdk-$JAVA_VERSION_FULL"

    if [ -d "$JAVA_DIR" ]; then
        success "JDK 已存在于 $JAVA_DIR"
    else
        if [ "$OS_TYPE" = "linux" ]; then
            JAVA_URL="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-${JAVA_VERSION_FULL/+/%2B}/OpenJDK21U-jdk_x64_linux_hotspot_${JAVA_VERSION_FULL/+/_}.tar.gz"
        elif [ "$OS_TYPE" = "macos" ]; then
            JAVA_URL="https://github.com/adoptium/temurin21-binaries/releases/download/jdk-${JAVA_VERSION_FULL/+/%2B}/OpenJDK21U-jdk_x64_mac_hotspot_${JAVA_VERSION_FULL/+/_}.tar.gz"
        else
            error "不支持的操作系统: $OS_TYPE"
            return 1
        fi

        TMP_FILE="/tmp/jdk-$JAVA_VERSION_FULL.tar.gz"
        curl -L -o "$TMP_FILE" "$JAVA_URL" --progress-bar
        mkdir -p "$JAVA_DIR"
        tar -xzf "$TMP_FILE" -C "$INSTALL_DIR"
        rm -f "$TMP_FILE"
        success "JDK 安装完成: $JAVA_DIR"
    fi

    # 设置环境变量
    export JAVA_HOME="$JAVA_DIR"
    export PATH="$JAVA_HOME/bin:$PATH"
    info "JAVA_HOME=$JAVA_HOME"
}

# ========== 检测并安装 Android SDK ==========
check_android_sdk() {
    info "检测 Android SDK..."

    if [ -n "$ANDROID_HOME" ] && [ -d "$ANDROID_HOME" ]; then
        success "Android SDK 已存在: $ANDROID_HOME"
        SDK_DIR="$ANDROID_HOME"
    elif [ -n "$ANDROID_SDK_ROOT" ] && [ -d "$ANDROID_SDK_ROOT" ]; then
        success "Android SDK 已存在: $ANDROID_SDK_ROOT"
        SDK_DIR="$ANDROID_SDK_ROOT"
    elif [ -d "$HOME/Android/Sdk" ]; then
        success "Android SDK 已存在: $HOME/Android/Sdk"
        SDK_DIR="$HOME/Android/Sdk"
    else
        warn "未检测到 Android SDK，正在下载 command-line tools..."
        SDK_DIR="$INSTALL_DIR/android-sdk"
        mkdir -p "$SDK_DIR/cmdline-tools"

        if [ "$OS_TYPE" = "linux" ]; then
            SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"
        elif [ "$OS_TYPE" = "macos" ]; then
            SDK_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
        else
            error "不支持的操作系统: $OS_TYPE"
            return 1
        fi

        TMP_FILE="/tmp/android-cmdline-tools.zip"
        curl -L -o "$TMP_FILE" "$SDK_TOOLS_URL" --progress-bar
        unzip -q "$TMP_FILE" -d "$SDK_DIR/cmdline-tools"
        mv "$SDK_DIR/cmdline-tools/cmdline-tools" "$SDK_DIR/cmdline-tools/latest"
        rm -f "$TMP_FILE"
        success "Android command-line tools 安装完成"
    fi

    # 设置环境变量
    export ANDROID_HOME="$SDK_DIR"
    export ANDROID_SDK_ROOT="$SDK_DIR"
    export PATH="$SDK_DIR/cmdline-tools/latest/bin:$SDK_DIR/platform-tools:$PATH"
    info "ANDROID_HOME=$SDK_DIR"

    # 接受 SDK 许可
    info "接受 Android SDK 许可..."
    yes | sdkmanager --licenses > /dev/null 2>&1 || true

    # 安装必要的 SDK 组件
    info "安装 SDK Platform $ANDROID_COMPILE_SDK 和 Build-Tools $ANDROID_BUILD_TOOLS..."
    sdkmanager "platforms;android-$ANDROID_COMPILE_SDK" "build-tools;$ANDROID_BUILD_TOOLS" "platform-tools"
    success "Android SDK 配置完成"
}

# ========== 检测并安装 Gradle ==========
check_gradle() {
    info "检测 Gradle..."

    if command -v gradle &> /dev/null; then
        CURRENT_GRADLE=$(gradle -v 2>&1 | grep "Gradle" | head -n 1 | awk '{print $2}')
        info "当前 Gradle 版本: $CURRENT_GRADLE"
        if [ "$CURRENT_GRADLE" = "$GRADLE_VERSION" ]; then
            success "Gradle $GRADLE_VERSION 已安装"
            return 0
        else
            warn "Gradle 版本不匹配，需要 $GRADLE_VERSION"
        fi
    else
        warn "未检测到 Gradle"
    fi

    # 自动下载安装
    GRADLE_DIR="$INSTALL_DIR/gradle-$GRADLE_VERSION"
    if [ -d "$GRADLE_DIR" ]; then
        success "Gradle 已存在于 $GRADLE_DIR"
    else
        info "正在下载 Gradle $GRADLE_VERSION..."
        GRADLE_URL="https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip"
        TMP_FILE="/tmp/gradle-$GRADLE_VERSION-bin.zip"
        curl -L -o "$TMP_FILE" "$GRADLE_URL" --progress-bar
        unzip -q "$TMP_FILE" -d "$INSTALL_DIR"
        rm -f "$TMP_FILE"
        success "Gradle 安装完成: $GRADLE_DIR"
    fi

    export PATH="$GRADLE_DIR/bin:$PATH"
    info "Gradle 路径已添加"
}

# ========== 检测并安装 NDK / CMake ==========
check_ndk() {
    info "检测 NDK 和 CMake..."

    if [ -d "$ANDROID_HOME/ndk/$NDK_VERSION" ]; then
        success "NDK $NDK_VERSION 已安装"
    else
        warn "未检测到 NDK $NDK_VERSION，正在安装..."
        sdkmanager "ndk;$NDK_VERSION"
        success "NDK $NDK_VERSION 安装完成"
    fi

    if [ -d "$ANDROID_HOME/cmake/$CMAKE_VERSION" ]; then
        success "CMake $CMAKE_VERSION 已安装"
    else
        warn "未检测到 CMake $CMAKE_VERSION，正在安装..."
        sdkmanager "cmake;$CMAKE_VERSION"
        success "CMake $CMAKE_VERSION 安装完成"
    fi
}

# ========== 生成环境配置文件 ==========
generate_env_file() {
    ENV_FILE="$INSTALL_DIR/env.sh"
    info "生成环境配置文件: $ENV_FILE"

    cat > "$ENV_FILE" << EOF
# FurCircle 开发环境配置
# 使用方法: source $ENV_FILE

# JDK
export JAVA_HOME="$JAVA_HOME"
export PATH="\$JAVA_HOME/bin:\$PATH"

# Android SDK
export ANDROID_HOME="$ANDROID_HOME"
export ANDROID_SDK_ROOT="\$ANDROID_HOME"
export PATH="\$ANDROID_HOME/cmdline-tools/latest/bin:\$PATH"
export PATH="\$ANDROID_HOME/platform-tools:\$PATH"
export PATH="\$ANDROID_HOME/ndk/$NDK_VERSION:\$PATH"

# Gradle
# 注: 项目使用 Gradle Wrapper，无需单独安装 Gradle
# 如需全局 Gradle，取消下面注释
# export GRADLE_HOME="$INSTALL_DIR/gradle-$GRADLE_VERSION"
# export PATH="\$GRADLE_HOME/bin:\$PATH"

echo "FurCircle 开发环境已加载"
echo "  JAVA_HOME=\$JAVA_HOME"
echo "  ANDROID_HOME=\$ANDROID_HOME"
EOF

    success "环境配置文件已生成"
    info "使用方法: source $ENV_FILE"
}

# ========== 主函数 ==========
main() {
    echo "============================================"
    echo "  FurCircle 依赖检测与自动安装脚本"
    echo "============================================"
    echo ""

    detect_os
    echo ""

    check_java
    echo ""

    check_android_sdk
    echo ""

    # Gradle 通常项目自带 wrapper，这里只做检测提示
    info "注意: 项目使用 Gradle Wrapper，首次构建会自动下载 Gradle $GRADLE_VERSION"
    echo ""

    check_ndk
    echo ""

    generate_env_file
    echo ""

    success "所有依赖检测与安装完成！"
    echo ""
    echo "下一步操作:"
    echo "  1. 加载环境变量: source $ENV_FILE"
    echo "  2. 进入项目目录: cd FurCircle"
    echo "  3. 构建项目: ./gradlew assembleDebug"
    echo ""
    echo "或者直接使用 Android Studio 打开项目，IDE 会自动处理依赖。"
    echo ""
}

main "$@"
