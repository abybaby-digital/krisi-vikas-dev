import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/chat/individual_chat_screen.dart';
import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/fertilizer/fertilizer_details_screen.dart';
import 'package:krishivikas/screens/pesticides/pesticides_details_screen.dart';
import 'package:krishivikas/screens/seeds/seeds_details_screen.dart';
import 'package:krishivikas/screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/fonts.dart';
import '../../services/firebase_methods.dart';

class MyPostScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  final String url;
  final String k;

  MyPostScreen(
    this.categoryId,
    this.categoryName,
    this.url,
    this.k,
  );

  @override
  State<MyPostScreen> createState() => _MyPostScreenState();
}

class _MyPostScreenState extends State<MyPostScreen> {
  var response;

  var myLeads;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: _getProductName(widget.categoryName),
          color: white,
          size: 20,
        ),
      ),
      body: FutureBuilder<List>(
        future: ApiMethods().getPosts(
          widget.url,
          SharedPreferencesFunctions.userId!,
          SharedPreferencesFunctions.token!,
          widget.categoryId,
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data!.length == 0
                  ? Center(
                      child: Text(
                        noDataFound.tr,
                      ),
                    )
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var ds = snapshot.data![index];

                        AppFonts.dateFormatChanged(ds["created_at"]);
                        return InkWell(
                          onTap: () {
                            if (widget.categoryId == 6) {
                              goto(
                                context,
                                SeedsDetailsScreen(ds),
                              );
                            } else if (widget.categoryId == 7) {
                              goto(
                                context,
                                TyresDetailsScreen(ds),
                              );
                            } else if (widget.categoryId == 8) {
                              goto(
                                context,
                                PesticidesDetailsScreen(ds),
                              );
                            } else if (widget.categoryId == 9) {
                              goto(
                                context,
                                FertilizerDetailsScreen(ds),
                              );
                            } else if (widget.categoryId == 4) {
                              goto(
                                context,
                                HarvesterDetailsScreen(ds),
                              );
                            }else if (widget.categoryId == 5) {
                              goto(
                                context,
                                ImplementsDetailsScreen(ds),
                              );
                            } else {
                              goto(
                                context,
                                TractorDetailsScreen(ds),
                              );
                            }
                          },
                          child: Card(
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        imageUrl: widget.categoryId == 6 ||
                                                widget.categoryId == 7 ||
                                                widget.categoryId == 8 ||
                                                widget.categoryId == 9
                                            ? ds['image1']
                                            : ds["front_image"],
                                        fit: BoxFit.cover,
                                        width: 125,
                                        height: 90,
                                        placeholder: (context, url) {
                                          return Center(
                                            child: barlowRegular(
                                              text: loading.tr,
                                              size: 15,
                                              color: black,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, dynamic) {
                                          return Center(
                                            child: barlowRegular(
                                              text: noImage.tr,
                                              size: 15,
                                              color: black,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 190,
                                            child: barlowBold(
                                              text: widget.categoryId == 6 ||
                                                      // widget.categoryId == 7 ||
                                                      widget.categoryId == 8 ||
                                                      widget.categoryId == 9
                                                  ? ds['title']
                                                  : (ds["brand_name"] ?? "") +
                                                      " " +
                                                      (ds["model_name"] ?? ""),
                                              size: 16,
                                              color: black,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/rupee.png",
                                                width: 15,
                                                height: 15,
                                              ),
                                              HSpace(5),
                                              barlowBold(
                                                text:
                                                    "Rs. ${ds["price"] ?? ""}",
                                                size: 15,
                                                color: kPrimaryColor,
                                              ),
                                              HSpace(15),
                                              getStatusButtonForMyPost(ds["status"],widget.k),
                                            ],
                                          ),
                                          (widget.k == "mypost")
                                              ? SizedBox.shrink()
                                              : const SizedBox(
                                                  height: 6,
                                                ),
                                          (widget.k == "mypost")
                                              ? SizedBox.shrink()
                                              : Row(
                                                  children: [
                                                    barlowRegular(
                                                      text: "Viewed By ",
                                                      color: grey,
                                                      size: 15,
                                                    ),
                                                    HSpace(5),
                                                    barlowRegular(
                                                      text: ds['lead_name'] ??
                                                          "Unknown",
                                                      color: black,
                                                      size: 15,
                                                    )
                                                  ],
                                                ),
                                          const SizedBox(
                                            height: 6,
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: grey,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 4,
                                                    ),
                                                    child: barlowRegular(
                                                      text:
                                                          ds["city_name"] ?? "",
                                                      color: grey,
                                                      size: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              HSpace(13),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/calendar.png",
                                                    width: 15,
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 4,
                                                    ),
                                                    child: barlowRegular(
                                                      text: AppFonts.newDate
                                                          .toString(),
                                                      color: black,
                                                      size: 13,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          VSpace(5),
                                          (widget.k == "mypost")
                                              ? SizedBox.shrink()
                                              : Row(
                                                  children: [
                                                    MaterialButton(
                                                        height: 25,
                                                        color: kPrimaryColor,
                                                        onPressed: () {
                                                          String chatRoomId =
                                                              getChatRoomIdByPhoneNumbers(
                                                            SharedPreferencesFunctions
                                                                .phoneNumber
                                                                .toString(),
                                                            ds["lead_mobile"],
                                                          );
                                                          Map<String, dynamic>
                                                              chatRoomInfoMap =
                                                              {
                                                            "usersPhoneNumbers":
                                                                [
                                                              SharedPreferencesFunctions
                                                                  .phoneNumber
                                                                  .toString(),
                                                              ds["lead_mobile"],
                                                            ],
                                                            "usersDeviceTokenIds":
                                                                [
                                                              SharedPreferencesFunctions
                                                                  .deviceToken
                                                                  .toString(),
                                                              "",
                                                            ],
                                                            "ts": DateTime.now()
                                                          };
                                                          FirebaseMethods()
                                                              .createChatRoom(
                                                                  chatRoomId,
                                                                  chatRoomInfoMap)
                                                              .then(
                                                            (value) {
                                                              goto(
                                                                context,
                                                                IndividualChatScreen(
                                                                  otherUserPhoneNumber:
                                                                      ds["lead_mobile"],
                                                                  otherUserDeviceTokenId:
                                                                      "",
                                                                  chatRoomInfoMap:
                                                                      chatRoomInfoMap,
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              AppImages
                                                                  .chatImage,
                                                              width: 15,
                                                              height: 15,
                                                              color: white,
                                                            ),
                                                            HSpace(8),
                                                            barlowRegular(
                                                              text: chat.tr,
                                                              color: white,
                                                              size: 13,
                                                            ),
                                                          ],
                                                        )),
                                                    HSpace(10),
                                                    MaterialButton(
                                                      height: 25,
                                                      minWidth: 60,
                                                      color: green,
                                                      onPressed: () async {
                                                        String url =
                                                            'tel:${ds["lead_mobile"]}';
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            AppImages
                                                                .phoneImage,
                                                            width: 15,
                                                            height: 15,
                                                            color: white,
                                                          ),
                                                          HSpace(8),
                                                          barlowRegular(
                                                            text: call.tr,
                                                            color: white,
                                                            size: 13,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      },
                    )
              : (snapshot.connectionState == ConnectionState.waiting)
                  ? Center(
                      child: progressIndicator(context),
                    )
                  : Center(
                      child: barlowRegular(
                        text: noDataFound.tr,
                        size: 15,
                        color: black,
                      ),
                    );
        },
      ),
    );
  }

  getUserInfo() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    setState(() {});
  }

  getChatRoomIdByPhoneNumbers(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  _getProductName(String categoryName) {
    if(categoryName=='Tractor'){
      return tractor.tr;
    }else if(categoryName=='Goods Vehicle'){
      return goodsVehicle.tr;
    }else if(categoryName=='Harvester'){
      return harvester.tr;
    }else if(categoryName=='Implements'){
      return implement.tr;
    }else if(categoryName=='Seeds'){
      return seeds.tr;
    }else if(categoryName=='Tyres'){
      return tyre.tr;
    }else if(categoryName=='Pesticides'){
      return pesticides.tr;
    }else{
      return fertilizer.tr;
    }
  }
}
