import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/controllers/contact_now_controller.dart';
import 'package:krishivikas/controllers/favorite_controller.dart';
import 'package:krishivikas/screens/Edit/Tractor_GoodVehical/EditScreen.dart';
import 'package:krishivikas/screens/chat/individual_chat_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/distence_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/tractor/data.dart';
import '../const/fonts.dart';
import '../language/language_key.dart';
import '../services/local_services.dart';
import 'package:http/http.dart' as http;

class TractorDetailsScreen extends StatefulWidget {
  final ds;

  TractorDetailsScreen(
      this.ds,
      );

  @override
  State<TractorDetailsScreen> createState() => _TractorDetailsScreenState();
}

class _TractorDetailsScreenState extends State<TractorDetailsScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  ContactNowController contactNowController = Get.put(ContactNowController());

  String chatRoomId = "";

  List<Map> SliderList = [];

  bool showCPI = false;
  String phoneNo ='';

  leadView() async{
    await ApiMethods().Lead_View(widget.ds['user_id'], widget.ds['category_id'], '${widget.ds['id']}').then((value) {
      print("Lead Send Successfully : ${widget.ds['category_id']}");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // print("get tractor Data");
    // print(widget.ds);
    // print(widget.ds["created_at"]);
    super.initState();
    AppFonts.dateFormatChanged(widget.ds["created_at"]);
    doThisOnLaunch();
    getListForSlider();
    leadView();
    // print("SliderList");
    // print(SliderList);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // gotoWithoutBack(
        //   context,
        //   HomeScreen(),
        // );
        return Future.value(true);
      },
      child: Scaffold(
        bottomNavigationBar: SharedPreferencesFunctions.phoneNumber !=
            widget.ds["mobile"] && widget.ds['status'] == 1
            ? Container(
          height: 55,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    height: 55,
                    color: lightgreen,
                    onPressed: () async {
                      await ApiMethods().Lead_Generate(widget.ds['user_id'], widget.ds['category_id'], '${widget.ds['id']}','0','1','ChatRoom');
                      if (CurrentUserType == 0) {
                        await goto(
                            context, EnterUserDetails(1, "detailspage"));
                        setState(() {});
                      } else {
                        Map<String, dynamic> chatRoomInfoMap = {
                          "usersPhoneNumbers": [
                            SharedPreferencesFunctions.phoneNumber
                                .toString(),
                            widget.ds["mobile"]
                          ],
                          "usersDeviceTokenIds": [
                            SharedPreferencesFunctions.deviceToken,
                            widget.ds["firebase_token"],
                          ],
                          "ts": DateTime.now(),
                          "other_mobile": widget.ds["mobile"],
                          "other_token": widget.ds["firebase_token"],
                        };

                        ///Contact Us Api Function Call For Chat
                        await contactNowController.getContactInformation(
                          postUserId: widget.ds['user_id'],
                          categoryId: widget.ds['category_id'],
                          postId: widget.ds['id'],
                          callStatus: "0",
                          messageStatus: "1",
                        );
                        final FirebaseMessaging fcm =
                            FirebaseMessaging.instance;
                        final token = await fcm.getToken();
                        if (SharedPreferencesFunctions()
                            .getOtherToken() !=
                            token) {
                          SharedPreferencesFunctions()
                              .saveOtherToken(token!);
                        }

                        FirebaseMethods()
                            .createChatRoom(chatRoomId, chatRoomInfoMap)
                            .then(
                              (value) {
                            goto(
                              context,
                              IndividualChatScreen(
                                otherUserPhoneNumber: widget.ds["mobile"],
                                otherUserDeviceTokenId:
                                widget.ds["firebase_token"],
                                chatRoomInfoMap: chatRoomInfoMap,
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.chatImage,
                          width: 20,
                          height: 20,
                          color: white,
                        ),
                        HSpace(8),
                        barlowRegular(
                          text: chat.tr,
                          color: white,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    height: 55,
                    color: darkgreen,
                    onPressed: () async {
                      await ApiMethods().Lead_Generate(widget.ds['user_id'], widget.ds['category_id'], '${widget.ds['id']}','1','0','Call');
                      if (CurrentUserType == 0) {
                        await goto(
                            context, EnterUserDetails(1, "detailspage"));
                        setState(() {});
                      } else {
                        ///Contact Us Api Function Call For Contact &&
                        var productImageUrl = widget.ds['front_image']
                            .toString()
                            .replaceFirst("http", "https");

                        String url = 'tel:${widget.ds["mobile"]}';

                        if (await canLaunch(url)) {
                          var contactUsData =
                              widget.ds["brand_name"].toString() +
                                  widget.ds["model_name"].toString() +
                                  "\n" +
                                  widget.ds['price'].toString() +
                                  "\n" +
                                  widget.ds["description"].toString();

                          await LocalServices().sendPushMessage(
                            token: widget.ds["device_id"].toString(),
                            title: widget.ds["name"],
                            body: contactUsData,
                          );

                          await contactNowController
                              .getContactInformation(
                            postUserId: widget.ds['user_id'],
                            categoryId: widget.ds['category_id'],
                            postId: widget.ds['id'],
                            callStatus: "1",
                            messageStatus: "0",
                          );
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.phoneImage,
                          width: 20,
                          height: 20,
                          color: white,
                        ),
                        HSpace(8),
                        barlowRegular(
                          text: call.tr,
                          color: white,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
            : null,
        resizeToAvoidBottomInset: true,
        backgroundColor: grey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              goBack(context);
            },
            icon: Icon(
              (Platform.isAndroid)
                  ? Icons.arrow_back
                  : Icons.arrow_back_ios_new_rounded,
              color: darkgreen,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: kPrimaryColor,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (widget.ds["wishlist_status"] == 1) {
                  await favoriteController.deleteFavoriteProduct(
                      widget.ds['category_id'], widget.ds['id']);
                  favoriteController.getFavoriteProducts();
                  setState(
                        () {
                      widget.ds["wishlist_status"] = 0;

                      Get.snackbar(
                        remove.tr,
                        removeFromWishlist.tr,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: darkgreen,
                        colorText: white,
                      );
                    },
                  );
                } else {
                  await favoriteController.addFavoriteProduct(
                    widget.ds["category_id"],
                    widget.ds["id"],
                  );
                  favoriteController.getFavoriteProducts();
                  setState(
                        () {
                      widget.ds["wishlist_status"] = 1;

                      Get.snackbar(
                        sucess.tr,
                        addToWishlist.tr,
                        backgroundColor: darkgreen,
                        colorText: white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  );
                }
              },
              icon: Icon(
                widget.ds["wishlist_status"] == 1
                    ? Icons.favorite
                    : Icons.favorite_outline,
              ),
              color: red,
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 350,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          widget.ds["front_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["front_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.leftImage,
                                  SliderList,
                                  0,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds["right_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["right_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.rightImage,
                                  SliderList,
                                  1,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds["left_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["left_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.frontImage,
                                  SliderList,
                                  2,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds["back_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["back_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.backImage,
                                  SliderList,
                                  3,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds["meter_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["meter_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.meterImage,
                                  SliderList,
                                  4,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )                                ],
                          )
                              : SizedBox.shrink(),
                          widget.ds["tyre_image"] != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds["tyre_image"],
                                  fullWidth(context),
                                  350,
                                  AppImages.tyreImage,
                                  SliderList,
                                  5,
                                  context),
                              Positioned(
                                left: 170,
                                top: 240,
                                child: Container(
                                  width:MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width:90,
                                      height: 90,
                                      child: Image.asset('assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                        ],
                      ),
                      widget.ds['status']==4?
                      SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.asset('assets/sold_tag.png'))
                          :Container(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 85,
              left: fullWidth(context) * 0.88,
              // right: 10,
              // bottom: fullHeight(context) * 0.90,
              child: IconButton(
                // String productId, String CatType, String title, String description, String imageUrl
                onPressed: () async {
                  if (widget.ds["id"] != null &&
                      widget.ds["category_id"] != null) {
                    var title = widget.ds["brand_name"].toString() +
                        widget.ds["model_name"].toString();
                    var descriptionData = widget.ds["description"] ?? "";
                    var imageData =
                        widget.ds["front_image"] ?? AppImages.frontImage;
                    dynamicLinkService
                        .createDynamicLink(
                        (widget.ds["id"].toString()),
                        widget.ds["category_id"].toString(),
                        title,
                        descriptionData,
                        imageData)
                        .then((newDynamicLink) async {
                      print(newDynamicLink +
                          " Dynamic Link on click Share Button");

                      final uri = Uri.parse(imageData);
                      final res = await http.get(uri);
                      final bytes = res.bodyBytes;

                      final temp = await getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                      File(path).writeAsBytesSync(bytes);

                      await Share.shareFiles(
                        [path],
                        text: "Take a look at this " +
                            title +
                            " on Krishi Vikas Udyog" +
                            " " +
                            newDynamicLink,
                      );
                      // Navigator.pop(context);
                    });
                  }
                },
                icon: Icon(
                  Icons.share,
                ),
                color: red,
              ),
            ),

            widget.ds['mobile']=='$phoneNo' && widget.ds['status'] != 4?
            Positioned(
              top: 130,
              left: fullWidth(context) * 0.88,
              // right: 10,
              // bottom: fullHeight(context) * 0.90,
              child: IconButton(

                onPressed: () async {
                  goto(context, EditScreen(ds: widget.ds,));
                },
                icon: FaIcon(FontAwesomeIcons.edit),
                color: red,
              ),
            ):
            Container(),
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 18,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            barlowBold(
                              text: widget.ds["brand_name"].toString(),
                              size: 18,
                              color: kPrimaryColor,
                            ),
                            Text(" "),
                            barlowBold(
                              text: widget.ds["model_name"].toString(),
                              size: 18,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13,
                          bottom: 12,
                          right: 25,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                    color: black,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  barlowBold(
                                    text: widget.ds["city_name"].toString(),
                                    size: 15,
                                    color: black,
                                  ),
                                  Text(","),
                                  barlowBold(
                                    text: widget.ds["state_name"].toString(),
                                    size: 15,
                                    color: black,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppImages.calenderIcon,
                                    width: 15,
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  barlowBold(
                                    text: AppFonts.newDate.toString(),
                                    size: 15,
                                    color: black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 13, right: 5),
                        child: Row(
                          children: [
                            HSpace(5),
                            barlowBold(
                              text: "₹" +
                                  " " +
                                  "${widget.ds["price"] ?? ""}" +
                                  ((widget.ds["type"] == 'rent' ||
                                      widget.ds["set"] == 'rent')
                                      ? "${(widget.ds["rent_type"]).toString().replaceAll('Per', '/')}"
                                      : ""),
                              size: 20,
                              color: darkgreen,
                            ),
                            HSpace(3),
                            widget.ds["is_negotiable"] == "1"
                                ? barlowBold(
                              text: "(Price Negotiable)",
                              size: 20,
                              color: darkgreen,
                            )
                                : SizedBox()
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.ds['status']==4?
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            height: 25,
                            width: 120,
                            color: Colors.blue,
                            child: Center(
                              child: barlowBold(
                                text: "Sold",
                                color: white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ):Container(),

                      const SizedBox(
                        height: 10,
                      ),
                      widget.ds["description"] == null
                          ? SizedBox.shrink()
                          : Container(
                        height: 50,
                        width: double.infinity,
                        color: greyShade100,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: barlowBold(
                            text: description.tr,
                            size: 15,
                            color: black,
                          ),
                        ),
                      ),
                      widget.ds["description"] == null
                          ? SizedBox.shrink()
                          : Padding(
                        padding: EdgeInsets.all(15.0),
                        child: barlowLight(
                          text: widget.ds["description"] ?? "",
                          size: 15,
                          color: black,
                        ),
                      ),

                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   color: greyShade100,
                      //   child: Padding(
                      //     padding: EdgeInsets.all(15.0),
                      //     child: barlowBold(
                      //       text: additionalDetails.tr,
                      //       size: 15,
                      //       color: black,
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: buildAdditionalDetail(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        color: greyShade100,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: barlowBold(
                            text: contact.tr,
                            size: 15,
                            color: black,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // goto(context, UserProfileScreen(widget.ds));
                        },
                        child: Container(
                          color: white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.ds["photo"],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            size: 30,
                                          ),
                                        );
                                      },
                                      errorWidget: (context, url, dynamic) {
                                        return CircleAvatar(
                                          child: Icon(
                                            Icons.person,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      barlowBold(
                                        text: widget.ds["name"] ?? "Unknown",
                                        size: 15,
                                        color: black,
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 5, bottom: 3),
                                        child: barlowRegular(
                                          text: memeber.tr +
                                              "   " +
                                              widget.ds["created_at_user"],
                                          size: 15,
                                          color: grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getIsRegistered();
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getDeviceToken();
    chatRoomId = getChatRoomIdByPhoneNumbers(
        SharedPreferencesFunctions.phoneNumber.toString(),
        widget.ds["mobile"] ?? "");

    setState(() {
      phoneNo = '${SharedPreferencesFunctions.phoneNumber}';
    });

  }

  getListForSlider() async {
    if (widget.ds['front_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Front View';
      SliderListItem["imageItem"] = widget.ds['front_image'];
      SliderListItem["itemIndex"] = 0;
      SliderList.add(SliderListItem);
    }
    if (widget.ds['right_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Right View';
      SliderListItem["imageItem"] = widget.ds['right_image'];
      SliderListItem["itemIndex"] = 1;
      SliderList.add(SliderListItem);
    }
    if (widget.ds['left_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Left View';
      SliderListItem["imageItem"] = widget.ds['left_image'];
      SliderListItem["itemIndex"] = 2;
      SliderList.add(SliderListItem);
    }
    if (widget.ds['back_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Back View';
      SliderListItem["imageItem"] = widget.ds['back_image'];
      SliderListItem["itemIndex"] = 3;
      SliderList.add(SliderListItem);
    }
    if (widget.ds['meter_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Meter View';
      SliderListItem["imageItem"] = widget.ds['meter_image'];
      SliderListItem["itemIndex"] = 4;
      SliderList.add(SliderListItem);
    }
    if (widget.ds['tyre_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = "Tyre View";
      SliderListItem["imageItem"] = widget.ds['tyre_image'];
      SliderListItem["itemIndex"] = 5;
      SliderList.add(SliderListItem);
    }
  }

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget buildAdditionalDetail() {
    return Column(
      children: [
        VSpace(10),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: rcAvailableValue.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds["rc_available"] == "true" ? yes.tr : no.tr,
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: nocAvailableValue.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds["noc_available"] == "true" ? yes.tr : no.tr,
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: regNumber.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds["registration_no"].toString(),
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: yearOfPurchase.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds["year_of_purchase"].toString(),
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: priceNegotiable.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds["is_negotiable"] == "true" ? yes.tr : no.tr,
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: greyShade100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: Distance.tr,
                    size: 14,
                    color: black,
                  ),
                  ShowDistanceText(UserData.lat,UserData.long,widget.ds['latlong'].toString())
                ],
              ),
            ),
          ),
        ),
        // ListView.builder(
        //   padding: EdgeInsets.zero,
        //   physics: ScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: widget.ds["specification"].length,
        //   itemBuilder: ((context, index) {
        //     return Padding(
        //       padding: const EdgeInsets.all(2.0),
        //       child: Container(
        //         color: greyShade100,
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             children: [
        //               barlowBold(
        //                 text: widget.ds["specification"][index]["spec_name"],
        //                 size: 14,
        //                 color: black,
        //                 maxLine: 5,
        //               ),
        //               barlowRegular(
        //                 text: widget.ds["specification"][index]["spec_value"],
        //                 size: 14,
        //                 color: black,
        //                 maxLine: 5,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     );
        //   }),
        // ),
      ],
    );
  }
}
