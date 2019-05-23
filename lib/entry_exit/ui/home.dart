import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.only(left: 32, top: 80, right: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '请选择功能类型',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                '请选择您要操作的业务选项\n明确您要的才可以给您更好的',
                style: TextStyle(fontSize: 22),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("scan");
              },
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset("images/bg_01.png"),
                    Positioned(
                      right: 30,
                      top: 32,
                      bottom: 32,
                      child: Image.asset("images/ic_01.png"),
                    ),
                    Positioned(
                      left: 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "条码",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "条形编码",
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 40),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed("history");
              },
              child: Container(
                margin: EdgeInsets.only(top: 28),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset("images/bg_02.png"),
                    Positioned(
                      right: 30,
                      top: 32,
                      bottom: 32,
                      child: Image.asset("images/ic_02.png"),
                    ),
                    Positioned(
                      left: 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "查询",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "历史记录",
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}