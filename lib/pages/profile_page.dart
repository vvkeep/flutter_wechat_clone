import 'package:flutter/material.dart';
import 'full_width_button.dart';
import '../constants.dart' show AppColors, Constants, AppStyles;
import 'package:cached_network_image/cached_network_image.dart';

class _ProfileHeaderView extends StatelessWidget {
  static const HORIZONTAL_PADDING= 20.0;
  static const VERTICAL_PADDING = 13.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: VERTICAL_PADDING, horizontal: HORIZONTAL_PADDING),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: 'https://randomuser.me/api/portraits/men/10.jpg',
            placeholder: Constants.ProfileAvatarDefaultIocn,
            width: Constants.ProfileHeaderIconSize,
            height: Constants.ProfileHeaderIconSize,
          ),
          SizedBox(width: 10.0),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('David', style: TextStyle(
                color: Color(AppColors.TitleColor),
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                )
              ),
              SizedBox(height: 10.0),
              Text('微信号: xxx123xxx', style: TextStyle(
                  color: Color(AppColors.DescTextColor),
                  fontSize: 13.0,
                 )
                )
            ],
          ),),
          Icon(
            IconData(
              0xe620,
              fontFamily: Constants.IconFontFamily,
            ),
            size: 22.0, 
            color: Color(AppColors.TabIconNormal),
          ),
          SizedBox(width: 5.0),
          Icon(
            IconData(
              0xe664,
              fontFamily: Constants.IconFontFamily,
            ),
            size: 22.0, 
            color: Color(AppColors.TabIconNormal),
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
      color: Color(AppColors.BackgroundColor),
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