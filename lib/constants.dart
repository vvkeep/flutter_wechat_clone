import 'package:flutter/material.dart';

class AppColors {
  static const BackgroundColor = Color(0xffebebeb);
  static const AppBarColor = Color(0xff303030);
  static const TabIconNormal = Color(0xff999999);
  static const TabIconActive = Color(0xff46c11b);
  static const AppBarPopupMenuColor = Color(0xffffffff);
  static const TitleColor = Color(0xff353535);
  static const ConversationItemBgColor = Color(0xffffffff);
  static const DescTextColor = Color(0xff9e9e9e);
  static const DividerColor = Color(0xffd9d9d9);
  static const NotifyDotBgColor = Color(0xffff3e3e);
  static const NotifyDotText = Color(0xffffffff);
  static const ConversationMuteIconColor = Color(0xffd8d8d8);
  static const DeviceInfoItemBgColor = Color(0xfff5f5f5);
  static const DeviceInfoItemTextColor = Color(0xff606062);
  static const DeviceInfoItemIconColor = Color(0xff606062);
  static const ContactGroupTitleBgColor = Color(0xffebebeb);
  static const ContactGroupTitleColor = Color(0xff888888);
  static const IndexLetterBoxBgColor = Colors.black45;
}

class AppStyles {
  static const TitleStyle = TextStyle(
    fontSize: 14.0,
    color: AppColors.TitleColor,
  );

  static const DescStyle = TextStyle(
    fontSize: 12.0,
    color: AppColors.DescTextColor,
  );

  static const UnreadMsgCountDotStyle = TextStyle(
    fontSize: 12.0,
    color: AppColors.NotifyDotText,
  );

  static const DeviceInfoItemTextStyle = TextStyle(
    fontSize: 13.0,
    color: AppColors.DeviceInfoItemTextColor,
  );

  static const GroupTitleItemTextStyle = TextStyle(
    fontSize: 14.0,
    color: AppColors.ContactGroupTitleColor,
  );

  static const IndexLetterBoxTextStyle = TextStyle(
    fontSize: 64.0,
    color: Colors.white,
  );
}

class Constants {
  static const IconFontFamily = "appIconFont";
  static const ConversationAvatarSize = 48.0;
  static const DividerWidth = 0.5;
  static const UnReadMsgNotifyDotSize = 20.0;
  static const ConversationMuteIcon = 18.0;
  static const ContactAvatarSize = 36.0;
  static const IndexBarWidth = 24.0;
  static const IndexLetterBoxSize = 114.0;
  static const IndexLetterBoxRadius = 4.0;
  static const FullWidthIconButtonIconSize = 24.0;
  static const ProfileHeaderIconSize = 60.0;

  static const ConversationAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ConversationAvatarSize,
  );

  static const ContactAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ContactAvatarSize,
  );

  static const ProfileAvatarDefaultIocn = Icon(
    IconData(
      0xe642,
      fontFamily: IconFontFamily,
    ),
    size: ProfileHeaderIconSize,
  );
}



