import 'package:flutter/material.dart';

class AppColors {
  static const APPBarTextColor = 0xff010101;
  static const PrimaryColor = 0xffebebeb;
  static const ChatTime = 0xffababab;
  static const TextBobule = 0xff3e3e3e;
  static const TextBobuleRight = 0xff9def71;
  static const TextBobuleLeft = 0xffffffff;
  static const ChatDetailBg = 0xffefefef;

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

class ICons {
  static const String FONT_FAMILY = 'wxIconFont';

  static const IconData MESSAGE =
      const IconData(0xe622, fontFamily: ICons.FONT_FAMILY);

  static const IconData ADDRESSLIST =
      const IconData(0xe648, fontFamily: ICons.FONT_FAMILY);

  static const IconData DISCOVER =
      const IconData(0xe613, fontFamily: ICons.FONT_FAMILY);

  static const IconData MINE =
      const IconData(0xe670, fontFamily: ICons.FONT_FAMILY);

  static const IconData MESSAGE_ACTIVE =
      const IconData(0xe620, fontFamily: ICons.FONT_FAMILY);

  static const IconData ADDRESSLIST_ACTIVE =
      const IconData(0xe603, fontFamily: ICons.FONT_FAMILY);

  static const IconData DISCOVER_ACTIVE =
      const IconData(0xe600, fontFamily: ICons.FONT_FAMILY);

  static const IconData MINE_ACTIVE =
      const IconData(0xe601, fontFamily: ICons.FONT_FAMILY);

  static const IconData QR_SCAN =
      const IconData(0xe634, fontFamily: ICons.FONT_FAMILY);

  static const IconData GROUP_CHAT =
      const IconData(0xe620, fontFamily: ICons.FONT_FAMILY);

  static const IconData ADD_FRIEND =
      const IconData(0xe624, fontFamily: ICons.FONT_FAMILY);

  static const IconData PAYMENT =
      const IconData(0xe602, fontFamily: ICons.FONT_FAMILY);

  static const IconData HELP =
      const IconData(0xe63b, fontFamily: ICons.FONT_FAMILY);

  static const IconData MUTE_ICON =
      const IconData(0xe75e, fontFamily: ICons.FONT_FAMILY);

  static const IconData MAC =
      const IconData(0xe673, fontFamily: ICons.FONT_FAMILY);

  static const IconData WINDOWS =
      const IconData(0xe64f, fontFamily: ICons.FONT_FAMILY);

  static const IconData SEARCH =
      const IconData(0xe63e, fontFamily: ICons.FONT_FAMILY);

  static const IconData ADD =
      const IconData(0xe6d3, fontFamily: ICons.FONT_FAMILY);

  static const IconData ER_CODE =
      const IconData(0xe646, fontFamily: ICons.FONT_FAMILY);

  static const IconData RIGHT =
      const IconData(0xe60b, fontFamily: ICons.FONT_FAMILY);

  static const IconData MENUS =
      const IconData(0xe60e, fontFamily: ICons.FONT_FAMILY);

  static const IconData FACES =
      const IconData(0xe88f, fontFamily: ICons.FONT_FAMILY);

  static const IconData VOICE =
      const IconData(0xe606, fontFamily: ICons.FONT_FAMILY);
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
  static const String MENU_MARK_AS_UNREAD = 'MENU_MARK_AS_UNREAD';
  static const String MENU_MARK_AS_UNREAD_VALUE = '标为未读';
  static const String MENU_PIN_TO_TOP = 'MENU_PIN_TO_TOP';
  static const String MENU_PIN_TO_TOP_VALUE = '置顶聊天';
  static const String MENU_DELETE_CONVERSATION = 'MENU_DELETE_CONVERSATION';
  static const String MENU_DELETE_CONVERSATION_VALUE = '删除该聊天';
  static const String MENU_PIN_PA_TO_TOP = 'MENU_PIN_PA_TO_TOP';
  static const String MENU_PIN_PA_TO_TOP_VALUE = '置顶公众号';
  static const String MENU_UNSUBSCRIBE = 'MENU_UNSUBSCRIBE';
  static const String MENU_UNSUBSCRIBE_VALUE = '取消关注';

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

class MessageDetailSelects {
  static const String MENU_COPY = 'MENU_COPY';
  static const String MENU_COPY_VALUE = '复制';
  static const String MENU_SHARE_FRIENDS = 'MENU_SHARE_FRIENDS';
  static const String MENU_SHARE_FRIENDS_VALUE = '发送给朋友';
  static const String MENU_FAVORIITE = 'MENU_MENU_FAVORIITE';
  static const String MENU_FAVORIITE_VALUE = '收藏';
  static const String MENU_REMIND = 'MENU_REMIND';
  static const String MENU_REMIND_VALUE = '提醒';
  static const String MENU_TRANSLATE = 'MENU_TRANSLATE';
  static const String MENU_TRANSLATE_VALUE = '翻译';
  static const String MENU_DELATE = 'MENU_DELATE';
  static const String MENU_DELATE_VALUE = '删除';
  static const String MENU_MULTIPE_CHOICE = 'MENU_MULTIPE_CHOICE';
  static const String MENU_MULTIPE_CHOICE_VALUE = '多选';
}
