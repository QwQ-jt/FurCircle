package com.xrs.service

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.TextView
import androidx.core.app.NotificationCompat
import com.xrs.fc.business.FcConfig
import com.xrs.fc.business.FcConfig.KeepAliveMode
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch

class KeepAliveService : Service() {

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    private val NOTIFICATION_CHANNEL_ID = "keep_alive_channel"
    private val NOTIFICATION_ID = 1001

    private var floatingView: View? = null
    private var windowManager: WindowManager? = null

    override fun onCreate() {
        super.onCreate()
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        serviceScope.launch {
            val enabled = FcConfig.isKeepAliveEnabled(this@KeepAliveService)
            if (!enabled) {
                stopSelf()
                return@launch
            }
            val mode = FcConfig.getKeepAliveMode(this@KeepAliveService)
            when (mode) {
                KeepAliveMode.FOREGROUND_SERVICE -> startForegroundMode()
                KeepAliveMode.FLOATING_WINDOW -> startFloatingWindowMode()
            }
        }
        return START_STICKY
    }

    private fun startForegroundMode() {
        createNotificationChannel()
        val notification = buildNotification()
        startForeground(NOTIFICATION_ID, notification)
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(
                NOTIFICATION_CHANNEL_ID,
                "保活服务",
                NotificationManager.IMPORTANCE_LOW
            ).apply {
                description = "应用后台保活服务通知"
                setShowBadge(false)
            }
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }
    }

    private fun buildNotification(): Notification {
        return NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID)
            .setContentTitle("FurCircle 正在运行")
            .setContentText("后台保活中...")
            .setSmallIcon(android.R.drawable.ic_menu_info_details) // TODO: 替换为正式图标
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setOngoing(true)
            .build()
    }

    private fun startFloatingWindowMode() {
        // TODO: 检查悬浮窗权限
        showFloatingWindow()
    }

    private fun showFloatingWindow() {
        if (floatingView != null) return
        val type = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
        } else {
            @Suppress("DEPRECATION")
            WindowManager.LayoutParams.TYPE_PHONE
        }
        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            type,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                    WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL or
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT
        )
        params.gravity = Gravity.TOP or Gravity.START
        params.x = 0
        params.y = 0
        floatingView = TextView(this).apply {
            text = "●"
            textSize = 16f
            setTextColor(android.graphics.Color.GREEN)
            setPadding(20, 10, 20, 10)
            setBackgroundColor(0x88000000.toInt())
        }
        windowManager?.addView(floatingView, params)
    }

    private fun hideFloatingWindow() {
        floatingView?.let {
            windowManager?.removeView(it)
            floatingView = null
        }
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onDestroy() {
        hideFloatingWindow()
        super.onDestroy()
    }
}
