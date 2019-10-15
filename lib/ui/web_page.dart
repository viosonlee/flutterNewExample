import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebPage extends StatelessWidget {
  final url;
//  FlutterWebviewPlugin _fw_plugin = FlutterWebviewPlugin();
  WebPage(this.url) : assert(url != null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      home: WebviewScaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("新闻详情"),
        ),
        url: url,
        withZoom: true,
        withJavascript: true,
      ),
    );
  }
}
