import 'package:flutter/material.dart';
import 'package:flutter_wechat_clone/provide/websocket.dart';
import 'package:provider/provider.dart';
import 'package:flutter_wechat_clone/constants.dart';
import 'package:flutter_wechat_clone/pages/main_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WebSocketProvide()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mul', //mac test
      theme: ThemeData(
          primaryColor: AppColors.AppBarColor,
          cardColor: AppColors.AppBarColor),
      home: MainPage(),
    );
  }
}
