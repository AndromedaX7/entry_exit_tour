import 'package:flutter/material.dart';
import '../plugin/plugins.dart';
import '../ui/info_details.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _code = "";

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("条形编码"),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 48, right: 48, top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "扫描或输入",
                        style: TextStyle(color: Colors.black, fontSize: 30),
                      ),
                      Text(
                        "业务编码",
                        style: TextStyle(color: Colors.lightBlue, fontSize: 30),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "扫描业务条码\n如条码丢失可手动输入业务编号",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Camera.scan().then((code) => setupCode(code));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Image.asset("images/scan_bg.png"),
                          Positioned(
                            left: 80,
                            right: 80,
                            top: 40,
                            bottom: 50,
                            child: Image.asset("images/ic_scan.png"),
                          ),
                          Positioned(
                            bottom: 12,
                            child: Text(
                              "点击扫描业务条码",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.black54),
                      child: Form(
                        key: _formKey,
                        autovalidate: true,
                        child: TextFormField(
                          onSaved: (text) {
                            _code = text;
                          },
                          validator: (text) {
                            if (text.length == 0) {
                              return "请输入业务编码";
                            }
                            if (text.length != 15) {
                              return "业务编号长度不正确(${text.length}/15)";
                            }
                          },
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: "业务编号",
                            enabledBorder: InputBorder.none,
                            labelStyle: TextStyle(
                              color: Colors.black54,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
//                        onChanged: (text) {
//                          _code = text;
//                        },
//                        onSubmitted: (text) {
//                          _code = text;
//                        },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text("如:纸质材料丢失,请输入业务编号"),
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(6),
            color: Colors.blue,
            child: FlatButton(
              onPressed: () {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _formKey.currentState.save();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                          operationCode: _code,
                        ),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  Text(
                    "确定",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  setupCode(String code) {
    debugPrint(code);
    _code = code;
    _controller.text = code;
    _controller.selection = TextSelection.collapsed(offset: (code.length));
  }
}
