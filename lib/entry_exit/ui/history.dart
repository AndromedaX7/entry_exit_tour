import 'package:flutter/material.dart';
import '../app/themes.dart';
import '../app/types.dart';

class HistoryPage extends StatefulWidget {
  int index = 0;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.blue),
      child: DefaultTabController(
        length: 3,
        initialIndex: widget.index,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("历史记录"),
            bottom: TabBar(
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(text: "全部"),
                Tab(text: "今日"),
                Tab(text: "筛选"),
              ],
              onTap: (idx) {
                setState(() {
                  widget.index = idx;
                });
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _scaffoldKey.currentState
                  .showSnackBar(SnackBar(content: Text("放弃吧，搜索什么呀")));
            },
            child: Icon(Icons.search),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HistoryContent(
                "全部",
                count: 2,
              ),
              HistoryContent(
                "今日办理",
                count: 1,
              ),
              DataFilter()
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryContent extends StatefulWidget {
  HistoryContent(this.title, {this.count});

  int count = 0;
  String title;

  @override
  _HistoryContentState createState() => _HistoryContentState();
}

class _HistoryContentState extends State<HistoryContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 4),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.cyanAccent,
            child: Center(
              child: Text(
                "${widget.title}共${widget.count}条",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: ListView.builder(
              itemBuilder: (context, idx) => HistoryItem(idx),
              itemCount: widget.count,
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryItem extends StatefulWidget {
  int idx;

  HistoryItem(this.idx);

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("item${widget.idx}"),
    );
  }
}

class DataFilter extends StatefulWidget {
  @override
  _DataFilterState createState() => _DataFilterState();
}

class _DataFilterState extends State<DataFilter> {
  @override
  Widget build(BuildContext context) {
    return DataChecked();
  }
}

class DataChecked extends StatefulWidget {
  bool empty = true;

  @override
  _DataCheckedState createState() => _DataCheckedState();
}

class _DataCheckedState extends State<DataChecked> {
  final navigator = GlobalKey<NavigatorState>();

  String _startDate = "起始时间";
  String _endDate = "结束时间";

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext c) {
    Container c;
    if (widget.empty) {
      c = Container(
        margin: EdgeInsets.only(left: 48, top: 50, right: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "时间筛选",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 32,
            ),
            FlatButton(
              onPressed: () {
                showDatePickers((date) => {
                      setState(() {
                        _startDate = date;
                      })
                    });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_startDate),
                  SizedBox(
                    height: 32,
                  ),
                  Divider(
                    height: 4,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              onPressed: () {
                showDatePickers((date) => {
                      setState(() {
                        _endDate = date;
                      })
                    });
              },
              child: Container(
                color: AppColors.appColor,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_endDate),
                    SizedBox(
                      height: 32,
                    ),
                    Divider(
                      height: 4,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  widget.empty = false;
                });
              },
              padding: EdgeInsets.symmetric(vertical: 8),
              color: Colors.blue,
              child: Center(
                  child: Text(
                "时间筛选",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ],
        ),
      );
    } else {
      c = Container(
        child: ListView.builder(
          itemBuilder: (c, i) => HistoryItem(i),
          itemCount: 4,
        ),
      );
    }
    return c;
  }

  void showDatePickers(result r) {
//    final context =  navigator.currentState.overlay.context;
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2012),
      lastDate: DateTime(2050),
    ).then((date) => parseDate(date, r));
  }

  void parseDate(DateTime date, result r) {
    String locale = date.toLocal().toIso8601String();
    var index = locale.indexOf("T");
    r(locale.substring(0, index));
  }
}
