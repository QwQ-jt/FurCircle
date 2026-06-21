# FurCircle R8 混淆规则
# ============================================================

# ========== 基础保留属性 ==========
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keepattributes InnerClasses,EnclosingMethod

# ========== Android 核心组件保留（方案 A：保留类名+生命周期方法，混淆内部自定义逻辑） ==========
-keepnames class * extends android.app.Activity
-keepnames class * extends android.app.Service
-keepnames class * extends android.content.BroadcastReceiver
-keepnames class * extends android.content.ContentProvider
-keepnames class * extends android.app.Application
-keepnames class * extends android.app.backup.BackupAgentHelper
-keepnames class * extends android.preference.Preference

# 保留 Activity 生命周期方法
-keepclassmembers class * extends android.app.Activity {
    public void onCreate(android.os.Bundle);
    protected void onCreate(android.os.Bundle);
    public void onStart();
    protected void onStart();
    public void onResume();
    protected void onResume();
    public void onPause();
    protected void onPause();
    public void onStop();
    protected void onStop();
    public void onDestroy();
    protected void onDestroy();
    public void onRestart();
    protected void onRestart();
    public void onActivityResult(int, int, android.content.Intent);
    protected void onActivityResult(int, int, android.content.Intent);
    public void onRequestPermissionsResult(int, java.lang.String[], int[]);
    public void onConfigurationChanged(android.content.res.Configuration);
}

# 保留 Service 生命周期方法
-keepclassmembers class * extends android.app.Service {
    public void onCreate();
    public int onStartCommand(android.content.Intent, int, int);
    public void onDestroy();
    public android.os.IBinder onBind(android.content.Intent);
    public boolean onUnbind(android.content.Intent);
    public void onRebind(android.content.Intent);
}

# 保留 BroadcastReceiver 回调方法
-keepclassmembers class * extends android.content.BroadcastReceiver {
    public void onReceive(android.content.Context, android.content.Intent);
}

# 保留 ContentProvider 生命周期方法
-keepclassmembers class * extends android.content.ContentProvider {
    public boolean onCreate();
    public android.database.Cursor query(android.net.Uri, java.lang.String[], java.lang.String, java.lang.String[], java.lang.String);
    public java.lang.String getType(android.net.Uri);
    public android.net.Uri insert(android.net.Uri, android.content.ContentValues);
    public int delete(android.net.Uri, java.lang.String, java.lang.String[]);
    public int update(android.net.Uri, android.content.ContentValues, java.lang.String, java.lang.String[]);
}

# ========== 保留原生方法 ==========
-keepclasseswithmembernames class * {
    native <methods>;
}

# ========== 保留 View 的构造方法和属性方法 ==========
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}

# ========== Compose 保留规则 ==========
-keep class * extends androidx.compose.runtime.Composable
-keepclassmembers class * {
    @androidx.compose.runtime.Composable *;
}
-keep class androidx.compose.** { *; }
-dontwarn androidx.compose.**

# ========== Kotlin 协程保留 ==========
-keep class kotlinx.coroutines.** { *; }
-dontwarn kotlinx.coroutines.**

# ========== DataStore 保留 ==========
-keep class androidx.datastore.** { *; }
-dontwarn androidx.datastore.**

# ========== 优化选项 ==========
-optimizationpasses 5
-allowaccessmodification
-dontpreverify
-ignorewarnings

# ========== 扁平流控制 & 代码混淆优化 ==========
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-repackageclasses ''

# 移除无用代码
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
}
