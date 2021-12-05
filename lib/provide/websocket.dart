import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../model/conversation.dart';

//匹配go服务器版本!
class WebSocketProvide with ChangeNotifier {
  var uid = '';
  var nickname = '';
  var users = [];
  var groups = [];
  var historyMessage = []; //接收到的所有的历史消息
  var convesationList =
      <Conversation>[]; //!所有消息页面-对话列表,原命名是messageList容易和detail中消息混淆
  // var currentMessageList = []; //选择进入详情页的消息历史记录,origin没有用到
  var connecting = false; //websocket连接状态
  late IOWebSocketChannel channel;

  // Device? device; //null不显示平台
  Device? device = Device.MAC; //平台

  //设置某一个对话读过了.用以清楚角标
  markRead(int index) {
    convesationList[index].unreadMsgCount = 0;
    notifyListeners();
  }

  init() async {
    // 读取本地存储的用户信息
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('userInfo');
    print('UserInfo:$userInfo');
    if (userInfo == null) {
      //弹出设置用户名
      var now = new DateTime.now();
      print(now.millisecondsSinceEpoch); //单位毫秒，13位时间戳
      print(now.microsecondsSinceEpoch); //单位微秒,16位时间戳
      uid = "flutter_${now.microsecondsSinceEpoch}";
      nickname = "flutter_${Random().nextInt(100)}";
      var userInfoData = {"uid": uid, "nickname": nickname};
      var userInfoStr = json.encode(userInfoData).toString();
      prefs.setString('userInfo', userInfoStr);
    } else {
      var userInfoData = json.decode(userInfo.toString());
      uid = userInfoData['uid'];
      nickname = userInfoData['nickname'];
    }
    return await createWebsocket();
    // monitorMessage();
  }

  createWebsocket() async {
    //创建连接并且发送鉴别身份信息
    channel =
        new IOWebSocketChannel.connect('ws://13.76.44.138:3001'); //microsoft

    // channel = new IOWebSocketChannel.connect(
    //     'ws://192.168.102.217:3001'); //office-lenovo

    // channel = new IOWebSocketChannel.connect('ws://192.168.73.128:3001');//office-ubuntu

    // channel =
    //     new IOWebSocketChannel.connect('ws://192.168.1.251:3001'); //macbook

    var obj = {
      "uid": uid,
      "type": 1,
      "nickname": nickname,
      "msg": "",
      "bridge": [],
      "groupId": ""
    };
    String text = json.encode(obj).toString();
    channel.sink.add(text); //发送消息
    //监听到服务器返回消息
    channel.stream.listen((data) => listenMessage(data),
        onError: onError, onDone: onDone); //!处理error和Done
  }

//监听消息
  listenMessage(data) {
    connecting = true;
    //接收到的消息msg,orgin obj
    var msg = jsonDecode(data);
    print('接收到消息:$data');
    // NOTE:创建连接,type=1,系统消息
    if (msg['type'] == 1) {
      // 获取聊天室的人员与群列表
      convesationList = [];
      print(msg['msg']);
      users = msg['users'];
      groups = msg['groups'];
      for (var i = 0; i < groups.length; i++) {
        //!群,需要升级判断模式
        convesationList.add(new Conversation(
            avatar: 'assets/images/ic_group_chat.png',
            title: groups[i]['name'],
            desc: '点击进入聊天',
            updateAt: msg['date'].substring(11, 16),
            unreadMsgCount: 0,
            displayDot: false,
            groupId: groups[i]['id'],
            type: 2));
      }
      for (var i = 0; i < users.length; i++) {
        //!用户,需要升级判断模式
        if (users[i]['uid'] != uid) {
          convesationList.add(new Conversation(
              avatar: 'assets/images/ic_group_chat.png',
              title: users[i]['nickname'],
              desc: '点击进入聊天',
              updateAt: msg['date'].substring(11, 16),
              unreadMsgCount: 0,
              displayDot: false,
              userId: users[i]['uid'],
              type: 1));
        }
      }
    } else if (msg['type'] == 2) {
      //NOTE tpye2接收到用户消息
      historyMessage.add(msg); //[追加]所有消息
      print('historyMessage:$historyMessage');
      for (var i = 0; i < convesationList.length; i++) {
        //判断个人聊天
        if (convesationList[i].userId != null) {
          var count = convesationList[i].unreadMsgCount; //!个人未读消息总数
          for (var r = 0; r < historyMessage.length; r++) {
            if (historyMessage[r]['status'] == 1 && //新消息
                historyMessage[r]['bridge']
                    .contains(convesationList[i].userId) &&
                historyMessage[r]['uid'] != uid) {
              count++;
              historyMessage[r]['status'] = 0; //设置读过了
            }
          }
          print('person msg count:$count');
          if (count > 0) {
            convesationList[i].displayDot = true; //没用
            convesationList[i].unreadMsgCount = count;
          }
        }
        //FIXME 群里消息和个人要分开
        if (convesationList[i].groupId != null) {
          //判断群聊天
          var count = convesationList[i].unreadMsgCount; //!群未读消息总数
          for (var r = 0; r < historyMessage.length; r++) {
            if (historyMessage[r]['status'] == 1 && //新消息
                historyMessage[r]['groupId'] == convesationList[i].groupId &&
                historyMessage[r]['uid'] != uid) {
              count++;
              historyMessage[r]['status'] = 0; //设置读过了

            }
          }
          print('group msg count:$count');

          if (count > 0) {
            convesationList[i].displayDot = true; //没用
            convesationList[i].unreadMsgCount = count;
          }
        }
      }
    }
    notifyListeners();
  }

  sendMessage(type, data, index) {
    //发送消息
    print(convesationList[index].userId);
    print(convesationList[index].groupId);
    var _bridge = [];
    if (convesationList[index].userId != null) {
      //NOTE 空是群聊,非空是点对点,需要改进
      _bridge
        ..add(convesationList[index].userId)
        ..add(uid); //!
    }
    int? _groupId;
    if (convesationList[index].groupId != null) {
      _groupId = convesationList[index].groupId;
    }
    print(_bridge);
    var obj = {
      "uid": uid,
      "type": type, //!origin为2
      "nickname": nickname,
      "msg": data,
      "bridge": _bridge,
      "groupId": _groupId
    };
    String text = json.encode(obj).toString();
    print('sendmessage:$text');
    channel.sink.add(text);
  }

  onError(error) {
    print('sendMessage error->$error');
  }

  void onDone() {
    print('websocket断开了');
    createWebsocket();
    Timer(Duration(seconds: 20), () {}); //!停10秒
    print('websocket重连');
  }

  closeWebSocket() {
    //关闭链接
    channel.sink.close();
    print('关闭了websocket');
    notifyListeners();
  }
}
