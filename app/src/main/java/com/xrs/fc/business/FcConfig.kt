package com.xrs.fc.business

import android.content.Context
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.preferencesDataStore
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map

object FcConfig {

    private val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "fc_config")

    // 配置键定义
    private val KEY_KEEP_ALIVE_ENABLED = booleanPreferencesKey("keep_alive_enabled")
    private val KEY_KEEP_ALIVE_MODE = intPreferencesKey("keep_alive_mode")

    // 保活模式枚举
    enum class KeepAliveMode(val value: Int) {
        FOREGROUND_SERVICE(0),  // 前台服务（通知栏）
        FLOATING_WINDOW(1)      // 悬浮窗
    }

    // 保活服务相关配置
    fun keepAliveEnabledFlow(context: Context): Flow<Boolean> {
        return context.dataStore.data.map { preferences ->
            preferences[KEY_KEEP_ALIVE_ENABLED] ?: false
        }
    }

    suspend fun isKeepAliveEnabled(context: Context): Boolean {
        return context.dataStore.data.first()[KEY_KEEP_ALIVE_ENABLED] ?: false
    }

    fun keepAliveModeFlow(context: Context): Flow<KeepAliveMode> {
        return context.dataStore.data.map { preferences ->
            val modeValue = preferences[KEY_KEEP_ALIVE_MODE] ?: 0
            KeepAliveMode.values().find { it.value == modeValue } ?: KeepAliveMode.FOREGROUND_SERVICE
        }
    }

    suspend fun getKeepAliveMode(context: Context): KeepAliveMode {
        val modeValue = context.dataStore.data.first()[KEY_KEEP_ALIVE_MODE] ?: 0
        return KeepAliveMode.values().find { it.value == modeValue } ?: KeepAliveMode.FOREGROUND_SERVICE
    }

    suspend fun setKeepAliveEnabled(context: Context, enabled: Boolean) {
        context.dataStore.edit { preferences ->
            preferences[KEY_KEEP_ALIVE_ENABLED] = enabled
        }
    }

    suspend fun setKeepAliveMode(context: Context, mode: KeepAliveMode) {
        context.dataStore.edit { preferences ->
            preferences[KEY_KEEP_ALIVE_MODE] = mode.value
        }
    }
}
