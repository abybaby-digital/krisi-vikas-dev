// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:krishivikas/const/api_urls.dart';
// import 'package:krishivikas/const/colors.dart';
// import 'package:krishivikas/services/save_user_info.dart';
// import 'package:krishivikas/widgets/all_widgets.dart';
// import '../../language/language_key.dart';
// import 'notificationModal/notification_modal.dart';
//
// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({Key? key}) : super(key: key);
//   //
//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }
//
// class _NotificationsScreenState extends State<NotificationsScreen> {
//   bool isDataObtained = true;
//   List<NotificationList> listData = [];
//   List<NotificationList> filterData = [];
//   @override
//   void initState() {
//     super.initState();
//     getUserInfo();
//     NotificationData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     listData = filterData.isEmpty ? listData : listData;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: darkgreen,
//         title: barlowBold(
//           text: notifications.tr,
//           color: white,
//           size: 20,
//         ),
//       ),
//       body: Container(
//           child: isDataObtained
//               ? Expanded(
//             child: Center(
//               child: progressIndicator(context),
//             ),
//           )
//               : Expanded(
//             child: listData.isEmpty && listData.length == 0
//                 ? Expanded(
//               child: Center(
//                 child: barlowRegular(
//                   text: noDataFound.tr,
//                   size: 15,
//                   color: black,
//                 ),
//               ),
//             )
//                 : Expanded(
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height:
//                 MediaQuery.of(context).size.height /
//                     1.3,
//                 child: ListView.builder(
//                     physics: const ScrollPhysics(),
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 15, horizontal: 10),
//                     itemCount: listData.length,
//                     itemBuilder: (context, index) {
//                       NotificationList ds =
//                       listData[index];
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Row(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(ds.tiltle, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                                     Container(
//                                         height: 30,
//                                         width: 250,
//                                         child: Text(ds.deception, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis))),
//                                     Text(ds.dateTime)
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           // notification.postImage != '' ?
//                           Container(
//                             width: 100,
//                             height: 100,
//                             child: ClipRRect(
//                                 child: Image.network(ds.img,fit: BoxFit.cover,)
//                             ),
//                           )
//                           //     : Container(
//                           //     height: 35,
//                           //     width: 110,
//                           //     decoration: BoxDecoration(
//                           //       color: Colors.blue[700],
//                           //       borderRadius: BorderRadius.circular(5),
//                           //     ),
//                           //     child: Center(
//                           //         child: Text('Follow', style: TextStyle(color: Colors.white))
//                           //     )
//                           // ),
//                         ],
//                       );
//                     }),
//               ),
//             ),
//           ))
//     );
//   }
//   Future<List<NotificationList>?> NotificationData() async {
//     Map data = {
//       "user_id": SharedPreferencesFunctions.userId,
//       "user_token": SharedPreferencesFunctions.token,
//     };
//     String body = json.encode(data);
//     // logger.e(body);
//     final response = await http.post(
//         Uri.parse(
//             baseUrl + pushNotificationList),
//         body: body);
//     if (response.statusCode == 200) {
//       // logger.e(response.statusCode);
//       final responseData = json.decode(response.body);
//       final List<NotificationList> ListFertilizerData =
//       NotificationListModel.fromJson(responseData).data.toList();
//       listData = ListFertilizerData;
//       isDataObtained = false;
//       setState(() {});
//       return listData;
//     } else {
//       // logger.e(response.statusCode);
//     }
//     return null;
//   }
//   getUserInfo() async {
//     await SharedPreferencesFunctions().getUserId();
//     await SharedPreferencesFunctions().getToken();
//     setState(() {});
//   }
//
//   getChatRoomIdByPhoneNumbers(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }
// }
