package com.zhhl.entryexittour

import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object LocalPlugin {
    private const val ChannelName = "android.zxing.scan"
    fun registerWith(context: Context, messenger: BinaryMessenger, handler: MethodChannel.MethodCallHandler) = MethodChannel(messenger, ChannelName).setMethodCallHandler(handler)
}