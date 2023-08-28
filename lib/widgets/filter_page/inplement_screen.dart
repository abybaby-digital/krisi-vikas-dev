import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/widgets/filter_page/varieble_const.dart';
import 'package:http/http.dart' as http;
import '../../Screens/home/home_screen.dart';
import '../../Screens/tractor/data.dart';
import '../../const/api_urls.dart';
import '../../const/colors.dart';
import '../../const/fonts.dart';
import '../../language/language_key.dart';
import '../../language/language_key.dart';
import '../../services/save_user_info.dart';
import '../all_widgets.dart';
import '../distence_widget.dart';
import 'Api/api_method.dart';
import 'Model/implement_model.dart';
import 'ShowBottomSheet.dart';
import 'implement_screen_details.dart';

class ImplementScreen extends StatefulWidget {
  final String type;
  final String categoryId;
  final String currentTabType;

  const ImplementScreen(
      {Key? key,
        required this.type,
        required this.currentTabType,
        required this.categoryId})
      : super(key: key);

  @override
  State<ImplementScreen> createState() => _ImplementScreenState();
}

class _ImplementScreenState extends State<ImplementScreen> {
  String sortBy = '';
  bool isChecked = false;
  List<Implement> filterData = [];
  List initDataList = [];
  List<Implement> listData = [];
  bool filterFlag = false;
  PageController _pageController = PageController();
  int selectedIndex = 0;
  String url = "";
  bool isDataObtained = true;

  // check() {
  //   if (widget.type.index == 0) {
  //     typeScreen = "Rent";
  //   } else if (widget.type.index == 1) {
  //     typeScreen = "Used";
  //   } else {
  //     typeScreen = "New";
  //   }
  // }

  @override
  void initState() {
    super.initState();
    //category = widget.categoryId;
    implementModelFilterData(
        brandId, districtId, stateId, priceStart, priceEnd, byYear);
    _pageController = PageController(initialPage: selectedIndex);
    // check();
  }

