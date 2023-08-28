import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/chat/individual_chat_screen.dart';
import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/fonts.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/controllers/contact_now_controller.dart';
import 'package:krishivikas/controllers/favorite_controller.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/firebase_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Screens/tractor/data.dart';
import '../../const/app_images.dart';
import '../../services/local_services.dart';
import 'package:http/http.dart' as http;

import '../../widgets/distence_widget.dart';
import 'Model/fertilizers_model.dart';

class FirtilizerFilterDetailsScreen extends StatefulWidget {
  final FertilizerDatum ds;
  const FirtilizerFilterDetailsScreen({Key? key, required this.ds})
      : super(key: key);

  @override
  State<FirtilizerFilterDetailsScreen> createState() =>
      _FirtilizerFilterDetailsScreenState();
}

class _FirtilizerFilterDetailsScreenState
    extends State<FirtilizerFilterDetailsScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  ContactNowController contactNowController = Get.put(ContactNowController());

  String chatRoomId = "";

  bool showCPI = false;

  List<Map> SliderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getListForSlider();
    AppFonts.dateFormatChanged(widget.ds.createdAt);
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
            widget.ds.mobile
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
                      if (CurrentUserType == 0) {
                        await goto(
                            context, EnterUserDetails(1, "detailspage"));
                        setState(() {});
                      } else {
                        Map<String, dynamic> chatRoomInfoMap = {
                          "usersPhoneNumbers": [
                            SharedPreferencesFunctions.phoneNumber
                                .toString(),
                            widget.ds.mobile
                          ],
                          "usersDeviceTokenIds": [
                            SharedPreferencesFunctions.deviceToken
                                .toString(),
                            widget.ds.deviceId,
                          ],
                          "ts": DateTime.now()
                        };

                        ///Contact Us Api Function Call For Chat
                        await contactNowController.getContactInformation(
                          postUserId: widget.ds.userId.toString(),
                          categoryId: widget.ds.categoryId.toString(),
                          postId: widget.ds.id!.toInt(),
                          callStatus: "0",
                          messageStatus: "1",
                        );
                        FirebaseMethods()
                            .createChatRoom(chatRoomId, chatRoomInfoMap)
                            .then((value) {
                          goto(
                            context,
                            IndividualChatScreen(
                              otherUserPhoneNumber: widget.ds.mobile,
                              otherUserDeviceTokenId:
                              widget.ds.firebaseToken,
                              chatRoomInfoMap: chatRoomInfoMap,
                            ),
                          );
                        });
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
                      if (CurrentUserType == 0) {
                        await goto(
                            context, EnterUserDetails(1, "detailspage"));
                        setState(() {});
                      } else {
                        ///Contact Us Api Function Call For Contact &&
                        var productImageUrl = widget.ds.image1
                            .toString()
                            .replaceFirst("http", "https");

                        String url = 'tel:${widget.ds.mobile}';

                        if (await canLaunch(url)) {
                          var contactUsData = widget.ds.price.toString() +
                              "\n" +
                              widget.ds.description.toString();

                          await LocalServices().sendPushMessage(
                            token: widget.ds.deviceId.toString(),
                            title: widget.ds.name,
                            body: contactUsData,
                          );
                          await contactNowController
                              .getContactInformation(
                            postUserId: widget.ds.userId.toString(),
                            categoryId: widget.ds.categoryId.toString(),
                            postId: widget.ds.id!.toInt(),
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
                )
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
                if (widget.ds.wishlistStatus == 1) {
                  await favoriteController.deleteFavoriteProduct(
                    widget.ds.categoryId.toString(),
                    widget.ds.id!.toInt(),
                  );
                  favoriteController.getFavoriteProducts();
                  setState(() {
                    widget.ds.wishlistStatus = 0;

                    Get.snackbar(
                      remove.tr,
                      removeFromWishlist.tr,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: darkgreen,
                      colorText: white,
                    );
                  });
                } else {
                  await favoriteController.addFavoriteProduct(
                    widget.ds.categoryId.toString(),
                    widget.ds.id!.toInt(),
                  );
                  favoriteController.getFavoriteProducts();
                  setState(
                        () {
                      widget.ds.wishlistStatus = 1;

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
                widget.ds.wishlistStatus == 1
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
                          widget.ds.image1 != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds.image1.toString(),
                                  fullWidth(context),
                                  350,
                                  AppImages.leftImage,
                                  SliderList,
                                  0,
                                  context),
                              Positioned(
                                left: 170,
                                top: 250,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Image.asset(
                                          'assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds.image2 != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds.image2.toString(),
                                  fullWidth(context),
                                  350,
                                  AppImages.rightImage,
                                  SliderList,
                                  1,
                                  context),
                              Positioned(
                                left: 170,
                                top: 250,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Image.asset(
                                          'assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                          widget.ds.image3 != ""
                              ? Stack(
                            children: [
                              CachedNetworkImgForSlider(
                                  widget.ds.image3.toString(),
                                  fullWidth(context),
                                  350,
                                  AppImages.frontImage,
                                  SliderList,
                                  2,
                                  context),
                              Positioned(
                                left: 170,
                                top: 250,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: Image.asset(
                                          'assets/WaterMark.png')),
                                ),
                              )
                            ],
                          )
                              : SizedBox.shrink(),
                        ],
                      ),
                      widget.ds.status==4?
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
              child: Stack(children: [
                IconButton(
                  // String productId, String CatType, String title, String description, String imageUrl
                  onPressed: () async {
                    if (widget.ds.id != null && widget.ds.categoryId != null) {
                      var title = widget.ds.title.toString();
                      var descriptionData = widget.ds.description ?? "";
                      var imageData =
                          widget.ds.image1 ?? AppImages.defaultImage;
                      dynamicLinkService
                          .createDynamicLink(
                          (widget.ds.id.toString()),
                          widget.ds.categoryId.toString(),
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
              ]),
            ),
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                              text: widget.ds.title ?? "",
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
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  barlowBold(
                                    text: widget.ds.cityName.toString(),
                                    size: 15,
                                    color: black,
                                  ),
                                  Text(","),
                                  barlowBold(
                                    text: widget.ds.stateName.toString(),
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
                                    "assets/calendar.png",
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
                              text: "₹" + " " + "${widget.ds.price ?? ""}",
                              size: 20,
                              color: darkgreen,
                            ),
                            HSpace(3),
                            widget.ds.isNegotiable == "1"
                                ? barlowBold(
                              text: "(Price Negotiable)",
                              size: 20,
                              color: darkgreen,
                            )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.ds.description == null
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
                      widget.ds.description == null
                          ? SizedBox.shrink()
                          : Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          widget.ds.description ?? "",
                          style: TextStyle(
                            fontFamily: AppFonts.barlowLight,
                            fontStyle: FontStyle.normal,
                          ),
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
                        onTap: () {},
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
                                      imageUrl: widget.ds.photo.toString(),
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
                                        text: widget.ds.name ?? "Unknown",
                                        size: 15,
                                        color: black,
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 5, bottom: 3),
                                        child: barlowRegular(
                                          text: memeber.tr +
                                              "   " +
                                              widget.ds.createdAtUser
                                                  .toString(),
                                          size: 15,
                                          color: grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      VSpace(10),
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
                    text: priceNegotiable.tr,
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: widget.ds.isNegotiable == "1" ? yes.tr : no.tr,
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
                  ShowDistanceText(
                      UserData.lat, UserData.long, widget.ds.latlong.toString())
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getIsRegistered();
    await SharedPreferencesFunctions().getUserPhoneNumber();

    chatRoomId = getChatRoomIdByPhoneNumbers(
        SharedPreferencesFunctions.phoneNumber.toString(),
        widget.ds.mobile.toString());
  }

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getListForSlider() async {
    if (widget.ds.image1 != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = '';
      SliderListItem["imageItem"] = widget.ds.image1;
      SliderListItem["itemIndex"] = 0;
      SliderList.add(SliderListItem);
    }
    if (widget.ds.image2 != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = '';
      SliderListItem["imageItem"] = widget.ds.image2;
      SliderListItem["itemIndex"] = 1;
      SliderList.add(SliderListItem);
    }
    if (widget.ds.image3 != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = '';
      SliderListItem["imageItem"] = widget.ds.image3;
      SliderListItem["itemIndex"] = 2;
      SliderList.add(SliderListItem);
    }
  }
}
