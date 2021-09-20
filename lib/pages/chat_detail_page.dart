import 'package:flutter/material.dart';
import '../provide/websocket.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import './chat_detail/chat_content_view.dart';
import '../model/conversation.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ChatDetailPage extends StatefulWidget {
  int type;
  int index;
  ChatDetailPage(this.index, this.type);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(type, index);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late ScrollController _scrollController; //!
  bool hasText = false;
  int type;
  int index;
  late Conversation currentConversation; //!对话数据
  _ChatDetailPageState(this.type, this.index);
  var messageList = []; //消息

  final controller = TextEditingController(); //文本控制器
  void _handleSubmitted(String text) {
    if (controller.text.length > 0) {
      print('发送$text');
      if (type == 1) {
        Provider.of<WebSocketProvide>(context, listen: false)
            .sendMessage(2, text, index); //NOTE type2发送消息
      }
      setState(() {
        hasText = false;
        messageList.add({
          'type': 1,
          'text': text,
        });
      });
      controller.clear(); //清空输入框
      _jumpBottom();
    }
  }

  void _jumpBottom() {
    //滚动到底部
    _scrollController.animateTo(99999,
        curve: Curves.easeOut, duration: Duration(milliseconds: 200));
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController();
    // _jumpBottom();
  }

  @override
  Widget build(BuildContext context) {
    currentConversation = Provider.of<WebSocketProvide>(context, listen: false)
        .convesationList[index]; //!接收的服务器数据,当前对话

    return Scaffold(
      appBar: AppBar(
          centerTitle: false,
          title: Text(
            currentConversation.title, //标题
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30.0),
              color: Color(AppColors.APPBarTextColor),
            ),
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APPBarTextColor)),
          elevation: 0.0,
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          backgroundColor: Color(AppColors.PrimaryColor),
          actions: <Widget>[
            Container(
              child: IconButton(
                icon: Icon(
                  ICons.MENUS,
                  color: Color(AppColors.APPBarTextColor),
                ),
                onPressed: () {
                  print('点击了聊天信息界面');
                },
              ),
            ),
          ]),
      body: Container(
        color: Color(AppColors.ChatDetailBg),
        child: Column(
          children: <Widget>[
            Consumer<WebSocketProvide>(builder: (context, val, child) {
              //!
              List<Map<String, Object>> list = [];
              if (type == 1) {
                messageList = [];
                var historyMessage =
                    Provider.of<WebSocketProvide>(context).historyMessage;
                for (var i = 0; i < historyMessage.length; i++) {
                  // ignore: unnecessary_null_comparison
                  if (currentConversation.userId != null) {
                    if (historyMessage[i]['bridge']
                        .contains(currentConversation.userId)) {
                      if (historyMessage[i]['uid'] ==
                          currentConversation.userId) {
                        list.add({
                          'type': 0,
                          'text': historyMessage[i]['msg'],
                          'nickname': historyMessage[i]['nickname']
                        });
                      } else {
                        list.add({
                          'type': 1,
                          'text': historyMessage[i]['msg'],
                          'nickname': historyMessage[i]['nickname']
                        });
                      }
                    }
                    // ignore: unnecessary_null_comparison
                  } else if (currentConversation.groupId != null &&
                      currentConversation.groupId ==
                          historyMessage[i]['groupId'] &&
                      historyMessage[i]['bridge'].length == 0) {
                    var uid =
                        Provider.of<WebSocketProvide>(context, listen: false)
                            .uid; //!
                    if (historyMessage[i]['uid'] != uid) {
                      list.add({
                        'type': 0,
                        'text': historyMessage[i]['msg'],
                        'nickname': historyMessage[i]['nickname']
                      });
                    } else {
                      list.add({
                        'type': 1,
                        'text': historyMessage[i]['msg'],
                        'nickname': historyMessage[i]['nickname']
                      });
                    }
                  }
                }
              }
              return Expanded(
                  child: ListView.builder(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (type == 1) {
                    return ChatContentView(
                        type: list[index]['type'] as int, //!强制转换
                        text: list[index]['text'] as String, //!强制转换
                        avatar: list[index]['type'] == 0
                            ? currentConversation.avatar
                            : '',
                        isNetwork: list[index]['type'] == 0
                            ? currentConversation.isAvatarFromNet()
                            : false,
                        username: list[index]['nickname'] as String, //!强制转换
                        userType: currentConversation.type);
                  } else {
                    return ChatContentView(
                        type: messageList[index]['type'] as int, //!强制转换
                        text: messageList[index]['text'] as String, //!强制转换
                        avatar: messageList[index]['type'] == 0
                            ? currentConversation.avatar
                            : '',
                        isNetwork: messageList[index]['type'] == 0
                            ? currentConversation.isAvatarFromNet()
                            : false,
                        username: currentConversation.title,
                        userType: currentConversation.type);
                  }
                },
                itemCount: type == 1 ? list.length : messageList.length,
              ));
            }),
            Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(2.0),
                  bottom: ScreenUtil().setHeight(2.0),
                  left: 0,
                  right: 0),
              color: Color(0xFFF7F7F7),
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                    child: IconButton(
                        icon: Icon(ICons.VOICE),
                        onPressed: () {
                          print('切换到语音');
                        }),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(15.0),
                        bottom: ScreenUtil().setHeight(15.0)),
                    height: ScreenUtil().setHeight(60.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        color: Colors.white),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration.collapsed(hintText: null),
                      maxLines: 1,
                      autocorrect: true,
                      autofocus: false,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.green,
                      onChanged: (text) {
                        setState(() {
                          hasText = text.length > 0 ? true : false;
                        });
                        print('change========= $text');
                      },
                      onSubmitted: _handleSubmitted,
                      enabled: true, //是否禁用
                    ),
                  )),
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    child: IconButton(
                        icon: Icon(ICons.FACES), //发送按钮图标
                        onPressed: () {
                          print('打开表情面板');
                        }),
                  ),
                  Container(
                    width: ScreenUtil().setWidth(60.0),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20.0)),
                    child: IconButton(
                        //发送按钮或者+按钮
                        icon: hasText
                            ? Icon(Icons.send)
                            : Icon(ICons.ADD), //发送按钮图标
                        onPressed: () {
                          if (!hasText) {
                            print('打开功能面板');
                          } else {
                            _handleSubmitted(controller.text);
                          }
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
