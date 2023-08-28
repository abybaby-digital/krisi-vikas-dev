import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:krishivikas/main.dart';
import '../../const/api_urls.dart';
import '../../const/colors.dart';
import '../../language/language_key.dart';
import '../../services/save_user_info.dart';
import '../../widgets/all_widgets.dart';
import 'notificationModal/notification_modal.dart';

const String notificationData = 'notificationData';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);
  static const route = '/notification-screen';

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isDataObtained = true;
  List<NotificationList> listData = [];
  List<NotificationList> filterData = [];
  var lan;
  @override
  void initState() {
    super.initState();

    NotificationData();
  }

  @override
  void dispose() {
    super.dispose();
    var data = listData.map((e) => e.toJson()).toList();
    preferences.setString("$lan" + "_" + "$notificationData", jsonEncode(data));
  }

  markAsRead(NotificationList value) async {
    if (value.read) {
    } else {
      value.read = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    listData = filterData.isEmpty ? listData : listData;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkgreen,
          title: barlowBold(
            text: notifications.tr,
            color: white,
            size: 20,
          ),
        ),
        body: isDataObtained
            ? Center(
          child: progressIndicator(context),
        )
            : listData.isEmpty && listData.length == 0
            ? Center(
          child: barlowRegular(
            text: noDataFound.tr,
            size: 15,
            color: black,
          ),
        )
            : ListView.builder(
            padding: const EdgeInsets.symmetric(
                vertical: 15, horizontal: 10),
            itemCount: listData.length,
            itemBuilder: (context, index) {
              NotificationList ds = listData[index];
              List<String> time = ds.dateTime.split(" ");
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: InkWell(
                  onTap: () {
                    markAsRead(ds);
                    showGeneralDialog(
                      barrierLabel: '',
                      barrierColor: Colors.black38,
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (ctx, anim1, anim2) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 350,
                                child: StatefulBuilder(
                                  builder: (context, snapshot) {
                                    return Card(
                                      color: Colors.white,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .only(
                                                    bottom: 8.0),
                                                child: Image.asset(
                                                  "assets/cross.png",
                                                  width: 20,
                                                  height: 20,
                                                  fit: BoxFit.fill,
                                                  color: darkgreen,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Container(
                                                width: 350,
                                                child: Center(
                                                  child: Text(
                                                    ds.tiltle,
                                                    style: TextStyle(
                                                      color:
                                                      Colors.black,
                                                      fontWeight:
                                                      FontWeight
                                                          .bold,
                                                      fontSize: 22,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    softWrap: false,
                                                    maxLines: 5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(
                                                  8.0),
                                              child: Container(
                                                width: 350,
                                                child: Text(
                                                  ds.deception,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  softWrap: false,
                                                  maxLines: 20,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: CachedNetworkImage(
                                                imageUrl: ds.img,
                                                imageBuilder: (context,
                                                    imageProvider) =>
                                                    Container(
                                                      width: 300,
                                                      height: 150,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Colors.black,
                                                        image:
                                                        DecorationImage(
                                                          //image size fill
                                                          image:
                                                          imageProvider,
                                                          fit: BoxFit
                                                              .fitWidth,
                                                        ),
                                                      ),
                                                    ),
                                                placeholder:
                                                    (context, url) =>
                                                    Container(
                                                      alignment:
                                                      Alignment.center,
                                                      child: Text(
                                                        "Loading..",
                                                        style: TextStyle(
                                                            color:
                                                            darkgreen),
                                                      ), // you can add pre loader iamge as well to show loading.
                                                    ), //show progress  while loading image
                                                errorWidget: (context,
                                                    url, error) =>
                                                    Image.asset(
                                                        "images/flutter.png"),
                                                //show no image available image on error loading
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      transitionBuilder: (ctx, anim1, anim2, child) =>
                          BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 4 * anim1.value,
                                sigmaY: 4 * anim1.value),
                            child: FadeTransition(
                              child: child,
                              opacity: anim1,
                            ),
                          ),
                      context: context,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                      ds.read ? Colors.grey.shade400 : Colors.white,
                      border:
                      Border.all(color: Colors.grey, width: 1.0),
                      boxShadow: [
                        BoxShadow(
                          color: darkgreen,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(
                          5.0) //                 <--- border radius here
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Text(ds.tiltle,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Container(
                                      height: 30,
                                      child: Text(ds.deception,
                                          style: TextStyle(
                                              color: Colors.black,
                                              overflow: TextOverflow
                                                  .ellipsis))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    2.0),
                                                child: Icon(
                                                  Icons.calendar_month,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                                text: time[0],
                                                style: TextStyle(
                                                    color:
                                                    Colors.black)),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                    horizontal:
                                                    2.0),
                                                child: Icon(
                                                  Icons.timer,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                            TextSpan(
                                                text: time[1],
                                                style: TextStyle(
                                                    color:
                                                    Colors.black)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // notification.postImage != '' ?
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: ds.img,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image size fill
                                        image: imageProvider,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Loading..",
                                  style: TextStyle(color: darkgreen),
                                ), // you can add pre loader iamge as well to show loading.
                              ), //show progress  while loading image
                              errorWidget: (context, url, error) =>
                                  Image.asset("images/flutter.png"),
                              //show no image available image on error loading
                            ),
                          ),
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   child: ClipRRect(
                          //       child: Image.network(ds.img,fit: BoxFit.contain,),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  Future NotificationData() async {
    List<NotificationList> oldData = [];

    lan = await preferences.getString("LANGUAGE");

    var spdata = await jsonDecode(
        preferences.getString("$lan" + "_" + "$notificationData") ?? '[]');

    if (spdata.isNotEmpty) {
      oldData = List<NotificationList>.from(
          spdata.map((e) => NotificationList.fromJson(e)).toList());
      listData = List<NotificationList>.from(
          spdata.map((e) => NotificationList.fromJson(e)).toList());
    }

    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    var id = SharedPreferencesFunctions.userId!;
    var user_token = SharedPreferencesFunctions.token!;
    final Map<String, dynamic> data = {
      "user_id": id,
      "user_token": user_token,
    };
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
      Uri.parse(baseUrl + pushNotificationList),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*",
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: '*',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      final List<NotificationList> ListNotificationData =
      NotificationListModel.fromJson(responseData).data.toList();

      if (oldData.isEmpty) {
        listData = ListNotificationData;
        preferences.setString("$lan" + "_" + "$notificationData",
            jsonEncode(responseData['data']));
      } else {
        listData = oldData;

        for (var i = 0; i < ListNotificationData.length; i++) {
          for (var j = 0; j < listData.length; j++) {
            bool same = ListNotificationData[i].id == listData[j].id;
            if (same) {
              ListNotificationData[i] = listData[j];
            }
          }
        }
        preferences.setString("$lan" + "_" + "$notificationData",
            jsonEncode(ListNotificationData.map((e) => e.toJson()).toList()));

        listData = ListNotificationData;
      }

      isDataObtained = false;
    } else {
      isDataObtained = false;
      showSnackbar(context, "Something went wrong");
    }
    setState(() {});
  }
}
