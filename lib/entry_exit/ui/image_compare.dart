import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../entity/face_compare_entity.dart';
import '../plugin/plugins.dart';

class ImageComparePage extends StatefulWidget {
  ImageComparePage({@required this.path, this.remotePath});

  String path;
  String remotePath;

  @override
  _ImageComparePageState createState() => _ImageComparePageState();
}

class _ImageComparePageState extends State<ImageComparePage> {
  String sim = "---";
  static const url =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557743347687&di=a7c4589d017d644044f8d6e1994e1484&imgtype=0&src=http%3A%2F%2Fwww.ghost64.com%2Fqqtupian%2FzixunImg%2Flocal%2F2016%2F01%2F28%2F14539576478618.jpg";

  Future<Response> _future;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() {
//    Future<Response> result = Dio().download(url, path);
//    result.then((val) => downloadSuccess());
    downloadSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("返回"),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 26, left: 32, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "照片对比",
              style: TextStyle(fontSize: 30),
            ),
            Text("工作人员依照对比结果判定"),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 30),
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      alignment: Alignment(0, 1),
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: AspectRatio(
                            child: Image.file(
                              File(widget.remotePath),
//                              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557743347687&di=a7c4589d017d644044f8d6e1994e1484&imgtype=0&src=http%3A%2F%2Fwww.ghost64.com%2Fqqtupian%2FzixunImg%2Flocal%2F2016%2F01%2F28%2F14539576478618.jpg",
                              fit: BoxFit.fitHeight,
                            ),
                            aspectRatio: 3 / 4,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: double.infinity,
                            color: Colors.grey,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                "证件照片",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment(0, 1),
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          child: AspectRatio(
                            child: Image.file(
                              File(widget.path),
                              fit: BoxFit.fitHeight,
                            ),
                            aspectRatio: 3 / 4,
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: double.infinity,
                            color: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                "现场照片",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _future,
              builder: (context, asyncSnapShot) {
                switch (asyncSnapShot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return Container( width: double.infinity,height: 60,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    );

                  case ConnectionState.done:
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "相似度",
                          style: TextStyle(fontSize: 24),
                        ),
                        Text(
                          sim,
                          style: TextStyle(fontSize: 24, color: Colors.red),
                        )
                      ],
                    );
                }
              },
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 60,
              child: Row(
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          sim = "---";
                        });
                        Camera.camera().then((val) => setImage(val));
                      },
                      child: Text(
                        "重新拍摄",
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      color: Colors.blue,
                      child: Text(
                        "完成",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  setImage(String val) {
    setState(() {
      widget.path = val;
    });
    downloadSuccess();
  }

  downloadSuccess() {
    var face_byte0 = File(widget.path).readAsBytesSync();
    var face_byte1 = File(widget.remotePath).readAsBytesSync();
//    File("$fileDir/capture/1558055826105.png").readAsBytesSync();

    var face0 = base64Encode(face_byte0);
    var face1 = base64Encode(face_byte1);
    Future<Response> result = Dio().post("http://20.25.0.16:8088/rlsb/rlsb",
        data:
            "{\"func\":\"oneToOne\",\"image1\":\"$face0\",\"image2\":\"$face1\",\"key\":\"732e99787c834a34b01a68129671bb96\",\"token\":\"ab\"}");
    setState(() {
      _future = result;
    });

    result.then((val) => compareFinish(val.data));
  }

  compareFinish(dynamic result) {
    var faceCompareEntity = FaceCompareEntity.fromJson(result);
    debugPrint("=----------------------------");
    debugPrint("相似度：${faceCompareEntity.obj.data.sim}");
    debugPrint("=----------------------------");
    if (faceCompareEntity.obj.data.errorcode == 0) {
      setState(() {
//      sim = (faceCompareEntity.obj.data.sim * 100).ceil() / 100.0;
        sim = "${(faceCompareEntity.obj.data.sim * 100).ceil() / 100.0}%";
      });
    } else {
      setState(() {
        sim = faceCompareEntity.obj.data.errormsg;
      });
    }
  }
}
