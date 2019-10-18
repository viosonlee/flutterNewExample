import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_news/ui/main_page.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xffffffff),
    systemNavigationBarDividerColor: null,
    statusBarColor: Color(0x00000000),
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
//    return MainPageCupertino();
  }
}
