package com.xrs.fc.logic

import com.xrs.fc.business.Main
import kotlinx.coroutines.delay

class StartupTask {
    suspend fun execute(): Boolean {
        // 1. 核心业务初始化（加载 SO 库、ds 配置等）
        Main.init()
        // 2. 其他启动任务
        doSomeInitWork()
        checkAppVersion()
        preloadData()
        return true
    }

    private suspend fun doSomeInitWork() {
        delay(500) // 模拟耗时
    }

    private suspend fun checkAppVersion() {
        delay(300) // 模拟耗时
    }

    private suspend fun preloadData() {
        delay(200) // 模拟耗时
    }
}
