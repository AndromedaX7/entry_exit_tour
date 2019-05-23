package com.zhhl.entryexittour

import com.uuzuche.lib_zxing.activity.ZXingLibrary
import io.flutter.app.FlutterApplication

class App :FlutterApplication(){
    override fun onCreate() {
        super.onCreate()
        ZXingLibrary.initDisplayOpinion(this)
    }
}