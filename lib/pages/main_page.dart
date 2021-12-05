import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        icon: const IconData(0xe608,
            fontFamily: Constants
                .IconFontFamily), //!flutter_weichat_clone每一个icon代码都是手工输入
        activeIcon:
            const IconData(0xe603, fontFamily: Constants.IconFontFamily)),
    NavigationIconView(
      title: '通讯录',
      icon: const IconData(0xe601, fontFamily: Constants.IconFontFamily),
      activeIcon: const IconData(0xe602, fontFamily: Constants.IconFontFamily),
    ),
    NavigationIconView(
      title: '发现',
      icon: const IconData(0xe600, fontFamily: Constants.IconFontFamily),
      activeIcon: const IconData(0xe604, fontFamily: Constants.IconFontFamily),
    ),
    NavigationIconView(
      title: '我',
      icon: const IconData(0xe607, fontFamily: Constants.IconFontFamily),
      activeIcon: const IconData(0xe630, fontFamily: Constants.IconFontFamily),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);

    _pages = [
      // MessagePage(),//带模拟数据
      ConversationPage(), //不带模拟数据
      ContactsPage(),
      DiscoverPage(),
      ProfilePage(),
    ];
  }

  _buildPopupMenuItem(Widget icon, String title) {
    return Row(
      children: <Widget>[
        icon,
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

    // ScreenUtil.instance = ScreenUtil(width: 750,height:1334)..init(context);//OIRIGIN 初始化屏幕分辨率
    //FIXME新版初始化,screenUtil,只有初始化后才能用.flutter_wechat_clone中并没有使用,未来研究去掉!主要在chat_dedail_page中使用了!
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(750, 1334),
        orientation: Orientation.portrait);

    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        elevation: 0.0, //不需要阴影
        actions: <Widget>[
          IconButton(
            icon: const Icon(
                IconData(0xe605, fontFamily: Constants.IconFontFamily)),
            onPressed: () {
              print('点击了搜索按钮');
            },
          ),
          Container(width: 16.0),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<ActionItems>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(
                      Icon(
                        const IconData(0xe606,
                            fontFamily: Constants.IconFontFamily),
                        size: 22.0,
                        color: AppColors.AppBarPopupMenuColor,
                      ),
                      "发起群聊"),
                  value: ActionItems.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(
                      Icon(
                        const IconData(0xe638,
                            fontFamily: Constants.IconFontFamily),
                        size: 22.0,
                        color: AppColors.AppBarPopupMenuColor,
                      ),
                      "添加朋友"),
                  value: ActionItems.ADD_FRIEND,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(
                      Icon(
                        const IconData(0xe79b,
                            fontFamily: Constants.IconFontFamily),
                        size: 22.0,
                        color: AppColors.AppBarPopupMenuColor,
                      ),
                      "扫一扫"),
                  value: ActionItems.QR_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(
                      Icon(
                        const IconData(0xe658,
                            fontFamily: Constants.IconFontFamily),
                        size: 22.0,
                        color: AppColors.AppBarPopupMenuColor,
                      ),
                      "收付款"),
                  value: ActionItems.PAYMENT,
                ),
              ];
            },
            icon: Icon(
              const IconData(0xe66b, fontFamily: Constants.IconFontFamily),
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
