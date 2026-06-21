package com.xrs.fc.business

object Main {
    init {
        // 加载 native 库
        System.loadLibrary("fc")
    }

    fun init() {
        // 加载 ds 配置
        loadDsConfig()
    }

    private fun loadDsConfig() {
        // TODO: 加载 ds 配置逻辑
    }
}
