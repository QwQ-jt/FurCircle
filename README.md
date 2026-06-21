# FurCircle

FurCircle Android APP 原型项目

## 项目介绍

这是一个 Furry 社区 APP 的 Android 原型项目，采用 Kotlin + Jetpack Compose 技术栈开发。
可以作为 Android 开发的学习参考或原型基础。

## 功能特点

- 🚀 启动页无缝跳转（透明中转页 + 全屏启动页）
- 🔧 模块化包结构（mian/activity/business/logic/service）
- ⚡ Kotlin 协程优先的异步编程
- 💾 DataStore Preferences 统一配置管理
- 🔋 保活服务（前台服务 / 悬浮窗双模式）
- 📦 OTA 在线升级服务框架
- 🔒 R8 混淆规则（方案 A，兼顾安全与兼容性）
- 🎨 自适应图标支持

## 技术栈

- **语言**: Kotlin
- **UI**: Jetpack Compose + XML（启动页）
- **最低版本**: Android 9.0 (API 28)
- **目标版本**: Android 16 (API 36)
- **构建工具**: Gradle 8.5 + AGP 8.2.0
- **异步**: Kotlin Coroutines
- **数据存储**: DataStore Preferences
- **NDK**: 支持（预留 jniLibs 目录）

## 项目结构

```
app/src/main/
├── java/com/xrs/
│   ├── fc/
│   │   ├── mian/              # 主入口
│   │   ├── activity/          # Activity 页面
│   │   ├── business/          # 核心业务逻辑
│   │   └── logic/             # 业务逻辑类
│   └── service/               # 服务类（与 fc 同级）
├── jniLibs/                   # SO 库
└── res/                       # 资源文件
```

## 使用说明

1. 克隆项目到本地
2. 使用 Android Studio 打开
3. 等待 Gradle 同步完成
4. 连接设备或启动模拟器，运行项目

## ⚠️ 重要声明

### 禁止二次贩卖

**本项目开源仅供学习、研究和非商业用途使用，严禁将本项目或其衍生作品用于任何形式的二次贩卖、收费分发或商业牟利。**

你可以：
- ✅ 下载学习、参考研究
- ✅ 基于此项目二次开发（非商业用途）
- ✅ 提交 Issue 和 PR 贡献代码
- ✅ 转发分享（请保留原作者信息和仓库链接）

你不可以：
- ❌ 将本项目或其修改版本进行售卖、收费下载
- ❌ 将本项目用于商业产品或服务
- ❌ 移除或修改本声明及原作者信息
- ❌ 声称本项目为你自己的原创作品

### 免责声明

本项目按"原样"提供，不提供任何形式的保证。使用本项目造成的任何后果，由使用者自行承担。

## License

本项目采用自定义开源协议，核心原则：**免费开源，禁止商用，禁止二次贩卖**。

使用本项目即表示你同意以上所有条款。
