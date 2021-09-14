import 'package:flutter/material.dart';
import '../widgets/full_width_button.dart';
import '../constants.dart' show AppColors, Constants;
import 'package:cached_network_image/cached_network_image.dart';

//SECTION 我:对应:flutter_wechat mine_page.dart
class _ProfileHeaderView extends StatelessWidget {
  static const HORIZONTAL_PADDING = 20.0;
  static const VERTICAL_PADDING = 13.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          vertical: VERTICAL_PADDING, horizontal: HORIZONTAL_PADDING),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://z3.ax1x.com/2021/08/18/fom6ED.jpg',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, msg) => Constants.ProfileAvatarDefaultIocn,
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: Constants.ProfileHeaderIconSize,
            height: Constants.ProfileHeaderIconSize,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('码农 Super V',
                    style: TextStyle(
                      color: AppColors.TitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 10.0),
                Text('微信号: xxx123xxx',
                    style: TextStyle(
                      color: AppColors.DescTextColor,
                      fontSize: 13.0,
                    ))
              ],
            ),
          ),
          Icon(
            IconData(
              0xe620,
              fontFamily: Constants.IconFontFamily,
            ),
            size: 22.0,
            color: AppColors.TabIconNormal,
          ),
          SizedBox(width: 5.0),
          Icon(
            IconData(
              0xe664,
              fontFamily: Constants.IconFontFamily,
            ),
            size: 22.0,
            color: AppColors.TabIconNormal,
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const SEPARATE_SIZE = 20.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.BackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: SEPARATE_SIZE),
            _ProfileHeaderView(),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_wallet.png',
              title: '钱包',
              showDivider: true,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_collections.png',
              title: '收藏',
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_album.png',
              title: '相册',
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_cards_wallet.png',
              title: '卡包',
              showDivider: true,
              onPressed: () {},
            ),
            FullWidthButton(
              iconPath: 'assets/images/ic_emotions.png',
              title: '表情',
              showDivider: true,
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            FullWidthButton(
              iconPath: 'assets/images/ic_settings.png',
              title: '设置',
              showDivider: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
