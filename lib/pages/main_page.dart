import 'package:flutter/material.dart';

import '../constants.dart';
import 'contacts_page.dart';
import 'conversation_page.dart';
import 'profile_page.dart';
import 'discover_page.dart';

//SECTION 主控:对应flutter_wechat  index_page.dart
enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT }

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView(
      {required String title,
      required IconData icon,
      required IconData activeIcon})
      : item = new BottomNavigationBarItem(
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
      MessagePage(),
      // ConversationPage(),//!origin
      ContactsPage(),
      DiscoverPage(),
      ProfilePage(),
    ];
  }

  _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Icon(
          IconData(iconName, fontFamily: Constants.IconFontFamily),
          size: 22.0,
          color: AppColors.AppBarPopupMenuColor,
        ),
        Container(width: 12.0),
        Text(
          title,
          style: TextStyle(color: AppColors.AppBarPopupMenuColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _navigationViews.map((NavigationIconView view) {
        return view.item;
      }).toList(),
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: AppColors.TabIconActive,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          _pageController.jumpToPage(_currentIndex);
          // _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        elevation: 0.0, //不需要阴影
        actions: <Widget>[
          IconButton(
            icon: Icon(IconData(0xe605, fontFamily: Constants.IconFontFamily)),
            onPressed: () {
              print('点击了搜索按钮');
            },
          ),
          Container(width: 16.0),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe606, "发起群聊"),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe638, "添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe79b, "扫一扫"),
                  value: ActionItems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe658, "收付款"),
                  value: ActionItems.PAYMENT,
                ),
              ];
            },
            icon: Icon(
              IconData(0xe66b, fontFamily: Constants.IconFontFamily),
              size: 22.0,
            ),
            onSelected: (ActionItems selected) {
              print('点击的是$selected');
            },
          ),
          Container(width: 16.0)
        ],
      ),
      body: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: _pages.length,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: botNavBar,
    );
  }
}
