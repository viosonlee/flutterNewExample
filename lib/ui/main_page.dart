import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:simple_news/http/net_requester.dart';
import 'package:simple_news/models/new_list.dart';
import 'package:simple_news/ui/web_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  static const String TAG = "MAIN";

  List<ResultListBean> _listData = new List();

  String _lastRefreshTime = "";

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "新闻列表",
        ),
      ),
//        body: RefreshIndicator(
//          onRefresh: _refresh,
//          child: _buildListView(),
//        ),
      body: _buildRefreshLoad(),
    );
  }

  Widget _buildRefreshLoad() {
    return EasyRefresh(
      key: _easyRefreshKey,
      autoLoad: false,
//      behavior: ScrollBehavior(),
      refreshHeader: ClassicsHeader(
        key: _headerKey,
        refreshedText: "已刷新",
        refreshingText: "刷新中",
        refreshReadyText: "松开刷新",
        refreshText: "下拉刷新",
        moreInfoColor: Colors.red,
        textColor: Colors.blue,
        bgColor: Colors.white,
//        showMore: true,
        moreInfo: "上次刷新:" + _lastRefreshTime,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        loadReadyText: "松开加载更多",
        loadedText: "已加载",
        loadText: "上拉加载更多",
        loadingText: "正在加载",
        noMoreText: "没有更多了",
        moreInfo: "加载更多了",
        bgColor: Colors.white,
        textColor: Colors.blue,
        moreInfoColor: Colors.grey,
//        showMore: true,
      ),
      child: _buildListView(),
      onRefresh: _refresh,
      loadMore: _loadMore,
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemBuilder: (context, i) {
        if (_listData.isNotEmpty)
          return _buildItemView(_listData[i]);
        else
          return null;
      },
      itemCount: _listData.length,
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

  Future<Null> _loadMore() async {
    var moreList = await NetRequester.getListDataNow(4);
    if (mounted) {
      setState(() {
        _listData.addAll(moreList.ResultSet.Result);
      });
    }
  }

  void _loadData() {
    NetRequester.getListDataNow(4).then((NewList newList) {
      if (mounted)
        setState(() {
          _listData = newList.ResultSet.Result;
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
        _lastRefreshTime = DateTime.now().toString();
        _listData = list.ResultSet.Result;
      });
    return null;
  }
}
