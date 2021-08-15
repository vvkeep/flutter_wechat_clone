import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../model/conversation.dart';
import 'package:cached_network_image/cached_network_image.dart';

class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
    : assert(conversation != null),
    super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (conversation.isAvatarFromNet()) {
      avatar = CachedNetworkImage(
        imageUrl: conversation.avatar,
        placeholder: Constants.ConversationAvatarDefaultIocn,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    }

    Widget avatarContainer; 
    if(conversation.unreadMsgCount > 0){
    // 未读消息角标
        Widget unreadMsgCountText = Container(
          width: Constants.UnReadMsgNotifyDotSize,
          height: Constants.UnReadMsgNotifyDotSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2.0),
            color: Color(AppColors.NotifyDotBgColor),
          ),
          child: Text(conversation.unreadMsgCount.toString(), style: AppStyles.UnreadMsgCountDotStyle),
        );

        avatarContainer = Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            avatar,
            Positioned(
              right: -6.0,
              top: -6.0,
              child: unreadMsgCountText,
            )
          ],
        );
    }else {
      avatarContainer = avatar;
    }

    Color muteIconColor; 
    if (conversation.isMute) {
      muteIconColor = Color(AppColors.ConversationMuteIconColor);
    } else {
       muteIconColor = Colors.transparent;
    }

    //勿扰模式图标
    Widget muteContainer = Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Icon(
            IconData(
              0xe78b,
              fontFamily: Constants.IconFontFamily,
            ),
            color: muteIconColor,
            size: Constants.ConversationMuteIcon,
          ),
      );

    var _rightArea = <Widget>[Text(conversation.updateAt, style: AppStyles.DescStyle), muteContainer];
   

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(AppColors.ConversationItemBgColor),
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor), 
            width: Constants.DividerWidth)
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,
          Container(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(conversation.title, style:AppStyles.TitleStyle),
                Text(conversation.desc, style: AppStyles.DescStyle)
              ],
            ),
          ),
          Container(width: 10.0),
          Column(
            children: _rightArea,
          )
        ],
      ),
    );
  }
}

class _DeviceInfoItem extends StatelessWidget {
  const _DeviceInfoItem({ this.device });
  final Device device;

  int get iconName {
    return device == Device.WIN ? 0xe72a : 0xe640;
  }

  String get deviceName {
    return device == Device.WIN ? "Windows" : "Mac";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24.0, top: 10.0, right: 24.0, bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: Constants.DividerWidth, 
            color: Color(AppColors.DividerColor
              ),
            ),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(
            this.iconName,
            fontFamily: Constants.IconFontFamily
            ),
           size: 24.0,
           color: Color(AppColors.DeviceInfoItemIconColor),
          ),
          SizedBox(width: 16.0),
          Text('$deviceName 微信已登录，手机通知已关闭。', style: AppStyles.DeviceInfoItemTextStyle)
        ],
      ),
    );
  }
}

 class ConversationPage extends StatefulWidget {
   @override
   _ConversationPageState createState() => _ConversationPageState();
 }
 
 class _ConversationPageState extends State<ConversationPage> {
   final ConversationPageData data = ConversationPageData.mock();
   @override
   Widget build(BuildContext context) {
     return ListView.builder(
       itemBuilder: (BuildContext context, int index) {
         if (data.device != null) {
            //需要显示其他设备的登录信息
          if (index == 0) {
            return _DeviceInfoItem(device: data.device);
          }
          return _ConversationItem(conversation: data.conversations[index-1]);
         }else {
          return _ConversationItem(conversation: data.conversations[index]);
         }
       },
       itemCount: data.device != null ? data.conversations.length + 1 : data.conversations.length,
     );
   }
 }