import 'dart:async';

import 'package:flutter/services.dart';

class Storage {
  static const _platform = MethodChannel("android.os.storage");

  static Future<String> getExternalStorage() {
    return _platform.invokeMethod("externalStorage");
  }

  static Future<String> getFileDir() {
    return _platform.invokeMethod("fileDir");
  }

  static Future<String> getCacheDir() {
    return _platform.invokeMethod("cacheDir");
  }
}

class Camera {
  static const _platform = MethodChannel("android.zxing.scan");

  static Future scan() {
    return _platform.invokeMethod("scan");
  }

  static Future camera(){
    return _platform.invokeMethod("camera");
  }
}
