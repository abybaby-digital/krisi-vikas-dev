import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/local_services.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:intl/intl.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class IndividualChatScreen extends StatefulWidget {
  final otherUserPhoneNumber;
  final otherUserDeviceTokenId;
  final Map<String, dynamic>? chatRoomInfoMap;

  IndividualChatScreen({
    this.otherUserPhoneNumber,
    this.otherUserDeviceTokenId,
    this.chatRoomInfoMap,
  });

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  String deviceTokenToSendPushNotification = '';

  String messageId = "";

  String chatRoomId = "";

  var messageStream;

  bool isUserExist = false;

  var chatRoomStream;

  TextEditingController messageController = TextEditingController();

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (int.parse(a) > int.parse(b)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getMyInfo() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();

    await SharedPreferencesFunctions().getDeviceToken();

    chatRoomId = getChatRoomIdByPhoneNumbers(
      SharedPreferencesFunctions.phoneNumber.toString(),
      widget.otherUserPhoneNumber,
    );
  }

  getAndSetMessages() async {
    messageStream = await FirebaseMethods().getMessages(chatRoomId);
  }

  doThisOnLaunch() async {
    await getMyInfo();
    getAndSetMessages();
    setState(() {});
  }

  @override
  void initState() {
    doThisOnLaunch();
    firebaseGetToken();
    firebaseMessages();
    super.initState();
  }

  Future<void> firebaseGetToken() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
  }

  firebaseMessages() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (value) {
        if (value != null) {}
      },
    );

    FirebaseMessaging.onMessage.listen(
      (event) {
        if (event.notification != null) {
          LocalServices.createAndDisplayNotification(event);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {},
    );
  }

  onSendClick(bool send) async {
    if (messageController.text != "") {
      LocalServices().sendPushMessage(
        token: widget.otherUserDeviceTokenId,
        title: SharedPreferencesFunctions.phoneNumber.toString(),
        body: messageController.text,
      );

      String date = DateFormat("dd/MM/yyyy ").format(DateTime.now());
      String time = DateFormat('hh:mm a').format(DateTime.now());

      Map<String, dynamic> messageInfoMap = {
        "message": messageController.text,
        "sendBy": SharedPreferencesFunctions.phoneNumber.toString(),
        "date": date,
        "time": time,
        "ts": DateTime.now(),
      };
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": messageController.text,
        "lastMessageSendBy": SharedPreferencesFunctions.phoneNumber.toString(),
        "lastMessageTs": DateTime.now(),
        "lastMessageTime": time,
        "lastMessageDate": date,
      };

      if (messageId == "") {
        messageId = getRandomString(12);
      }

      FirebaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        FirebaseMethods().lastMessageUpdate(chatRoomId, lastMessageInfoMap,
            widget.chatRoomInfoMap, widget.otherUserDeviceTokenId);
      });
      if (send) {
        messageController.text = "";
        messageId = "";
        setState(() {});
      }
    }
  }

  Widget ChatListTile(ds) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
            ? const EdgeInsets.only(top: 3, bottom: 3, left: 50, right: 8)
            : const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 50),
        decoration: BoxDecoration(
          color: ds["sendBy"] == SharedPreferencesFunctions.phoneNumber
              ? Colors.cyan[300]
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 70.0, bottom: 12, left: 12, top: 12),
              child: barlowRegular(
                text: ds["message"],
                color: black,
                size: 16,
              ),
            ),
            Positioned(
                bottom: 7,
                right: 20,
                child: barlowRegular(text: ds["time"], color: black, size: 11)),
          ],
        ),
      ),
    );
  }

  Widget AllChats() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? snapshot.data!.docs.length == 0
                ? Center(
                    child: barlowBold(
                      text: noChatShow.tr,
                      size: 15,
                      color: grey,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 10, bottom: 65),
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot ds = snapshot.data!.docs[index];
                      return ChatListTile(ds);
                    },
                  )
            : Center(
                child: progressIndicator(context),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkgreen,
          title: barlowBold(
            text: widget.otherUserPhoneNumber,
            color: white,
            size: 20,
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              AllChats(),
              Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              onChanged: (value) {},
                              minLines: 1,
                              maxLines: 3,
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: enterMessage.tr,
                                hintStyle: TextStyle(
                                  fontFamily: "barlow",
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: darkgreen,
                        child: IconButton(
                          onPressed: () {
                            onSendClick(true);
                          },
                          icon: Icon(
                            Icons.send,
                            color: white,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
