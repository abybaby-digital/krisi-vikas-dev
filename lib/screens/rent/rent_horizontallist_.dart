import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import '../../const/colors.dart';
import '../../const/distance_calculation.dart';
import '../../services/api_methods.dart';
import '../../services/save_user_info.dart';
import '../../widgets/all_widgets.dart';
import '../../widgets/distence_widget.dart';

class RentHorizontalList extends StatefulWidget {
  final String category;
  final int categoryId;
  final String type;

  RentHorizontalList({
    Key? key,
    required this.category,
    required this.categoryId,
    required this.type,
  }) : super(key: key);

  @override
  State<RentHorizontalList> createState() => _RentHorizontalListState();
}

class _RentHorizontalListState extends State<RentHorizontalList> {
  String url = "";

  String otherDistrictUrl = "";

  List newTractorsList = [];

  late final Future<List<dynamic>> _futureList;

  @override
  void initState() {
    chechType();
    super.initState();

    print('rent_view');
    this._futureList = doThisONLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: this._futureList,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: white,
          body: snapshot.hasData
              ? snapshot.data!.length == 0
              ? Center(
            child: barlowRegular(
              text: noDataFound.tr,
              color: black,
              size: 15,
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(
              left: 11.0,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newTractorsList.length,
              itemBuilder: (context, index) {
                var ds = newTractorsList[index];

                return Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (widget.categoryId == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HarvesterDetailsScreen(ds),
                          ),
                        );
                      } else if (widget.categoryId == 5) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ImplementsDetailsScreen(ds),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TractorDetailsScreen(ds),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: grey,
                            blurRadius: 2,
                          )
                        ],
                      ),
                      height: fullHeight(context) * 0.5,
                      width: fullWidth(context) * 0.6,
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight:
                                          Radius.circular(8)),
                                      child: CachedNetworkImage(
                                        imageUrl: ds["front_image"],
                                        fit: BoxFit.cover,
                                        width: fullWidth(context),
                                        height:
                                        0.24 * fullHeight(context),
                                        placeholder: (context, url) {
                                          return Center(
                                            child: barlowRegular(
                                              text: loading.tr,
                                              size: 15,
                                              color: black,
                                            ),
                                          );
                                        },
                                        errorWidget:
                                            (context, url, dynamic) {
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
                                    ds["status"]== 4 ? SizedBox(
                                      height: 50,
                                      width: 100,
                                      child: Image.asset("assets/sold_tag.png"),):Container()
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  child: barlowBoldForHome(
                                    text: (ds["brand_name"] ?? "") +
                                        " " +
                                        (ds["model_name"] ?? ""),
                                    size: 16,
                                    color: black,
                                    maxLine: 1,
                                  ),
                                ),
                                Divider(
                                  color: grey,
                                  indent: 10,
                                  endIndent: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      top: 2.0,
                                      right: 10.0,
                                      bottom: 6.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons
                                                  .location_on_outlined,
                                              color: grey,
                                              size: 18,
                                            ),
                                            Expanded(
                                              child:
                                              barlowRegularForHome(
                                                text:
                                                ds["city_name"] ??
                                                    "",
                                                color: grey,
                                                size: 13,
                                                maxLine: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            barlowBold(
                                              text: "₹ ",
                                              size: 18,
                                              color: kPrimaryColor,
                                            ),
                                            Expanded(
                                              child: barlowBold(
                                                text:
                                                "${ds["price"] ?? ""}${(ds['rent_type']).toString().replaceAll('Per', '/')}",
                                                size: 15,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ShowDistanceHorizontal(
                                    UserData.lat,
                                    UserData.long,
                                    ds['latlong'].toString())
                              ],
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 0.48 * fullHeight(context),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset(
                                            'assets/WaterMark.png',
                                            fit: BoxFit.cover,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
          ),
        );
      },
    );
  }

  Future<List<dynamic>> doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    getUrlByCategory();

    List tractorsList = await ApiMethods().getTractorsByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      widget.type,
      0,
      7,
      currentLocation!,
      "dashboard",
    );

    try {
      this.newTractorsList = [];
      this.newTractorsList.addAll(tractorsList);
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    }

    return Future.value(this.newTractorsList);
  }

  chechType() {
    if (widget.categoryId == 1) {
      tractorType = rent_a.tr;
    } else if (widget.categoryId == 3) {
      gvType = rent_a.tr;
    } else if (widget.categoryId == 4) {
      harvesterType = rent_a.tr;
    } else if (widget.categoryId == 5) {
      implementType = rent_a.tr;
    }
  }

  getUrlByCategory() {
    if (widget.categoryId == 1) {
      url = baseUrl + tractorDataUrl;
      tractorTabType = "rent";
    } else if (widget.categoryId == 3) {
      url = baseUrl + goodsVehicleUrlData;
      gvTabType = "rent";
    } else if (widget.categoryId == 4) {
      url = baseUrl + harvesterUrlData;
      harvesterTabType = "rent";
    } else if (widget.categoryId == 5) {
      url = baseUrl + implementsUrlData;
      implementTabType = "rent";
    }
  }
}
