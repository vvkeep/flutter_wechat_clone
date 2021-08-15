import 'package:flutter/material.dart';

import '../constants.dart';

enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT }

class NavigationIconView {
  final String _title;
  final IconData _icon;
  final IconData _activeIcon;
  final BottomNavigationBarItem item;

  NavigationIconView(
      {required String title,
      required IconData icon,
      required IconData activeIcon})
      : _title = title,
        _icon = icon,
        _activeIcon = activeIcon,
        item = new BottomNavigationBarItem(
            icon: Icon(icon),
            activeIcon: Icon(activeIcon),
            label: title,
            backgroundColor: Colors.white);
}

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late PageController _pageController;
  late List<Widget> _pages;
  List<NavigationIconView> _navigationViews = [
    NavigationIconView(
        title: '微信',
        icon: IconData(0xe608, fontFamily: Constants.IconFontFamily),
        activeIcon: IconData(0xe603, fontFamily: Constants.IconFontFamily)),
    NavigationIconView(
      title: '通讯录',
      icon: IconData(0xe601, fontFamily: Constants.IconFontFamily),
      activeIcon: IconData(0xe602, fontFamily: Constants.IconFontFamily),
    ),
    NavigationIconView(
      title: '发现',
      icon: IconData(0xe600, fontFamily: Constants.IconFontFamily),
      activeIcon: IconData(0xe604, fontFamily: Constants.IconFontFamily),
    ),
    NavigationIconView(
      title: '我',
      icon: IconData(0xe607, fontFamily: Constants.IconFontFamily),
      activeIcon: IconData(0xe630, fontFamily: Constants.IconFontFamily),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _pages = [
      ConversationPage(),
      ContactsPage(),
      DiscoverPage(),
      ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
