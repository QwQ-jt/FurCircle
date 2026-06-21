# Getting Started | 使用前必看

> 📖 Other languages: [简体中文](GETTING_STARTED.md) | [繁體中文](GETTING_STARTED_TW.md)

---

## 📋 Project Overview

FurCircle is an Android prototype project for a Furry community APP, developed with Kotlin + Jetpack Compose tech stack.
It can be used as a learning reference or prototype base for Android development.

### Tech Stack
- **Language**: Kotlin
- **UI**: Jetpack Compose + XML (Splash Screen)
- **Min SDK**: Android 9.0 (API 28)
- **Target SDK**: Android 16 (API 36)
- **Build Tools**: Gradle 8.5 + AGP 8.2.0
- **NDK**: CMake + C++17

---

## 💻 Requirements

### Option 1: Android Studio (Recommended)
- Android Studio Hedgehog (2023.1.1) or higher
- JDK 17 (bundled with Android Studio)
- Android SDK Platform 36
- Android SDK Build-Tools 33.0.3
- NDK 25.2.9519653
- CMake 3.22.1

### Option 2: Command Line
- JDK 17+
- Android SDK
- Gradle 8.5 (Project includes Wrapper, auto-downloads on first build)

---

## 🚀 Quick Start

### Method 1: Using Android Studio (Recommended for Beginners)

1. **Clone the Project**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **Open the Project**
   - Launch Android Studio
   - Select `File` → `Open`
   - Select the FurCircle project folder
   - Wait for Gradle sync to complete (dependencies will auto-download on first run)

3. **Run the Project**
   - Connect an Android device or start an emulator
   - Click the ▶️ Run button in the toolbar
   - Select target device and wait for installation

### Method 2: Using Auto-Install Script (Linux/macOS)

1. **Clone the Project**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   cd FurCircle
   ```

2. **Run Dependency Check Script**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   The script will automatically detect and install JDK, Android SDK, NDK, CMake, and other dependencies.

3. **Load Environment Variables**
   ```bash
   source ~/furcircle-env/env.sh
   ```

4. **Build the Project**
   ```bash
   ./gradlew assembleDebug
   ```

5. **Install APK**
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

### Method 3: Windows System

1. **Clone the Project**
   ```cmd
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **Run Detection Script**
   - Double-click `setup.bat`
   - Install missing dependencies as prompted

3. **Open Project with Android Studio**
   - Refer to Method 1

---

## ❓ FAQ

### Q1: What if Gradle sync fails?
A: Check your network connection and ensure access to Google's Maven repository. Users in China may want to configure mirror sources.

### Q2: What if NDK compilation fails?
A: Ensure NDK 25.2.9519653 and CMake 3.22.1 are installed. You can install them in Android Studio's SDK Manager.

### Q3: How to configure signing keys?
A: The project uses debug signing by default. For release signing, configure signing info in `app/build.gradle` and place the keystore file in the project directory.

### Q4: How to change the package name?
A: Modify `applicationId` in `app/build.gradle`, and update the package names in Kotlin files and the `package` attribute in AndroidManifest accordingly.

### Q5: Where are the ProGuard rules?
A: ProGuard rules are located at `app/proguard-rules.pro`. By default, Plan A is used (keep component class names and lifecycle, obfuscate internal logic).

---

## ⚠️ Important Notice

### No Reselling

**This project is open source for learning, research, and non-commercial use only. It is strictly prohibited to use this project or its derivatives for any form of secondary resale, paid distribution, or commercial profit.**

✅ **You may:**
- Download for learning and research reference
- Secondary development based on this project (non-commercial use)
- Submit Issues and PRs to contribute code
- Forward and share (please retain original author info and repository link)

❌ **You may not:**
- Sell or charge for downloads of this project or modified versions
- Use this project for commercial products or services
- Remove or modify this notice and original author information
- Claim this project as your own original work

### Disclaimer

This project is provided "as is" without any form of warranty. Any consequences resulting from the use of this project are the sole responsibility of the user.

---

## 📄 License

This project uses a custom open source license with core principles: **Free and open source, no commercial use, no secondary resale**.

By using this project, you agree to all of the above terms.
