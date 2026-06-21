package com.xrs.fc.activity

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.lifecycle.lifecycleScope
import com.xrs.fc.R
import com.xrs.fc.logic.StartupTask
import kotlinx.coroutines.launch

class StartupActivity : ComponentActivity() {
    private val startupTask = StartupTask()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 1. 先显示 XML 布局
        setContentView(R.layout.activity_startup)
        // 2. 用协程执行业务代码（不阻塞 UI）
        lifecycleScope.launch {
            val success = startupTask.execute()
            // 3. 业务代码执行完后，跳转到主页面
            if (success) {
                val intent = Intent(this@StartupActivity, FdActivity::class.java)
                startActivity(intent)
                finish()
            }
        }
    }
}
