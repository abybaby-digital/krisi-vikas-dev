import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_details_screen.dart';
import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/Screens/home/home_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/screens/seeds/seeds_details_screen.dart';
import 'package:krishivikas/screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';

class DynamicLinkService {
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  late HomeScreen homeInstance;
  String Shareurl = baseUrl + sharingUrl;
  String GenerateShareurl = baseUrl + generatesharingUrl;
  String ItemCatgoryName = "";
  List ShareItemList = [];
  String uriPrefix = 'https://krishivikas.page.link';
  // Future<void> handleDynamicLinks(context) async {
  //   final PendingDynamicLinkData? initialLink =
  //       await FirebaseDynamicLinks.instance.getInitialLink();
  //   if (initialLink != null) {
  //     final Uri deepLink = initialLink.link;
  //     // ignore: unnecessary_null_comparison
  //     if (deepLink != null) {
  //       if (deepLink.queryParameters["itemId"] != "") {
  //         dynamicLinkItemId = deepLink.queryParameters["itemId"].toString();
  //         dynamicLinkItemCategory =
  //             deepLink.queryParameters["ItemCategory"].toString();

  //         await callForGetItem(dynamicLinkItemCategory, dynamicLinkItemId);

  //         print("deepLink");
  //         print(deepLink);
  //         print("dynamicLinkItemId");
  //         print(dynamicLinkItemId);
  //         print("dynamicLinkItemCategory");
  //         print(dynamicLinkItemCategory);

  //         _handleDeepLink(dynamicLinkItemId, dynamicLinkItemCategory, context);
  //       }
  //     }
  //   }
  //   FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
  //     final Uri deepLink = dynamicLinkData.link;
  //     // Example of using the dynamic link to push the user to a different screen
  //     // ignore: unnecessary_null_comparison
  //     if (deepLink != null) {
  //       if (deepLink.queryParameters["itemId"] != "") {
  //         dynamicLinkItemId = deepLink.queryParameters["itemId"].toString();
  //         dynamicLinkItemCategory =
  //             deepLink.queryParameters["ItemCategory"].toString();

  //         await callForGetItem(dynamicLinkItemCategory, dynamicLinkItemId);

  //         print("deepLink");
  //         print(deepLink);
  //         print("dynamicLinkItemId");
  //         print(dynamicLinkItemId);
  //         print("dynamicLinkItemCategory");
  //         print(dynamicLinkItemCategory);

  //         _handleDeepLink(dynamicLinkItemId, dynamicLinkItemCategory, context);
  //       }
  //     }
  //   }).onError((error) {
  //     print('Link Failed: ${error.message}');
  //   });
  // }

  // void _handleDeepLink(itemId, CatId, BuildContext context) {
  //   if (ShareItemList.isNotEmpty) {
  //     if (CatId == "1" || CatId == "3") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     TractorDetailsScreen(ShareItemList[0])));
  //       });
  //       // goto(context, TractorDetailsScreen(ShareItemList[0]));
  //     } else if (CatId == "4") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     HarvesterDetailsScreen(ShareItemList[0])));
  //       });
  //     } else if (CatId == "5") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     ImplementsDetailsScreen(ShareItemList[0])));
  //       });
  //     } else if (CatId == "7") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => TyresDetailsScreen(ShareItemList[0])));
  //       });
  //     } else if (CatId == "6") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => SeedsDetailsScreen(ShareItemList[0])));
  //       });
  //     } else if (CatId == "8") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     PesticidesDetailsScreen(ShareItemList[0])));
  //       });
  //     } else if (CatId == "9") {
  //       Future(() {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     FertilizerDetailsScreen(ShareItemList[0])));
  //       });
  //     } else {
  //       Future(() {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //       });
  //     }
  //   }
  // }

  Future<String> createDynamicLink(String productId, String CatType,
      String title, String description, String imageUrl) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: uriPrefix,
        link: Uri.parse("https://krishivikas.page.link/" +
            '?itemId=' +
            productId.toString() +
            '&ItemCategory=' +
            CatType),
        androidParameters: AndroidParameters(
          packageName: 'com.krishivikas.android',
          minimumVersion: 0,
        ),
        // iosParameters: const IOSParameters(bundleId: "com.example.app.ios",minimumVersion:0),
        socialMetaTagParameters: SocialMetaTagParameters(
            title: "Take a look at this " + title + " on Krishi Vikas Udyog",
            description: description,
            imageUrl: Uri.parse(imageUrl)));

    final ShortDynamicLink shortenedLink =
        await dynamicLinks.buildShortLink(parameters);
    return shortenedLink.shortUrl.toString();
  }

  // Future<List<dynamic>> callForGetItem(catId, ItemId) async {
  //   await SharedPreferencesFunctions().getUserId();
  //   await SharedPreferencesFunctions().getToken();

  //   List newTractorsList = await ApiMethods().getSingleProductApi(
  //     Shareurl,
  //     SharedPreferencesFunctions.userId!,
  //     SharedPreferencesFunctions.token!,
  //     catId.toString(),
  //     ItemId.toString(),
  //   );

  //   try {
  //     this.ShareItemList = [];
  //     this.ShareItemList.addAll(newTractorsList);
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //     );
  //   }

  //   return Future.value(ShareItemList);
  // }
}
