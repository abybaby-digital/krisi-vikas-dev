import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/account/profile_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/controllers/contact_now_controller.dart';
import 'package:krishivikas/controllers/favorite_controller.dart';
import 'package:krishivikas/screens/Edit/Tractor_GoodVehical/EditScreen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/distence_widget.dart';
import '../../../Screens/home/home_screen.dart';
import '../../../Screens/tractor/data.dart';
import '../../../const/fonts.dart';
import '../../../language/language_key.dart';


class PostTyreDetailScreen extends StatefulWidget {
  final int tyre_id;

  PostTyreDetailScreen(
      this.tyre_id,
      );

  @override
  State<PostTyreDetailScreen> createState() => _PostTyreDetailScreenState();
}

class _PostTyreDetailScreenState extends State<PostTyreDetailScreen> {
  FavoriteController favoriteController = Get.put(FavoriteController());

  ContactNowController contactNowController = Get.put(ContactNowController());

  String chatRoomId = "";

  List<Map> SliderList = [];

  bool showCPI = false;
  String phoneNo ='';

  var ds;
  fetchData() async{
    await ApiMethods().getSingleTractorInfoById(
        baseUrl+'tyre-by-id',
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        widget.tyre_id).then((value) {
      print('---Value---');
      print(value);
      setState(() {
        ds = value;
      });
    });
  }

  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    // print("get tractor Data");
    // print(ds);
    // print(ds[0]["created_at"]);
    super.initState();
    //AppFonts.dateFormatChanged(ds[0]["created_at"]);
    doThisOnLaunch();
    getListForSlider();
    // print("SliderList");
    // print(SliderList);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        gotoWithoutBack(
          context,
          ProfileScreen(),
        );
        return Future.value(true);
      },
      child:
      ds == null?
      Scaffold(
          body: Center(
            child: progressIndicator(context),
          )
      ):
      Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: grey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              gotoWithoutBack(
                context,
                ProfileScreen(),
              );
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      '${ds[0]['image1']}'!=''?
                      Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
                              goto(context, PhotoSelectView(side: "Image 1", imageUrl: '${ds[0]['image1']}'));
                            },
                            child:CachedNetworkImage(
                              imageUrl: ds[0]['image1'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: fullWidth(context),
                                    height: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image size fill
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Center(
                                child: Text(
                                  "Loading..",
                                  style: TextStyle(color: darkgreen),
                                ),
                              ), //show progress  while loading image
                              errorWidget: (context, url, error) =>
                                  Image.asset("images/flutter.png"),
                              //show no image available image on error loading
                            ),
                          ),
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
                      ):SizedBox.shrink(),
                      '${ds[0]['image2']}'!=''?
                      Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
                              goto(context, PhotoSelectView(side: "Image 2", imageUrl: '${ds[0]['image2']}'));
                            },
                            child: CachedNetworkImage(
                              imageUrl: ds[0]['image2'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: fullWidth(context),
                                    height: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image size fill
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Center(
                                child: Text(
                                  "Loading..",
                                  style: TextStyle(color: darkgreen),
                                ),
                              ), //show progress  while loading image
                              errorWidget: (context, url, error) =>
                                  Image.asset("images/flutter.png"),
                              //show no image available image on error loading
                            ),
                          ),
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
                      ):SizedBox.shrink(),
                      '${ds[0]['image3']}'!=''?
                      Stack(
                        children: [
                          GestureDetector(
                            onTap:(){
                              goto(context, PhotoSelectView(side: "Image 3", imageUrl: '${ds[0]['image3']}'));
                            },
                            child: CachedNetworkImage(
                              imageUrl: ds[0]['image3'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: fullWidth(context),
                                    height: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        //image size fill
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                              placeholder: (context, url) => Center(
                                child: Text(
                                  "Loading..",
                                  style: TextStyle(color: darkgreen),
                                ),
                              ), //show progress  while loading image
                              errorWidget: (context, url, error) =>
                                  Image.asset("images/flutter.png"),
                              //show no image available image on error loading
                            ),
                          ),
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
                      ):SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
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
                              text: ds[0]["brand_name"].toString(),
                              size: 18,
                              color: kPrimaryColor,
                            ),
                            Text(" "),
                            barlowBold(
                              text: ds[0]["model_name"].toString(),
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
                                    text: ds[0]["city_name"].toString(),
                                    size: 15,
                                    color: black,
                                  ),
                                  Text(","),
                                  barlowBold(
                                    text: ds[0]["state_name"].toString(),
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
                              text: "₹" + " " + "${ds[0]["price"] ?? ""}",
                              size: 20,
                              color: darkgreen,
                            ),
                            HSpace(3),
                            ds[0]["is_negotiable"] == "1"
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
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          bottom: 5,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lock_clock),
                            Text(" "),
                            barlowBold(
                              text: "Update Pending",
                              size: 20,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                      ds[0]["description"] == null
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
                      ds[0]["description"] == null
                          ? SizedBox.shrink()
                          : Padding(
                        padding: EdgeInsets.all(15.0),
                        child: barlowLight(
                          text: ds[0]["description"] ?? "",
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
                          // goto(context, UserProfileScreen(ds));
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
                                      imageUrl: ds[0]["photo"],
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
                                        text: ds[0]["name"] ?? "Unknown",
                                        size: 15,
                                        color: black,
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.only(top: 5, bottom: 3),
                                        child: barlowRegular(
                                          text: memeber.tr +
                                              "   " +
                                              ds[0]["created_at_user"],
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
        ds[0]["mobile"] ?? "");

    setState(() {
      phoneNo = '${SharedPreferencesFunctions.phoneNumber}';
    });

  }

  getListForSlider() async {
    if (ds[0]['front_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Front View';
      SliderListItem["imageItem"] = ds[0]['front_image'];
      SliderListItem["itemIndex"] = 0;
      SliderList.add(SliderListItem);
    }
    if (ds[0]['right_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Right View';
      SliderListItem["imageItem"] = ds[0]['right_image'];
      SliderListItem["itemIndex"] = 1;
      SliderList.add(SliderListItem);
    }
    if (ds[0]['left_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Left View';
      SliderListItem["imageItem"] = ds[0]['left_image'];
      SliderListItem["itemIndex"] = 2;
      SliderList.add(SliderListItem);
    }
    if (ds[0]['back_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Back View';
      SliderListItem["imageItem"] = ds[0]['back_image'];
      SliderListItem["itemIndex"] = 3;
      SliderList.add(SliderListItem);
    }
    if (ds[0]['meter_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = 'Meter View';
      SliderListItem["imageItem"] = ds[0]['meter_image'];
      SliderListItem["itemIndex"] = 4;
      SliderList.add(SliderListItem);
    }
    if (ds[0]['tyre_image'] != "") {
      Map SliderListItem = Map();
      SliderListItem["title"] = "Tyre View";
      SliderListItem["imageItem"] = ds[0]['tyre_image'];
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
                    text: "Position",
                    size: 14,
                    color: black,
                  ),
                  barlowRegular(
                    text: ds[0]["position"],
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
                  ShowDistanceText(UserData.lat,UserData.long,ds[0]['latlong'].toString())
                ],
              ),
            ),
          ),
        ),
        // ListView.builder(
        //   padding: EdgeInsets.zero,
        //   physics: ScrollPhysics(),
        //   shrinkWrap: true,
        //   itemCount: ds[0]["specification"].length,
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
        //                 text: ds[0]["specification"][index]["spec_name"],
        //                 size: 14,
        //                 color: black,
        //                 maxLine: 5,
        //               ),
        //               barlowRegular(
        //                 text: ds[0]["specification"][index]["spec_value"],
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
