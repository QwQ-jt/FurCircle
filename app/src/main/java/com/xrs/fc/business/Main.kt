package com.xrs.fc.business

object Main {
    init {
        // 加载 native 库
        System.loadLibrary("fc")
    }

    fun init() {
        // 初始化 native 层
        nativeInit()
        // 安全校验
        nativeSecurityCheck()
        // 加载 ds 配置
        loadDsConfig()
    }

    // ============== Native 方法 ==============

    /**
     * native 层初始化
     */
    private external fun nativeInit()

    /**
     * 获取 native 库版本号
     */
    external fun nativeGetVersion(): String

    /**
     * native 加法计算示例
     */
    external fun nativeAdd(a: Int, b: Int): Int

    /**
     * 安全校验（签名校验、反调试、完整性校验等）
     */
    private external fun nativeSecurityCheck(): Boolean

    // ============== 业务方法 ==============

    private fun loadDsConfig() {
        // TODO: 加载 ds 配置逻辑
    }
}
