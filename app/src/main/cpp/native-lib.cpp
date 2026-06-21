#include <jni.h>
#include <string>
#include <android/log.h>

#define LOG_TAG "FurCircle-Native"
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, LOG_TAG, __VA_ARGS__)
#define LOGI(...) __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)

// 版本号
#define FC_VERSION "1.0.0"

extern "C" {

/**
 * 初始化 native 库
 * 对应 Kotlin: Main.nativeInit()
 */
JNIEXPORT void JNICALL
Java_com_xrs_fc_business_Main_nativeInit(JNIEnv *env, jobject thiz) {
    LOGI("FurCircle native library initialized, version: %s", FC_VERSION);
}

/**
 * 获取 native 库版本号
 * 对应 Kotlin: Main.nativeGetVersion()
 */
JNIEXPORT jstring JNICALL
Java_com_xrs_fc_business_Main_nativeGetVersion(JNIEnv *env, jobject thiz) {
    return env->NewStringUTF(FC_VERSION);
}

/**
 * 加法计算示例
 * 对应 Kotlin: Main.nativeAdd(a, b)
 */
JNIEXPORT jint JNICALL
Java_com_xrs_fc_business_Main_nativeAdd(JNIEnv *env, jobject thiz, jint a, jint b) {
    jint result = a + b;
    LOGD("nativeAdd: %d + %d = %d", a, b, result);
    return result;
}

/**
 * 安全校验示例（占位，后续可扩展 SSM 安全框架）
 * 对应 Kotlin: Main.nativeSecurityCheck()
 */
JNIEXPORT jboolean JNICALL
Java_com_xrs_fc_business_Main_nativeSecurityCheck(JNIEnv *env, jobject thiz) {
    // TODO: 实现安全校验逻辑（签名校验、反调试、完整性校验等）
    LOGI("nativeSecurityCheck: passed");
    return JNI_TRUE;
}

} // extern "C"
