# 使用前必看 | Getting Started

> 📖 其他語言版本: [简体中文](GETTING_STARTED.md) | [English](GETTING_STARTED_EN.md)

---

## 📋 專案簡介

FurCircle 是一個 Furry 社群 APP 的 Android 原型專案，採用 Kotlin + Jetpack Compose 技術棧開發。
可做為 Android 開發的學習參考或原型基礎。

### 技術棧
- **語言**: Kotlin
- **UI**: Jetpack Compose + XML（啟動頁）
- **最低版本**: Android 9.0 (API 28)
- **目標版本**: Android 16 (API 36)
- **建構工具**: Gradle 8.5 + AGP 8.2.0
- **NDK**: CMake + C++17

---

## 💻 環境需求

### 方式一：Android Studio（推薦）
- Android Studio Hedgehog (2023.1.1) 或更高版本
- JDK 17（Android Studio 自帶）
- Android SDK Platform 36
- Android SDK Build-Tools 33.0.3
- NDK 25.2.9519653
- CMake 3.22.1

### 方式二：命令列
- JDK 17+
- Android SDK
- Gradle 8.5（專案自帶 Wrapper，首次建構自動下載）

---

## 🚀 快速開始

### 方法一：使用 Android Studio（推薦新手）

1. **複製專案**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **開啟專案**
   - 啟動 Android Studio
   - 選擇 `File` → `Open`
   - 選擇 FurCircle 專案資料夾
   - 等待 Gradle 同步完成（首次會自動下載依賴）

3. **執行專案**
   - 連接 Android 裝置或啟動模擬器
   - 點擊工具列的 ▶️ Run 按鈕
   - 選擇目標裝置，等待安裝完成

### 方法二：使用自動安裝指令碼（Linux/macOS）

1. **複製專案**
   ```bash
   git clone https://github.com/QwQ-jt/FurCircle.git
   cd FurCircle
   ```

2. **執行依賴偵測指令碼**
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```
   指令碼會自動偵測並安裝 JDK、Android SDK、NDK、CMake 等依賴。

3. **載入環境變數**
   ```bash
   source ~/furcircle-env/env.sh
   ```

4. **建構專案**
   ```bash
   ./gradlew assembleDebug
   ```

5. **安裝 APK**
   ```bash
   adb install app/build/outputs/apk/debug/app-debug.apk
   ```

### 方法三：Windows 系統

1. **複製專案**
   ```cmd
   git clone https://github.com/QwQ-jt/FurCircle.git
   ```

2. **執行偵測指令碼**
   - 雙擊 `setup.bat`
   - 根據提示安裝缺少的依賴

3. **使用 Android Studio 開啟專案**
   - 參考方法一

---

## ❓ 常見問題

### Q1: Gradle 同步失敗怎麼辦？
A: 檢查網路連線，確保能存取 Google 的 Maven 倉庫。台灣或中國大陸用戶建議設定鏡像源。

### Q2: NDK 編譯失敗怎麼辦？
A: 確認已安裝 NDK 25.2.9519653 和 CMake 3.22.1。可以在 Android Studio 的 SDK Manager 中安裝。

### Q3: 簽名金鑰怎麼設定？
A: 專案預設使用 debug 簽名。如需正式簽名，請在 `app/build.gradle` 中設定簽名資訊，並將金鑰檔放入專案目錄。

### Q4: 如何修改套件名稱？
A: 修改 `app/build.gradle` 中的 `applicationId`，並同步修改 Kotlin 檔案的套件名和 AndroidManifest 中的 `package`。

### Q5: 混淆規則在哪裡？
A: 混淆規則檔案位於 `app/proguard-rules.pro`，預設採用方案 A（保留元件類名和生命週期，混淆內部邏輯）。

---

## ⚠️ 重要聲明

### 禁止二次販售

**本專案開源僅供學習、研究和非商業用途使用，嚴禁將本專案或其衍生作品用於任何形式的二次販售、收費分發或商業牟利。**

✅ **你可以：**
- 下載學習、參考研究
- 基於此專案二次開發（非商業用途）
- 提交 Issue 和 PR 貢獻程式碼
- 轉發分享（請保留原作者資訊和倉庫連結）

❌ **你不可以：**
- 將本專案或其修改版本進行販售、收費下載
- 將本專案用於商業產品或服務
- 移除或修改本聲明及原作者資訊
- 聲稱本專案為你自己的原創作品

### 免責聲明

本專案按「原樣」提供，不提供任何形式的保證。使用本專案造成的任何後果，由使用者自行承擔。

---

## 📄 License

本專案採用自訂開源協議，核心原則：**免費開源，禁止商用，禁止二次販售**。

使用本專案即表示你同意以上所有條款。
