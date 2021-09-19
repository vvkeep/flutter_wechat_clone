import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import '../model/conversation.dart';

//mac test
class WebSocketProvide with ChangeNotifier {
  var uid = '';
  var nickname = '';
  var users = [];
  var groups = [];
  var historyMessage = []; //接收到的所有的历史消息
  var messageList = []; //所有消息页面人员
  var currentMessageList = []; //选择进入详情页的消息历史记录
  var connecting = false; //websocket连接状态
  late IOWebSocketChannel channel;

  init() async {
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
    // channel = new IOWebSocketChannel.connect('ws://13.76.44.138:3001'); //microsoft

    // channel = new IOWebSocketChannel.connect(
    //     'ws://192.168.102.217:3001'); //office-lenovo

    // channel = new IOWebSocketChannel.connect('ws://192.168.73.128:3001');//office-ubuntu

    channel =
        new IOWebSocketChannel.connect('ws://192.168.1.251:3001'); //macbook

    var obj = {
      "uid": uid,
      "type": 1,
      "nickname": nickname,
      "msg": "",
      "bridge": [],
      "groupId": ""
    };
    String text = json.encode(obj).toString();
    channel.sink.add(text);
    //监听到服务器返回消息
    channel.stream.listen((data) => listenMessage(data),
        onError: onError, onDone: onDone); //!处理error和Done
  }

//监听消息
  listenMessage(data) {
    connecting = true;
    var obj = jsonDecode(data);
    print('接收到消息:$data');
    // 创建连接
    if (obj['type'] == 1) {
      // 获取聊天室的人员与群列表
      messageList = [];
      print(obj['msg']);
      users = obj['users'];
      groups = obj['groups'];
      for (var i = 0; i < groups.length; i++) {
        //!群?
        messageList.add(new Conversation(
            avatar: 'assets/images/ic_group_chat.png',
            title: groups[i]['name'],
            desc: '点击进入聊天',
            updateAt: obj['date'].substring(11, 16),
            unreadMsgCount: 0,
            displayDot: false,
            groupId: groups[i]['id'],
            type: 2));
      }
      for (var i = 0; i < users.length; i++) {
        //!用户?
        if (users[i]['uid'] != uid) {
          messageList.add(new Conversation(
              avatar: 'assets/images/ic_group_chat.png',
              title: users[i]['nickname'],
              desc: '点击进入聊天',
              updateAt: obj['date'].substring(11, 16),
              unreadMsgCount: 0,
              displayDot: false,
              userId: users[i]['uid'],
              type: 1));
        }
      }
    } else if (obj['type'] == 2) {
      //tpye2接收到消息
      historyMessage.add(obj); //[追加]所有消息
      print('historyMessage:$historyMessage');
      for (var i = 0; i < messageList.length; i++) {
        if (messageList[i].userId != null) {
          var count = 0; //!个人未读消息总数
          for (var r = 0; r < historyMessage.length; r++) {
            if (historyMessage[r]['status'] == 1 &&
                historyMessage[r]['bridge'].contains(messageList[i].userId) &&
                historyMessage[r]['uid'] != uid) {
              count++;
            }
          }
          if (count > 0) {
            // messageList[i].displayDot = true; //!origin
            // messageList[i].unreadMsgCount = count;//FIXME 报错
          }
        }
        if (messageList[i].groupId != null) {
          var count = 0; //!群未读消息总数
          for (var r = 0; r < historyMessage.length; r++) {
            if (historyMessage[r]['status'] == 1 &&
                historyMessage[r]['groupId'] == messageList[i].groupId &&
                historyMessage[r]['uid'] != uid) {
              count++;
            }
          }
          if (count > 0) {
            // messageList[i].displayDot = true;//FIXME
            // messageList[i].unreadMsgCount = count;//报错
          }
        }
      }
    }
    notifyListeners();
  }

  sendMessage(type, data, index) {
    //发送消息
    print(messageList[index].userId);
    print(messageList[index].groupId);
    var _bridge = [];
    if (messageList[index].userId != null) {
      _bridge
        ..add(messageList[index].userId) //FIXME origin是有的
        ..add(uid); //!
    }
    int? _groupId;
    if (messageList[index].groupId != null) {
      _groupId = messageList[index].groupId;
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
