package com.zhhl.entryexittour

import androidx.core.content.FileProvider

class PhotoProvider : FileProvider() {
    companion object {
        const val authentication = "com.zhhl.entryexittour.photoProvider"
    }
}