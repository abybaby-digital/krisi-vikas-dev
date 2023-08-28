import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class firebaseMessagingService extends StatefulWidget {
  const firebaseMessagingService({Key? key}) : super(key: key);

  @override
  State<firebaseMessagingService> createState() =>
      _firebaseMessagingServiceState();
}

class _firebaseMessagingServiceState extends State<firebaseMessagingService> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getCall();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<void> getCall() async {
    // ignore: unused_local_variable
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {}
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

  ///Push Message
  Future<void> sendPushMessage(String token, String body, String title) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAggkuf0U:APA91bFBX11jYY_-0wGkxNL1D1CDlsFStOwl_1XP6W9P7nGzGKCvQPuiw7gYxJTGIl979OnB7puZ8msM4pPz7TslSjZysTyG0pZwTWH8PhriZO3sGt-a8u5UFiNJfyRh2M1h0f05jZl4',
              
        },
        // headers: <String, String>{
        //   'Content-Type': 'application/json',
        //   'Authorization':
        //       'key=AAAA9xPglTQ:r7szE0vgTGk54oHbl6APbI31j0Zi4AL2LO53PNYWcb2W5Zh294WR3AUFfdBlqOtGErXlgCTmHyq6aoXab29t760ZMnP0K47P0iAi',
              
        // }, old 13-01-2023
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{'body': body, 'title': title},
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
    } catch (e) {
      print("error push notification");
    }
  }
}
