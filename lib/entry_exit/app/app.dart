import 'package:entry_exit_tour/entry_exit/app/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/history.dart';
import '../ui/home.dart';
import '../ui/scan.dart';
import '../app/system.dart';

class EntryExitApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarBrightness: Brightness.light));
    getFileSystem();
    getFileDir().then((fileDirRoot) => makeDirectory("$fileDirRoot/capture"));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '边境游 (flutter)',
      theme: ThemeData(
        primarySwatch: AppColors.appColor,
      ),
      routes: {
        "/": (context) => MyHomePage(),
        "scan": (context) => ScanPage(),
        "history": (context) => HistoryPage(),
      },
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
