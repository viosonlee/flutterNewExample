import 'package:flutter/material.dart';
import 'package:simple_news/http/net_requester.dart';
import 'package:simple_news/models/new_list.dart';
import 'package:simple_news/ui/web_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static const String TAG = "MAIN";

  List<ResultListBean> listData = new List();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "新闻列表",
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: (context, i) {
        if (listData.isNotEmpty)
          return _buildItemView(listData[i]);
        else
          return null;
      },
      itemCount: listData.length,
      separatorBuilder: (context, i) => Container(
        color: Color(0xffd5d5d5),
        height: 1,
      ),
    );
  }

  Widget _buildItemView(ResultListBean listBean) {
    return GestureDetector(
      onTap: () {
        _toDetail(listBean.V3);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        color: Color(0xffffffff),
        child: Text(
          listBean.V2,
          style: TextStyle(color: Color(0xff333333), fontSize: 16),
        ),
      ),
    );
  }

  void _loadData() {
    NetRequester.getListDataNow(4).then((NewList newList) {
      if (mounted)
        setState(() {
          listData = newList.ResultSet.Result;
        });
    });
    return;
  }

//http://fund.megabank.com.tw/ETFData/djhtm/ETNEWSContentMega.djhtm?TYPE=4&DATE=2019/10/12&A=F0D687EE-2404-4300-A1BE-EE080301EC8F
  void _toDetail(String url) => Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        var fullUrl = NetRequester.baseUrl +
            "/ETFData/djhtm/ETNEWSContentMega.djhtm?A=" +
            url;
        debugPrint("fullUrl:" + fullUrl);
        return WebPage(fullUrl);
      }));

  Future<Null> _refresh() async {
    var list = await NetRequester.getListDataNow(4);
    if (mounted)
      setState(() {
        listData = list.ResultSet.Result;
      });
    return null;
  }
}
