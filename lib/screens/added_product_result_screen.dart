import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../language/language_key.dart';
import 'home/home_screen.dart';
import 'package:http/http.dart' as http;

class AddedProductResultScreen extends StatefulWidget {
  final int tractorId;

  AddedProductResultScreen(
    this.tractorId,
  );

  @override
  State<AddedProductResultScreen> createState() =>
      _AddedProductResultScreenState();
}

class _AddedProductResultScreenState extends State<AddedProductResultScreen> {
  String url = "";

  var dateFormat;

  List<Map> SliderList = [];

  List<dynamic> ItemData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getApiUrlByCategoryId();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        gotoWithoutBack(
          context,
          HomeScreen(),
        );
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: grey,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              goto(
                context,
                HomeScreen(),
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
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(
            //     Icons.favorite_outline,
            //     color: darkgreen,
            //   ),
            // ),
            IconButton(
              onPressed: () async {
                if (ItemData[0]["id"] != null &&
                    ItemData[0]["category_id"] != null) {
                  var title = "";

                  if (CategoryIdWhilePosting == "6" ||
                      CategoryIdWhilePosting == "7" ||
                      CategoryIdWhilePosting == "8" ||
                      CategoryIdWhilePosting == "9") {
                    title = ItemData[0]["title"].toString();
                  } else {
                    title = ItemData[0]["brand_name"].toString() +
                        ItemData[0]["model_name"].toString();
                  }

                  var descriptionData = ItemData[0]["description"] ?? "";
                  var imageData =
                      ItemData[0]["front_image"] ?? AppImages.frontImage;
                  dynamicLinkService
                      .createDynamicLink(
                          (ItemData[0]["id"].toString()),
                          ItemData[0]["category_id"].toString(),
                          title,
                          descriptionData,
                          imageData)
                      .then((newDynamicLink) async {
                    print(
                        newDynamicLink + " Dynamic Link on click Share Button");

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
                Icons.share_outlined,
                color: darkgreen,
              ),
            ),
          ],
        ),
        body: FutureBuilder<List>(
          future: ApiMethods().getSingleTractorInfoById(
              url,
              SharedPreferencesFunctions.userId!,
              SharedPreferencesFunctions.token!,
              widget.tractorId),
          builder: (context, snapshot) {
            dateFormat = snapshot;
            return snapshot.hasData
                ? snapshot.data!.length == 0
                    ? Center(
                        child: barlowRegular(
                          text: noDataFound.tr,
                          color: black,
                          size: 15,
                        ),
                      )
                    : Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 350,
                                child: (CategoryIdWhilePosting == "6" ||
                                        CategoryIdWhilePosting == "7" ||
                                        CategoryIdWhilePosting == "8" ||
                                        CategoryIdWhilePosting == "9")
                                    ? Row(
                                        children: [
                                          snapshot.data![0]["image1"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]["image1"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.leftImage,
                                                  SliderList,
                                                  0,
                                                  context)
                                              : SizedBox.shrink(),
                                          snapshot.data![0]["image2"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]["image2"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.rightImage,
                                                  SliderList,
                                                  1,
                                                  context)
                                              : SizedBox.shrink(),
                                          snapshot.data![0]["image3"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]["image3"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.frontImage,
                                                  SliderList,
                                                  2,
                                                  context)
                                              : SizedBox.shrink(),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          snapshot.data![0]["front_image"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]
                                                      ["front_image"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.leftImage,
                                                  SliderList,
                                                  0,
                                                  context)
                                              : SizedBox.shrink(),
                                          snapshot.data![0]["right_image"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]
                                                      ["right_image"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.rightImage,
                                                  SliderList,
                                                  1,
                                                  context)
                                              : SizedBox.shrink(),
                                          snapshot.data![0]["left_image"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]
                                                      ["left_image"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.frontImage,
                                                  SliderList,
                                                  2,
                                                  context)
                                              : SizedBox.shrink(),
                                          snapshot.data![0]["back_image"] != ""
                                              ? CachedNetworkImgForSlider(
                                                  snapshot.data![0]
                                                      ["back_image"],
                                                  fullWidth(context),
                                                  350,
                                                  AppImages.backImage,
                                                  SliderList,
                                                  3,
                                                  context)
                                              : SizedBox.shrink(),
                                          (CategoryIdWhilePosting == "4" ||
                                                  CategoryIdWhilePosting == "5")
                                              ? SizedBox.shrink()
                                              : snapshot.data![0]
                                                          ["meter_image"] !=
                                                      ""
                                                  ? CachedNetworkImgForSlider(
                                                      snapshot.data![0]
                                                          ["meter_image"],
                                                      fullWidth(context),
                                                      350,
                                                      AppImages.meterImage,
                                                      SliderList,
                                                      4,
                                                      context)
                                                  : SizedBox.shrink(),
                                          (CategoryIdWhilePosting == "4" ||
                                                  CategoryIdWhilePosting == "5")
                                              ? SizedBox.shrink()
                                              : snapshot.data![0]
                                                          ["tyre_image"] !=
                                                      ""
                                                  ? CachedNetworkImgForSlider(
                                                      snapshot.data![0]
                                                          ["tyre_image"],
                                                      fullWidth(context),
                                                      350,
                                                      AppImages.tyreImage,
                                                      SliderList,
                                                      5,
                                                      context)
                                                  : SizedBox.shrink(),
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
                                      child: (CategoryIdWhilePosting == "6" ||
                                              CategoryIdWhilePosting == "8" ||
                                              CategoryIdWhilePosting == "9")
                                          ? Row(
                                              children: [
                                                Text(
                                                  snapshot.data![0]["title"] ??
                                                      "",
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : CategoryIdWhilePosting == "7"
                                              ? SizedBox.shrink()
                                              : Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data![0]
                                                              ["brand_name"] ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(" "),
                                                    Text(
                                                      snapshot.data![0]
                                                              ["model_name"] ??
                                                          "",
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 13,
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                              "${snapshot.data![0]["state_name"] ?? ""}"),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          const Icon(
                                            Icons.access_time_outlined,
                                            size: 18,
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          barlowRegular(
                                            text: snapshot.data![0]
                                                    ["created_at"]
                                                .toString()
                                                .substring(0, 10),
                                            color: black,
                                            size: 13,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: barlowRegular(
                                        text:
                                            "Rs.${snapshot.data![0]["price"].toString()}",
                                        color: black,
                                        size: 13,
                                      ),
                                    ),
                                    VSpace(10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            status.tr,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            pending.tr,
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    snapshot.data![0]["description"] == null
                                        ? SizedBox.shrink()
                                        : Container(
                                            height: 50,
                                            width: double.infinity,
                                            color: greyShade100,
                                            child: Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                description.tr,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                    snapshot.data![0]["description"] == null
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Text(
                                              snapshot.data![0]
                                                      ["description"] ??
                                                  "",
                                            ),
                                          ),
                                    // Container(
                                    //   height: 50,
                                    //   width: double.infinity,
                                    //   color: greyShade100,
                                    //   child: Padding(
                                    //     padding: EdgeInsets.all(15.0),
                                    //     child: Text(
                                    //       additionalDetails.tr,
                                    //       style: TextStyle(
                                    //         fontSize: 15,
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    (CategoryIdWhilePosting == "6" ||
                                            CategoryIdWhilePosting == "7" ||
                                            CategoryIdWhilePosting == "8" ||
                                            CategoryIdWhilePosting == "9")
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              top: 15,
                                              left: 25,
                                              right: 25,
                                            ),
                                            child: buildAdditionalDetail(snapshot.data![0]),
                                          ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                : Center(
                    child: progressIndicator(context),
                  );
          },
        ),
      ),
    );
  }

  getApiUrlByCategoryId() {
    if (CategoryIdWhilePosting == "1") {
      url = baseUrl + tractorByIdUrl;
    } else if (CategoryIdWhilePosting == "3") {
      url = baseUrl + goodsVehicalByIdUrl;
    } else if (CategoryIdWhilePosting == "4") {
      url = baseUrl + harvesterByIdUrl;
    } else if (CategoryIdWhilePosting == "5") {
      url = baseUrl + implementsByIdUrl;
    } else if (CategoryIdWhilePosting == "6") {
      url = baseUrl + seedsByIdUrl;
    } else if (CategoryIdWhilePosting == "7") {
      url = baseUrl + tyresByIdUrl;
    } else if (CategoryIdWhilePosting == "8") {
      url = baseUrl + pesticidesByIdUrl;
    } else if (CategoryIdWhilePosting == "9") {
      url = baseUrl + fertilizerByIdUrl;
    }
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    getItem(widget.tractorId);
    if (mounted) {
      setState(() {});
    }
  }

  Widget buildAdditionalDetail(data) {
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
                    text: data["rc_available"] == "true" ? yes.tr : no.tr,
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
                    text: data["noc_available"] == "true" ? yes.tr : no.tr,
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
                    text: data["registration_no"].toString(),
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
                    text: data["year_of_purchase"].toString(),
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
                    text: data["is_negotiable"] == "true" ? yes.tr : no.tr,
                    size: 14,
                    color: black,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 2),
        //   child: Container(
        //     color: greyShade100,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: const [
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "HP Category",
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "41-45 HP",
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 4),
        //   child: Container(
        //     color: greyShade100,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: const [
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "Gear Box",
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "8 Forward + 2 Reverse",
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 4),
        //   child: Container(
        //     color: greyShade100,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: const [
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "Lifting Capacity",
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "1600-1700 Kg",
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 4),
        //   child: Container(
        //     color: greyShade100,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: const [
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "Clutch",
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "Single / Dual Optional",
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 4),
        //   child: Container(
        //     color: greyShade100,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: const [
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "Warranty",
        //             style: TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: Text(
        //             "2000 Hours / 2 Year",
        //             style: TextStyle(
        //               fontSize: 14,
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Future<List<dynamic>> getItem(int DataId) async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    Future newTractorsList = ApiMethods().getSingleTractorInfoByIdAll(
        url,
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        DataId);

    try {
      // this.ItemData = [];
      // this.ItemData.addAll(newTractorsList);
      ItemData = await newTractorsList;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    print("newTractorsList in function  getItem");
    print(newTractorsList);
    print("ItemData in function  getItem");
    print(ItemData);

    if (mounted) {
      setState(() {
        getListForSlider(ItemData);
      });
    }

    return Future.value(ItemData);
  }

  getListForSlider(ItemData) async {
    // print("ItemData[0]");
    // print(ItemData[0]);
    print("ItemData");
    print(ItemData);
    if (ItemData.isNotEmpty) {
      if ((CategoryIdWhilePosting == "6" ||
          CategoryIdWhilePosting == "7" ||
          CategoryIdWhilePosting == "8" ||
          CategoryIdWhilePosting == "9")) {
        if (ItemData[0]['image1'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = '';
          SliderListItem["imageItem"] = ItemData[0]['image1'];
          SliderListItem["itemIndex"] = 0;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['image2'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = '';
          SliderListItem["imageItem"] = ItemData[0]['image2'];
          SliderListItem["itemIndex"] = 1;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['image3'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = '';
          SliderListItem["imageItem"] = ItemData[0]['image3'];
          SliderListItem["itemIndex"] = 2;
          SliderList.add(SliderListItem);
        }
        print("seed");
        print(SliderList);
      }

      if ((CategoryIdWhilePosting == "1" || CategoryIdWhilePosting == "3")) {
        if (ItemData[0]['front_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Front View';
          SliderListItem["imageItem"] = ItemData[0]['front_image'];
          SliderListItem["itemIndex"] = 0;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['right_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Right View';
          SliderListItem["imageItem"] = ItemData[0]['right_image'];
          SliderListItem["itemIndex"] = 1;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['left_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Left View';
          SliderListItem["imageItem"] = ItemData[0]['left_image'];
          SliderListItem["itemIndex"] = 2;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['back_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Back View';
          SliderListItem["imageItem"] = ItemData[0]['back_image'];
          SliderListItem["itemIndex"] = 3;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['meter_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Meter View';
          SliderListItem["imageItem"] = ItemData[0]['meter_image'];
          SliderListItem["itemIndex"] = 4;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['tyre_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = "Tyre View";
          SliderListItem["imageItem"] = ItemData[0]['tyre_image'];
          SliderListItem["itemIndex"] = 5;
          SliderList.add(SliderListItem);
        }

        print("Tractor");
        print(SliderList);
      }
      if ((CategoryIdWhilePosting == "4" || CategoryIdWhilePosting == "5")) {
        if (ItemData[0]['front_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Front View';
          SliderListItem["imageItem"] = ItemData[0]['front_image'];
          SliderListItem["itemIndex"] = 0;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['right_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Right View';
          SliderListItem["imageItem"] = ItemData[0]['right_image'];
          SliderListItem["itemIndex"] = 1;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['left_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Left View';
          SliderListItem["imageItem"] = ItemData[0]['left_image'];
          SliderListItem["itemIndex"] = 2;
          SliderList.add(SliderListItem);
        }
        if (ItemData[0]['back_image'] != "") {
          Map SliderListItem = Map();
          SliderListItem["title"] = 'Back View';
          SliderListItem["imageItem"] = ItemData[0]['back_image'];
          SliderListItem["itemIndex"] = 3;
          SliderList.add(SliderListItem);
        }
        print("Implement");
        print(SliderList);
      }
    } else {
      Map SliderListItem = Map();
      print("Slider Not Found");
    }

    if (mounted) {
      setState(() {});
    }
  }
}
