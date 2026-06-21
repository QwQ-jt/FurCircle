package com.xrs.fc.mian

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import com.xrs.fc.activity.StartupActivity

class FurMian : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // 跳转到启动页（无动画，无缝跳转）
        val intent = Intent(this, StartupActivity::class.java)
        intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
        startActivity(intent)
        overridePendingTransition(0, 0)
        finish()
    }
}
