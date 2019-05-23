package com.zhhl.entryexittour

import android.support.v4.content.FileProvider

class PhotoProvider : FileProvider() {
    companion object {
        const val authentication = "com.zhhl.entryexittour.photoProvider"
    }
}