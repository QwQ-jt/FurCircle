@echo off
REM ============================================================
REM FurCircle - 依赖检测与自动安装脚本 (Windows)
REM 功能: 自动检测 JDK、Android SDK 等依赖，缺失则提示下载
REM ============================================================

setlocal enabledelayedexpansion

echo ============================================
echo   FurCircle Dependencies Setup (Windows)
echo ============================================
echo.

REM ========== 检测 JDK ==========
echo [INFO] Checking JDK...
where java >nul 2>nul
if %errorlevel%==0 (
    for /f "tokens=3" %%v in ('java -version 2^>^&1 ^| findstr /i "version"') do (
        set JAVA_VER=%%~v
        echo [OK] Java version: !JAVA_VER!
    )
) else (
    echo [WARN] JDK not found
    echo.
    echo Please download JDK 17 from:
    echo   https://adoptium.net/temurin/releases/?version=17
    echo.
    echo After installation, set JAVA_HOME environment variable.
    echo.
)

echo.

REM ========== 检测 Android SDK ==========
echo [INFO] Checking Android SDK...
if defined ANDROID_HOME (
    if exist "%ANDROID_HOME%" (
        echo [OK] Android SDK found: %ANDROID_HOME%
    ) else (
        echo [WARN] ANDROID_HOME set but directory not found
    )
) else if defined ANDROID_SDK_ROOT (
    if exist "%ANDROID_SDK_ROOT%" (
        echo [OK] Android SDK found: %ANDROID_SDK_ROOT%
    ) else (
        echo [WARN] ANDROID_SDK_ROOT set but directory not found
    )
) else (
    echo [WARN] Android SDK not found
    echo.
    echo Please install Android Studio from:
    echo   https://developer.android.com/studio
    echo.
    echo Or download Android command-line tools from:
    echo   https://developer.android.com/studio#command-tools
    echo.
)

echo.

REM ========== 检测 Gradle ==========
echo [INFO] Checking Gradle...
where gradle >nul 2>nul
if %errorlevel%==0 (
    for /f "tokens=2" %%v in ('gradle -v 2^>nul ^| findstr "Gradle"') do (
        echo [OK] Gradle version: %%v
    )
) else (
    echo [INFO] Gradle not found globally
    echo [INFO] Note: Project uses Gradle Wrapper, it will download automatically on first build
)

echo.

REM ========== 总结 ==========
echo ============================================
echo   Setup Complete
echo ============================================
echo.
echo Next steps:
echo   1. Open Android Studio
echo   2. File -^> Open -^> Select FurCircle project folder
echo   3. Wait for Gradle sync to complete
echo   4. Connect device or start emulator
echo   5. Click Run button to build and install
echo.
echo If you prefer command line:
echo   cd FurCircle
echo   gradlew.bat assembleDebug
echo.

pause
