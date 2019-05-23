import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../app/system.dart';
import '../plugin/plugins.dart';
import '../ui/image_compare.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({this.operationCode});

  String operationCode;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String photoSavePath = "$fileDir/capture/1558055826105.png";
  String photoSavePath2 = "$fileDir/capture/1558055826105.png";

  String photoUrl =
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1557743347687&di=a7c4589d017d644044f8d6e1994e1484&imgtype=0&src=http%3A%2F%2Fwww.ghost64.com%2Fqqtupian%2FzixunImg%2Flocal%2F2016%2F01%2F28%2F14539576478618.jpg";

  void initState() {
    super.initState();
    Dio()
        .download(photoUrl, photoSavePath)
        .then((val) => debugPrint("download finish"));
  }

  Widget _item(String name, String content) {
    TextStyle style = TextStyle(fontSize: 20);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 32),
          margin: EdgeInsets.all(8),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Positioned(
                child: Text(
                  name,
                  style: style,
                ),
              ),
              Positioned(
                child: Text(
                  content,
                  style: style,
                ),
                left: 100,
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "证件照",
                style: TextStyle(color: Colors.blue),
              ),
              background: Image.network(
                photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                _item("姓名", "aaa"),
                _item("性别", "女"),
                _item("出生日期", "19950902"),
                _item("民族", "汉族"),
                _item("身份证号", "220221199509020020"),
                _item("地域类型", "内地居民"),
                _item("户口所在地", "内地居民"),
                _item("现居地", "内地居民"),
                _item("手机号码", "13211112222"),
                _item("业务编号", widget.operationCode),
                _item("办理业务", "边境游业务"),
                _item("取证时间", "2019-10-01"),
                Container(
                  margin:
                      EdgeInsets.only(top: 30, left: 32, right: 32, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.grey,
                        ),
                        fit: FlexFit.tight,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: FlatButton(
                          onPressed: () {
                            Camera.camera().then(
                              (val) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ImageComparePage(
                                            path: val,remotePath: photoSavePath2,
                                          ),
                                    ),
                                  ),
                            );
                          },
                          child: Text(
                            "拍摄人像照片",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue[400],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
