import 'dart:io';

import 'package:entry_exit_tour/entry_exit/plugin/plugins.dart';

String externalStorage;
String fileDir;
String cacheDir;

void getFileSystem() {
  _getExternalStorage();
  _getFileDir();
  _getCacheDir();
}

void _getExternalStorage() {
  Storage.getExternalStorage().then((val) => {externalStorage = val});
}

void _getFileDir() {
  Storage.getFileDir().then((val) => fileDir = val);
}

void _getCacheDir() {
  Storage.getCacheDir().then((val) => cacheDir = val);
}

Future<String> getFileDir() {
  return Storage.getFileDir();
}

Future<String> getExternalStorage() {
  return Storage.getExternalStorage();
}

Future<String> getCacheDir() {
  return Storage.getCacheDir();
}

void makeDirectory(String path) {
  Directory(path).createSync();
}
