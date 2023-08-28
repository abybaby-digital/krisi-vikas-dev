import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:krishivikas/widgets/filter_page/pesticides_filter_deatils_screen.dart';
import 'package:krishivikas/widgets/filter_page/varieble_const.dart';
import '../../Screens/home/home_screen.dart';
import '../../Screens/tractor/data.dart';
import '../../const/api_urls.dart';
import '../../const/colors.dart';
import '../../const/fonts.dart';
import '../../language/language_key.dart';
import 'package:http/http.dart' as http;
import '../../services/save_user_info.dart';
import '../../widgets/all_widgets.dart';
import '../../widgets/distence_widget.dart';
import 'Api/api_method.dart';
import 'Model/pesticides_model.dart';
import 'ShowBottomSheet1.dart';

class PesticidesScreen extends StatefulWidget {
  final String type;

  const PesticidesScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<PesticidesScreen> createState() => _PesticidesScreenState();
}

class _PesticidesScreenState extends State<PesticidesScreen> {
  String sortBy = '';
  bool isChecked = false;
  List<PesticideDatum> filterData = [];
  List initDataList = [];
  List<PesticideDatum> listData = [];
  bool filterFlag = false;
  int selectedIndex = 0;
  String url = "";
  bool isDataObtained = true;
  PageController _page1Controller = PageController();


  // check() {
  //   if (widget.type.index == 0) {
  //     typeScreen = "Rent";
  //   } else if (widget.type.index == 1) {
  //     typeScreen = "Used";
  //   } else {
  //     typeScreen = "New";
  //   }
  // }
  //
  // checkType() {
  //   if (widget.type == "old") {
  //     type = "buy";
  //     condition = "old";
  //   } else {
  //     type = "buy";
  //     condition = "new";
  //   }
  // }

  @override
  void initState() {
    super.initState();
    PesticidesFilterData(districtId, stateId, priceStart, priceEnd);
    _page1Controller = PageController(initialPage: selectedIndex);
    // check();
    //checkType();
  }

  @override
  Widget build(BuildContext context) {
    listData = filterData.isEmpty ? listData : listData;
    return WillPopScope(
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    },
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10,),
                  Text("${widget.type}",
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
                                  sortFieldSheet();
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
                                    selectedIndex = 2;
                                    _page1Controller = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet1.show1(
                                      context,
                                      _page1Controller,
                                      selectedIndex,
                                      widget.type);
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
                                    _page1Controller = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet1.show1(
                                      context,
                                      _page1Controller,
                                      selectedIndex,
                                      widget.type);
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
                                        Text(states.tr),
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
                                    _page1Controller = PageController(
                                        initialPage: selectedIndex);
                                  });
                                  ShowBottomSheet1.show1(
                                      context,
                                      _page1Controller,
                                      selectedIndex,
                                      widget.type);
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
                                  child:  Center(
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
                              itemCount: listData.length,
                              itemBuilder: (context, index) {
                                PesticideDatum ds =
                                listData[index];
                                return InkWell(
                                  onTap: () {
                                    goto(
                                        context,
                                        PesticidesFilterDetailsScreen(ds: ds,));
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
                                                        .image1
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
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 190,
                                                  child: barlowBold(
                                                    text: ds.title! + " ",
                                                    size: 16,
                                                    color: black,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    HSpace(5),
                                                    barlowBold(
                                                      text:
                                                      "Rs. ${ds.price ?? ""}",
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
                                                              .only(left: 4),
                                                          child: barlowRegular(
                                                            text:
                                                            ds.cityName ??
                                                                "",
                                                            color: black,
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
                                                          const EdgeInsets
                                                              .only(left: 4),
                                                          child: barlowRegular(
                                                            text: AppFonts.newDate
                                                                .toString(),
                                                            color: black,
                                                            size: 13,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                ShowDistanceVertical(UserData.lat,UserData.long,ds.latlong.toString())
                                              ],
                                            ),
                                          )
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
      onWillPop: () async {
        gotoWithoutBack(
          context,
          HomeScreen(),
        );
        return Future.value(true);
      },
    );
  }
  void lowToHighMethod() {
    if (listData[0].price.runtimeType == String) {
      listData.sort(
              (a, b) => int.parse(a.price.toString()).compareTo(int.parse(b.price.toString())));
      setState(() {});
    } else {
      listData.sort((a, b) => a.price.toString().compareTo(b.price.toString()));
      setState(() {});
    }
  }

  void highToLowMethod() {
    if (listData[0].price.runtimeType == String) {
      listData.sort(
              (a, b) => int.parse(b.price.toString()).compareTo(int.parse(a.price.toString())));
      setState(() {});
    } else {
      listData.sort((a, b) => b.price.toString().compareTo(a.price.toString()));
      setState(() {});
    }
  }

  // void sortByDateMethod() {
  //   listData.sort(
  //         (a, b) => b.createdAt.toString().compareTo(a.createdAt.toString()),
  //   );
  // }
  sortFieldSheet() {
    showModalBottomSheet<void>(
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
              //             () {
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
                  value: 'High to Low',
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
  Future<List<PesticideDatum>?> PesticidesFilterData(String districtId,String stateId,String priceStart,String priceEnd) async {
    Map data = {"user_id":SharedPreferencesFunctions.userId,"user_token":SharedPreferencesFunctions.token,"price_start":priceStart,"price_end":priceEnd,"skip":"0","take":"100","district":districtId,"state":stateId};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + pesticidesFilterUrl),
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
      final List<PesticideDatum> ListPesticidesData = PesticidesModel.fromJson(responseData).data.toList();
      listData = ListPesticidesData;
      isDataObtained = false;
      setState(() {});
      return listData;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }

}
