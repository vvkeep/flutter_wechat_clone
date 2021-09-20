import 'package:flutter/material.dart';
import '../constants.dart';

enum Device { MAC, WIN } //平台

class Conversation {
  final String avatar;
  final String title;
  final Color titleColor;
  final String desc;
  final String updateAt;
  final bool isMute;
  int unreadMsgCount; //NOTE这2个不能用final,因为来了消息后要修改这2个参数
  //FIXME displayDot是对话若静音,则未读消息显示一个红点,这个属性可以不需要!我已经添加了此功能,将来删除
  bool displayDot; //NOTE这2个不能用final,因为来了消息后要修改这2个参数
  final int? groupId;
  final String? userId;
  final int type;

  Conversation(
      {required this.avatar,
      required this.title,
      this.titleColor: AppColors.TitleColor,
      required this.desc,
      required this.updateAt,
      this.isMute: false,
      this.unreadMsgCount: 0,
      this.displayDot: false,
      this.groupId, //!不能随便设置值,用空判断群聊否
      this.userId, //!不能随便设置值,用空判断个人聊天
      this.type: 2}); //!

  bool isAvatarFromNet() {
    //是否是网络图片
    if (this.avatar.indexOf('http') == 0 || this.avatar.indexOf('https') == 0) {
      return true;
    }
    return false;
  }
}

class ConversationPageData {
  const ConversationPageData({
    this.device,
    required this.conversations,
  });

  final Device? device; //平台
  final List<Conversation> conversations;

  static mock() {
    return ConversationPageData(
        device: Device.WIN, conversations: mockConversations);
  }

  static List<Conversation> mockConversations = [
    Conversation(
      avatar: 'assets/images/ic_file_transfer.png',
      title: '文件传输助手',
      desc: '',
      displayDot: true,
      updateAt: '19:56',
    ),
    Conversation(
      avatar: 'assets/images/ic_tx_news.png',
      title: '腾讯新闻',
      desc: '豪车与出租车刮擦 俩车主划拳定责',
      updateAt: '17:20',
    ),
    Conversation(
      avatar: 'assets/images/ic_wx_games.png',
      title: '微信游戏',
      titleColor: Color(0xff586b95),
      desc: '25元现金助力开学季！',
      updateAt: '17:12',
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      desc: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 5,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 3,
    ),
    Conversation(
      avatar: 'assets/images/ic_fengchao.png',
      title: '蜂巢智能柜',
      titleColor: Color(0xff586b95),
      desc: '喷一喷，竟比洗牙还神奇！5秒钟还你一个漂亮洁白的口腔。',
      updateAt: '17:12',
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      desc: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: false,
      unreadMsgCount: 99,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      desc: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 3,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 3,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      desc: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: false,
      unreadMsgCount: 0,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/men/10.jpg',
      title: '汤姆丁',
      desc: '今晚要一起去吃肯德基吗？',
      updateAt: '17:56',
      isMute: true,
      unreadMsgCount: 5,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/10.jpg',
      title: 'Tina Morgan',
      desc: '晚自习是什么来着？你知道吗，看到的话赶紧回复我',
      updateAt: '17:58',
      isMute: false,
      unreadMsgCount: 1,
    ),
    Conversation(
      avatar: 'https://randomuser.me/api/portraits/women/57.jpg',
      title: 'Lily',
      desc: '今天要去运动场锻炼吗？',
      updateAt: '昨天',
      isMute: true,
      unreadMsgCount: 10,
    ),
  ];
}
