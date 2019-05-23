import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entry_exit/app/system.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getFileSystem();
    getFileDir().then((val) => makeDirectory("$val/demo"));
    return MaterialApp(
      color: Colors.blue,
      home: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text("嘤嘤嘤"),
            previousPageTitle: "嘤嘤嘤",
          ),
          child: Container(
            child: FutureBuilder(
              builder: (c, as) {
                switch (as.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  case ConnectionState.done:
                    return Center(
                      child: FutureBuilder(
                        builder: (c, as) {
                          switch (as.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            case ConnectionState.active:
                            case ConnectionState.done:
                              return Image.file(File("$fileDir/demo/test.jpg"));
                              break;
                          }
                          return null;
                        },
                        future: Dio().download(
                            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557743347687&di=a7c4589d017d644044f8d6e1994e1484&imgtype=0&src=http%3A%2F%2Fwww.ghost64.com%2Fqqtupian%2FzixunImg%2Flocal%2F2016%2F01%2F28%2F14539576478618.jpg",
                            "$fileDir/demo/test.jpg"),
                      ),
                    );

                    break;
                }
                return null;
              },
              future: getFileDir().then((val) {
                makeDirectory("$val/demo2");
              }),

//
            ),
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
