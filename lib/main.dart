import 'package:flutter/material.dart';
import 'package:flutter_wechat_clone/constants.dart';
import 'package:flutter_wechat_clone/pages/main_page.dart';
import 'package:provide/provide.dart';

void main() {
  var providers = Providers();
  var currentIndexProvide = CurrentIndexProvide();
  var websocketProvide = WebSocketProvide();
  providers
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<WebSocketProvide>.value(websocketProvide));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mul',
      theme: ThemeData(
          primaryColor: AppColors.AppBarColor,
          cardColor: AppColors.AppBarColor),
      home: MainPage(),
    );
  }
}
