import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../language/language_key.dart';
import 'home/home_screen.dart';

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

  List ItemData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    getApiUrlByCategoryId();
    getListForSlider();
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
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_outline,
                color: darkgreen,
              ),
            ),
            IconButton(
              onPressed: () {},
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
                                child: (TractorData.categoryId == 6 ||
                                        TractorData.categoryId == 7 ||
                                        TractorData.categoryId == 8 ||
                                        TractorData.categoryId == 9)
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
                                          (TractorData.categoryId == 4 ||
                                                  TractorData.categoryId == 5)
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
                                          (TractorData.categoryId == 4 ||
                                                  TractorData.categoryId == 5)
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
                            top: 250,
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
                                      child: (TractorData.categoryId == 6 ||
                                              TractorData.categoryId == 8 ||
                                              TractorData.categoryId == 9)
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
                                          : TractorData.categoryId == 7
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
                                    Container(
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
                                    Padding(
                                      padding: EdgeInsets.all(15.0),
                                      child: Text(
                                        snapshot.data![0]["description"] ?? "",
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: double.infinity,
                                      color: greyShade100,
                                      child: Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Text(
                                          additionalDetails.tr,
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    (TractorData.categoryId == 6 ||
                                            TractorData.categoryId == 7 ||
                                            TractorData.categoryId == 8 ||
                                            TractorData.categoryId == 9)
                                        ? SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                              top: 15,
                                              left: 25,
                                              right: 25,
                                            ),
                                            child: buildAdditionalDetail(),
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
    if (TractorData.categoryId == 1) {
      url = baseUrl + tractorByIdUrl;
    } else if (TractorData.categoryId == 3) {
      url = baseUrl + goodsVehicalByIdUrl;
    } else if (TractorData.categoryId == 4) {
      url = baseUrl + harvesterByIdUrl;
    } else if (TractorData.categoryId == 5) {
      url = baseUrl + implementsByIdUrl;
    } else if (TractorData.categoryId == 6) {
      url = baseUrl + seedsByIdUrl;
    } else if (TractorData.categoryId == 7) {
      url = baseUrl + tyresByIdUrl;
    } else if (TractorData.categoryId == 8) {
      url = baseUrl + pesticidesByIdUrl;
    } else if (TractorData.categoryId == 9) {
      url = baseUrl + fertilizerByIdUrl;
    }
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    ItemData = ApiMethods().getSingleTractorInfoById(
        url,
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        widget.tractorId) as List;

    setState(() {});
  }

  Widget buildAdditionalDetail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            color: greyShade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "HP Category",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "41-45 HP",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: greyShade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Gear Box",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "8 Forward + 2 Reverse",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: greyShade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Lifting Capacity",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "1600-1700 Kg",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: greyShade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Clutch",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Single / Dual Optional",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(
            color: greyShade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Warranty",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "2000 Hours / 2 Year",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  getListForSlider() async {
    if ((TractorData.categoryId == 6 ||
        TractorData.categoryId == 7 ||
        TractorData.categoryId == 8 ||
        TractorData.categoryId == 9)) {
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
    }

    if ((TractorData.categoryId == 1 || TractorData.categoryId == 3)) {
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
    }
    if ((TractorData.categoryId == 4 || TractorData.categoryId == 5)) {
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
    }
  }
}
