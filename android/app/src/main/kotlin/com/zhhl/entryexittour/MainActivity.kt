package com.zhhl.entryexittour

import android.Manifest
import android.app.Activity
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.provider.MediaStore
import android.support.v4.app.ActivityCompat
import android.support.v4.content.FileProvider
import android.util.Log
import android.view.View
import android.view.WindowManager
import android.widget.Toast
import com.uuzuche.lib_zxing.activity.CaptureActivity
import com.uuzuche.lib_zxing.activity.CodeUtils
import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {
    private val requestScan = 100
    private val requestCamera = 101
    private val permissionRequestCamera = 100
    var result: MethodChannel.Result? = null

    var path: String = ""
    override fun onMethodCall(methodCall: MethodCall?, result: MethodChannel.Result?) {
        methodCall?.let {
            when (it.method) {
                "scan" -> {
                    this.result = result
                    startActivityForResult(Intent(this, CaptureActivity::class.java), requestScan)
                }
//                "scan2" -> {
//                    this.result = result
//                    startActivityForResult(Intent(this, ScanActivity2::class.java), requestScan)
//                }
                "camera" -> {
                    this.result = result
                    val root = File(filesDir, "capture")
                    if (!root.exists()) {
                        root.mkdirs()
                    }
                    val photoFile = File(root, "${System.currentTimeMillis()}.png")
                    path = photoFile.absolutePath
                    val cameraIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
                    val uri = FileProvider.getUriForFile(this, PhotoProvider.authentication, photoFile)
                    Log.e("Uri", "$uri")
                    cameraIntent.putExtra(
                            MediaStore.EXTRA_OUTPUT, uri
                    )
                    startActivityForResult(cameraIntent, requestCamera)
                }
            }
        }

    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        transparentStatus((Color.WHITE))
        GeneratedPluginRegistrant.registerWith(this)
        StoragePlugin.registerWith(this,flutterView)
        LocalPlugin.registerWith(this, flutterView, this)
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.CAMERA) == PackageManager.PERMISSION_DENIED)
            ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.CAMERA), permissionRequestCamera)

    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
//        if (requestCode == requestScan && resultCode == Activity.RESULT_OK) {
//            data?.let { intent ->
//                this.result?.success(intent.getStringExtra(CaptureActivity.OUTPUT_CODE))
//            }
//        }

        if (requestCode == requestScan) run {
            //处理扫描结果（在界面上显示）
            if (null != data) {
                val bundle = data.extras ?: return
                if (bundle.getInt(CodeUtils.RESULT_TYPE) == CodeUtils.RESULT_SUCCESS) {
                    val result = bundle.getString(CodeUtils.RESULT_STRING)
                    this.result?.success(result)
                } else if (bundle.getInt(CodeUtils.RESULT_TYPE) == CodeUtils.RESULT_FAILED) {
                    this.result?.success("")
                    Toast.makeText(this@MainActivity, "解析二维码失败", Toast.LENGTH_LONG).show()
                }
            }
        }

        if (requestCamera == requestCode && resultCode == Activity.RESULT_OK) {
            result?.success(path)
        }
    }
}

fun isLightColor(color: Int): Boolean {
    val r = (color shr 16) and 0xff
    val g = (color shr 8) and 0xff
    val b = color and 0xff
    return r * 0.299 + g * 0.587 + b * 0.114 >= 192
}

fun Activity.transparentStatus(colorRes: Int) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
        var option = (View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (isLightColor(colorRes)) {
                option = (option or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
            }
        }
        window.decorView.systemUiVisibility = option;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
            window.statusBarColor = Color.TRANSPARENT;
        }
    }
}

fun Activity.transparentStatus() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN) {
        window.decorView.systemUiVisibility = (View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
            window.statusBarColor = Color.TRANSPARENT;
        }
    }
}