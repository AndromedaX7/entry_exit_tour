package com.zhhl.entryexittour

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.provider.MediaStore
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import c.feature.autosize.AutoAdaptSize
import c.feature.autosize.ComplexUnit
import c.feature.dsl.okhttp.Method
import c.feature.dsl.okhttp.MimeType
import c.feature.dsl.okhttp.OkHttpDSL
import c.feature.extension.get
import c.feature.extension.transparentStatus
import kotlinx.android.synthetic.main.activity_details.*
import java.io.File


class DetailsActivity : AppCompatActivity(), AutoAdaptSize {

    companion object {
        const val OPERATION_CODE = "1"
    }

    private var path: String = ""
    private var mOperationCode = ""
    private val camera = 1;
    private val commit = 2;
    override fun complexUnit() = ComplexUnit.PT
    override fun designSize() = 320
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_details)
        getIntentData()
        requestInformation()
        transparentStatus(Color.WHITE)
        val root = File(filesDir, "capture")
        if (!root.exists()) {
            root.mkdirs()
        }
        val photoFile = File(root, "${System.currentTimeMillis()}.png")
        path = photoFile.absolutePath
        cancel.setOnClickListener {
            finish()
        }
        mBack.setOnClickListener {
            finish()
        }
        mBack2.setOnClickListener {
            finish()
        }
        takePhoto.setOnClickListener {
            val cameraIntent = Intent(MediaStore.ACTION_IMAGE_CAPTURE)
            val uri = FileProvider.getUriForFile(this, PhotoProvider.authentication, photoFile)
            Log.e("Uri", "$uri")
            cameraIntent.putExtra(
                    MediaStore.EXTRA_OUTPUT, uri
            )
            startActivityForResult(cameraIntent, camera)
//            startActivity(Intent(this,PhotoCompareActivity::class.java))
        }
    }

    private fun requestInformation() {
        val okHttp = OkHttpDSL()
        okHttp {
            requestDescription {
                uri = "http://192.168.20.228:7098"
                method = Method.POST
                body = ""
                mimeType = MimeType.APPLICATION_X_FORM_URLENCODED
            }
//            callType(Activity,{
//
//            },{
//
//            })
            callString({

            }, {
                it.printStackTrace()
            })
        }
    }

    private fun getIntentData() {
        val intentData = intent
        mOperationCode = (intentData[OPERATION_CODE, String::class.java] ?: "")
        operationCode.text = mOperationCode
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == camera && resultCode == Activity.RESULT_OK) {
            startActivityForResult(
                    Intent(this, PhotoCompareActivity::class.java)
                            .putExtra("photoPath", path)
                            .putExtra("content", ""), commit
            )
        }

        if (requestCode == commit && resultCode == PhotoCompareActivity.commitSuccess) {
            setResult(Activity.RESULT_OK)
            finish()
        }
    }
}