  @override
  Widget build(BuildContext context) {
    listData = filterData.isEmpty ? listData : listData;
    return WillPopScope(
      onWillPop: () async {
        gotoWithoutBack(
          context,
          HomeScreen(),
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              color: darkgreen,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Open menu
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.currentTabType} ${widget.type.toString()}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                child: isDataObtained
                    ? Expanded(
                  child: Center(
                    child: progressIndicator(context),
                  ),
                )
                    : Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  sortFieldSheet(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                            .withOpacity(0.2)),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(sort.tr),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 4;
                                    _pageController = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet.show(
                                      context,
                                      _pageController,
                                      selectedIndex,
                                      widget.type,
                                      "${widget.currentTabType}",
                                      "${widget.categoryId.toString()}");
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                            .withOpacity(0.2)),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(price.tr),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                    _pageController = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet.show(
                                      context,
                                      _pageController,
                                      selectedIndex,
                                      widget.type,
                                      "${widget.currentTabType}",
                                      "${widget.categoryId.toString()}");
                                },
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                            .withOpacity(0.2)),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(brands.tr),
                                        Icon(Icons.arrow_drop_down)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = selectedIndex;
                                    _pageController = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet.show(
                                      context,
                                      _pageController,
                                      selectedIndex,
                                      widget.type,
                                      "${widget.currentTabType}",
                                      "${widget.categoryId.toString()}");
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black
                                            .withOpacity(0.2)),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(more.tr),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      listData.isEmpty && listData.length == 0
                          ? Expanded(
                        child: Center(
                          child: barlowRegular(
                            text: noDataFound.tr,
                            size: 15,
                            color: black,
                          ),
                        ),
                      )
                          : Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height:
                          MediaQuery.of(context).size.height /
                              1.3,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              itemCount: listData.length,
                              itemBuilder: (context, index) {
                                Implement ds = listData[index];
                                return InkWell(
                                  onTap: () {
                                    goto(
                                        context,
                                        ImplementScreenDetails(
                                          ds: ds,
                                        ));
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8),
                                                  child:
                                                  CachedNetworkImage(
                                                    imageUrl:
                                                    listData[index]
                                                        .frontImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    width: 125,
                                                    height: 90,
                                                    placeholder:
                                                        (context, url) {
                                                      return Center(
                                                        child:
                                                        barlowRegular(
                                                          text: loading
                                                              .tr,
                                                          size: 15,
                                                          color: black,
                                                        ),
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url,
                                                        dynamic) {
                                                      return Center(
                                                        child:
                                                        barlowRegular(
                                                          text: noImage
                                                              .tr,
                                                          size: 15,
                                                          color: black,
                                                        ),
                                                      );
                                                    },
                                                  )),
                                              ds.status == 4? SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: Image.asset("assets/sold_tag.png"),):Container()
                                            ],
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: barlowBold(
                                                          text: (ds.brandName ??
                                                              "") +
                                                              " " +
                                                              (ds.modelName ??
                                                                  ""),
                                                          size: 16,
                                                          color: black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      HSpace(5),
                                                      barlowBold(
                                                        text: "Rs. ${ds.price ?? ""}" +
                                                            ((
                                                                ds.datumSet == 'rent')
                                                                ? "${(ds.rentType).toString().replaceAll('Per', '/')}"
                                                                : ""),
                                                        size: 17,
                                                        color: kPrimaryColor,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        size: 16,
                                                        color: grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .only(left: 4,right: 4),
                                                        child: barlowRegular(
                                                          text:
                                                          ds.cityName ??
                                                              "",
                                                          color: black,
                                                          size: 13,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/calendar.png",
                                                            width: 15,
                                                            height: 15,
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .only(left: 4),
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
                                                  VSpace(6),
                                                  ShowDistanceVertical(
                                                      UserData.lat,
                                                      UserData.long,
                                                      ds.latlong.toString())
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<List<Implement>?> implementModelFilterData(
      String brandId,
      String districtId,
      String stateId,
      String priceStart,
      String priceEnd,
      String byYear) async {
    Map data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "set": type,
      "type": condition,
      "price_start": priceStart,
      "price_end": priceEnd,
      "skip": "0",
      "take": "10",
      "purchase_year": byYear,
      "model": "",
      "brand": brandId,
      "district": districtId,
      "state": stateId
    };
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(Uri.parse(baseUrl + implementsFiltertUrl),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: '*',
        },
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      final List<Implement> ListTractorData =
      ImplementModel.fromJson(responseData).data.toList();
      listData = ListTractorData;
      isDataObtained = false;
      setState(() {});
      return listData;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }

  void lowToHighMethod() {
    if (listData[0].price.runtimeType == String) {
      listData.sort((a, b) => int.parse(a.price.toString())
          .compareTo(int.parse(b.price.toString())));
      setState(() {});
    } else {
      listData.sort((a, b) => a.price.compareTo(b.price));
      setState(() {});
    }
  }

  void highToLowMethod() {
    if (listData[0].price.runtimeType == String) {
      listData.sort((a, b) => int.parse(b.price.toString())
          .compareTo(int.parse(a.price.toString())));
      setState(() {});
    } else {
      listData.sort((a, b) => b.price.compareTo(a.price));
      setState(() {});
    }
  }

  // void sortByDateMethod() {
  //   listData.sort(
  //     (a, b) => b.createdAt.compareTo(a.createdAt),
  //   );
  // }

  sortFieldSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                ),
                child: barlowRegular(
                  text: sortByData.tr,
                  size: 15,
                  color: grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: grey,
                height: 1,
                thickness: 0.5,
              ),
              // ListTile(
              //   trailing: Radio<String>(
              //     value: newest_first.tr,
              //     groupValue: sortBy,
              //     onChanged: (value) {
              //       setState(
              //         () {
              //           sortByDateMethod();
              //           sortBy = value!;
              //           Navigator.pop(context);
              //         },
              //       );
              //     },
              //   ),
              //   title: barlowSemiBold(
              //     text: newFirst.tr,
              //     color: black,
              //     size: 17,
              //   ),
              // ),
              ListTile(
                trailing: Radio<String>(
                  value: low.tr,
                  groupValue: sortBy,
                  onChanged: (value) {
                    setState(
                          () {
                        sortBy = value!;
                        lowToHighMethod();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                title: barlowSemiBold(
                  text: lowToHigh.tr,
                  color: black,
                  size: 17,
                ),
              ),
              ListTile(
                trailing: Radio<String>(
                  value: high.tr,
                  groupValue: sortBy,
                  onChanged: (value) {
                    setState(
                          () {
                        sortBy = value!;
                        highToLowMethod();
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                title: barlowSemiBold(
                  text: highToLow.tr,
                  color: black,
                  size: 17,
                ),
              ),
              VSpace(20),
            ],
          ),
        );
      },
    );
  }
}
