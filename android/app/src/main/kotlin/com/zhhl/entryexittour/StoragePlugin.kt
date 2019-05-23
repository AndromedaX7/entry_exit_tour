package com.zhhl.entryexittour

import android.content.Context
import android.os.Environment
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object StoragePlugin {

    val channel_name = "android.os.storage"
    fun registerWith(context: Context, messenger: BinaryMessenger) = MethodChannel(messenger, channel_name).setMethodCallHandler { call, result ->
        when (call.method) {
            "externalStorage" -> result.success(Environment.getExternalStorageDirectory().absolutePath)
            "fileDir" -> result.success(context.filesDir.absolutePath)
            "cacheDir" -> result.success(context.cacheDir.absolutePath)
        }
    }
}
