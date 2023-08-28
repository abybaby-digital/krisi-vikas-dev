// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
// import 'package:krishivikas/Screens/home/home_screen.dart';
// import 'package:krishivikas/Screens/tractor_details_screen.dart';
// import 'package:krishivikas/const/api_urls.dart';
// import 'package:krishivikas/const/global.dart';
// import 'package:krishivikas/screens/seeds/seeds_details_screen.dart';
// import 'package:krishivikas/screens/tyres/tyres_details_screen.dart';
// import 'package:krishivikas/services/api_methods.dart';
// import 'package:krishivikas/services/save_user_info.dart';

// class DynamicLinkService {
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
//   late HomeScreen homeInstance;
//   String Shareurl = baseUrl + sharingUrl;
//   String GenerateShareurl = baseUrl + generatesharingUrl;
//   // String GenerateShareurl = baseUrl + generatesharingUrl;
//   String ItemCatgoryName = "";
//   List ShareItemList = [];
//   Future<void> handleDynamicLinks(context) async {
//     // 1. Get the initial dynamic link if the app is opened with a dynamic link
//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     print("Dynamic Link data");
//     print(data);

//     // 2. handle link that has been retrieved
//     _handleDeepLink(data!, context);

//     // 3. Register a link callback to fire if the app is opened up from the background
//     // using a dynamic link.
//     // FirebaseDynamicLinks.instance.onLink;
//     FirebaseDynamicLinks.instance.onLink
//         .listen((PendingDynamicLinkData dynamicLink) {
//       _handleDeepLink(dynamicLink, context);
//     }).onError((error) {
//       // Handle errors
//       print('Link Failed: ${error.message}');
//     });
//   }

//   void _handleDeepLink(PendingDynamicLinkData data, context) {
//     final Uri deepLink = data.link;

//     // ignore: unnecessary_null_comparison
//     if (deepLink != null) {
//       if (deepLink.queryParameters["itemId"] != "") {
//         dynamicLinkItemId = deepLink.queryParameters["itemId"].toString();
//         dynamicLinkItemCategory =
//             deepLink.queryParameters["ItemCategory"].toString();

//         callForGetItem(dynamicLinkItemId, dynamicLinkItemCategory);

//         print("deepLink");
//         print(deepLink);
//         print("dynamicLinkItemId");
//         print(dynamicLinkItemId);
//         print("dynamicLinkItemCategory");
//         print(dynamicLinkItemCategory);

//         if (dynamicLinkItemId == 1 || dynamicLinkItemId == 3) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => TractorDetailsScreen(ShareItemList)));
//         } else if (dynamicLinkItemId == 4 || dynamicLinkItemId == 5) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => HarvesterDetailsScreen(ShareItemList)));
//         } else if (dynamicLinkItemId == 7) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => TyresDetailsScreen(ShareItemList)));
//         } else {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SeedsDetailsScreen(ShareItemList)));
//         }
//         deepLink.queryParameters["itemId"] = "";
//       }
//     }
//   }

//   Future<String> createDynamicLink(String productId, String CatType,
//       String title, String description, String imageUrl) async {
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         uriPrefix: 'https://krishivikas.page.link',
//         link: Uri.parse("https://krishivikas.page.link/" +
//             '?itemId=' +
//             productId.toString() +
//             '&ItemCategory=' +
//             CatType),
//         androidParameters: AndroidParameters(
//           packageName: 'com.krishivikas.android',
//           minimumVersion: 0,
//         ),
//         // iosParameters: const IOSParameters(bundleId: "com.example.app.ios",minimumVersion:0),
//         socialMetaTagParameters: SocialMetaTagParameters(
//             title: "Take a look at this " + title + " on Krishi Vikas Udyog",
//             description: description,
//             imageUrl: Uri.parse(imageUrl)));

//     // final Uri dynamicUrl = await parameters.buildUrl();
//     // final Uri dynamicUrl = await dynamicLinks.buildLink(parameters);

//     // final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
//     // final ShortDynamicLink shortDynamicLink =
//     //     await dynamicLinks.buildShortLink(parameters);

//     final ShortDynamicLink shortenedLink =
//         await dynamicLinks.buildShortLink(parameters);
//     // url = shortLink.shortUrl;
//     //     await DynamicLinkParameters.shortenUrl(
//     //   Uri.parse(dynamicUrl.toString()),
//     //   DynamicLinkParametersOptions(
//     //       shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
//     // );

//     // final Uri shortUrl = shortDynamicLink.shortUrl;
//     print("parameters");
//     print(parameters);
//     print("Dynamic Link adta");
//     print(shortenedLink.shortUrl.toString());
//     return shortenedLink.shortUrl.toString();
//   }

//   Future<List<dynamic>> callForGetItem(catId, ItemId) async {
//     await SharedPreferencesFunctions().getUserId();
//     await SharedPreferencesFunctions().getToken();

//     // String url, int userId, String token,String categoryId, String productId

//     List newTractorsList = await ApiMethods().getSingleProductApi(
//       Shareurl,
//       SharedPreferencesFunctions.userId!,
//       SharedPreferencesFunctions.token!,
//       catId.toString(),
//       ItemId.toString(),
//     );

//     try {
//       this.ShareItemList = [];
//       this.ShareItemList.addAll(newTractorsList);
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         e.toString(),
//       );
//     }

//     return Future.value(ShareItemList);
//   }
// }
