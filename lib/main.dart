// ignore_for_file: unused_field

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/other_screens/splash_screen1.dart';
import 'package:krishivikas/Screens/other_screens/splash_screen2.dart';
import 'package:krishivikas/const/device_information.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/notification/notification.dart';
import 'controllers/providers.dart';
import 'controllers/update_token_controller.dart';
import 'language/languages_translate.dart';

late SharedPreferences preferences;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((message) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'notification',
        title: message.notification!.title,
        body: message.notification!.body,
      ),
    );
  });

  FirebaseMessaging.instance.getToken().then((value) {
    print('FCM token : ${value}');
  });

  // LocalServices.initalize();
  AwesomeNotifications().initialize(
      null, //Icon
      [
        //! initializing notification
        NotificationChannel(
          channelKey: '1',
          channelName: 'krishivikas',
          channelDescription: 'notification',
          ledColor: Colors.green,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        ),
        NotificationChannel(
          channelKey: 'notification',
          channelName: 'krishivikas',
          channelDescription: 'notification',
          ledColor: Colors.green,
          playSound: true,
          enableVibration: true,
          enableLights: true,
        )
      ]);

  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // await Upgrader.clearSavedSettings();

  await DefaultCacheManager().emptyCache();

  // dynamicLinkService = DynamicLinkService();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<CategoryProvider>.value(value: categoryProvider),
      ChangeNotifierProvider<AdsDataProvider>.value(value: adsDataProvider),
      ChangeNotifierProvider<TractorAdsDataProvider>.value(
          value: tractorAdsDataProvider),
    ], child: const MyApp()),
  );
}

// for background app notification
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Data from Notification ${message.data}");
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 0,
//       channelKey: 'notification',
//       title: message.notification!.title,
//       body: message.notification!.body,
//     ),
//   );

// await AwesomeNotifications().createNotificationFromJsonData(
//   message.data,
// );
// }

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? deviceTokenId;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};

  UpdateTokenController _updateTokenController = Get.put(
    UpdateTokenController(),
  );

  @override
  void initState() {
    getDeviceTokenId();
    super.initState();
    getDeviceApi();
  }

  getDeviceApi() async {
    await DeviceInfo.initPlatformState();
  }

  GlobalKey<NavigatorState> navigatorKey =
      GlobalKey(debugLabel: "Main Navigator");

  ///Get FCM Token
  getDeviceTokenId() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    final token = await fcm.getToken();
    SharedPreferencesFunctions().saveDeviceToken(
      token!,
    );

    print("token");
    print(token);

    ///Update FCM Token After App ReInstall/UnInstall.
    _updateTokenController.getTokenUpdate(
      token,
      token,
    );

    fcm.onTokenRefresh.listen(
      (newToken) {
        // Save newToken
        _updateTokenController.getTokenUpdate(
          newToken,
          newToken,
        );
        deviceTokenId = newToken;

        SharedPreferencesFunctions().saveDeviceToken(
          deviceTokenId!,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("hello");
      navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) => NotificationsPage(),
      ));
    });
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: (reciver) async {
      navigatorKey.currentState!.push(MaterialPageRoute(
        builder: (context) => NotificationsPage(),
      ));
      print('hello');
    });

    ///Screen potrait remove.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // dynamicLinkService.handleDynamicLinks(context);
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: "Krishi Vikas",
      debugShowCheckedModeBanner: false,
      translations: LanguagesTranslate(),
      locale: SharedPreferencesFunctions().getLanguage() == "Bengali"
          ? Locale('bd', 'BD')
          : SharedPreferencesFunctions().getLanguage() == "Hindi"
              ? Locale('hi', 'IN')
              : Locale('en', 'US'),
      home: FutureBuilder(
        future: AuthMethods().getCurrentUser(),
        builder: (context, AsyncSnapshot snapshot) {
          print("snapshot.data");
          print(snapshot.data);
          var CheckLog = snapshot.hasData;
          return CheckLog == true ? SplashScreen2() : SplashScreen1();
        },
      ),
    );
  }

  @override
  void dispose() {
    AwesomeNotifications().dispose();
    super.dispose();
  }
}
