import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/fonts.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/const/utils.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/filter/filter_screen_tyre.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/custom_header_button.dart';

import '../../Screens/tractor/data.dart';
import '../../widgets/distence_widget.dart';
import '../../widgets/filter_page/ShowBottomSheet.dart';
import '../../widgets/filter_page/screen/brand_page.dart';
import '../../widgets/filter_page/screen/district_screen.dart';
import '../../widgets/filter_page/screen/manufacturing_screen.dart';
import '../../widgets/filter_page/screen/price_page.dart';
import '../../widgets/filter_page/screen/state_screen.dart';
import '../../widgets/filter_page/varieble_const.dart';

class TyresAdsVerticalList extends StatefulWidget {
  final String? categoryName;
  final int? categoryId;

  const TyresAdsVerticalList({this.categoryName, this.categoryId});

  @override
  State<TyresAdsVerticalList> createState() => _TyresAdsVerticalListState();
}

class _TyresAdsVerticalListState extends State<TyresAdsVerticalList> {
  var ds;

  List filterData = [];

  String url = "";

  String currentTabType = "";
  String currentType = "";

  List initDataList = [];

  bool isDataObtained = true;

  String sortBy = '';

  List listData = [];

  bool filterFlag = false;
  bool isChecked = false;
  PageController _pageController = PageController();
  int selectedIndex = 0;
  checkType() {
    if (currentTabType == "old") {
      condition = "old";
    } else {
      condition = "new";
    }
  }

  bool loadData = false;
  int numSkip = 0;
  bool loadMoreData = true;


  @override
  void initState() {
    super.initState();
    checkType();
    category = widget.categoryId.toString();

    _pageController = PageController(initialPage: selectedIndex);
    doThisONLaunch();
    Utils.getUserCurrentLocationUtils();
  }
  @override
  Widget build(BuildContext context) {
    listData = filterData.isEmpty
        ? filterFlag
        ? []
        : initDataList
        : filterData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: "${currentType} ${widget.categoryName.toString()}",
          size: 20,
          color: white,
        ),
      ),
      body: Container(
        child: isDataObtained
            ? Center(
          child: progressIndicator(context),
        )
            : Column(
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: sortFieldSheet,
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        checkType();
                        setState(() {
                          selectedIndex = 4;
                          _pageController = PageController(
                              initialPage: selectedIndex);
                        });
                        ShowBottomSheet.show(
                          context,
                          _pageController,
                          selectedIndex,
                          "${widget.categoryName.toString()}",
                          "${currentType.toString()}",
                          "${widget.categoryId.toString()}",);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(price_page.tr),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        checkType();
                        setState(() {
                          selectedIndex = 0;
                          _pageController = PageController(
                              initialPage: selectedIndex);
                        });
                        ShowBottomSheet.show(
                          context,
                          _pageController,
                          selectedIndex,
                          "${widget.categoryName.toString()}",
                          "${currentType.toString()}",
                          "${widget.categoryId.toString()}",);
                      },
                      child: Container(
                        height: 40,
                        width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        checkType();
                        setState(() {
                          selectedIndex = selectedIndex;
                          _pageController = PageController(
                              initialPage: selectedIndex);
                        });
                        ShowBottomSheet.show(
                          context,
                          _pageController,
                          selectedIndex,
                          "${widget.categoryName.toString()}",
                          "${currentType.toString()}",
                          "${widget.categoryId.toString()}",);
                      },
                      child: Container(
                        height: 40,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20),
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
              child: ListView.builder(
                itemCount: listData.length +1,
                itemBuilder: (context, index) {

                  if (index == listData.length){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loadData == false && loadMoreData == true?
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: darkgreen, // Background color
                            ),
                            onPressed: (){
                              loadMoreItem();

                              setState(() {
                                loadData = true;
                              });
                            },
                            child: Text(load_more.tr)):loadMoreData==true?Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: progressIndicator(context),
                        ):Container()
                      ],
                    );
                  }

                  var ds = listData[index];
                  AppFonts.dateFormatChanged(ds["created_at"]);

                  return InkWell(
                    onTap: () {
                      goto(
                        context,
                        TyresDetailsScreen(ds),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                                borderRadius:
                                BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: ds["image1"],
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
                                )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    child: barlowBold(
                                      text: (ds["brand_name"] ??
                                          "") +
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
                                      HSpace(5),
                                      barlowBold(
                                        text:
                                        "Rs. ${ds["price"] ?? ""}",
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
                                              ds["city_name"] ??
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
                                            AppImages.calender,
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
                                      )
                                    ],
                                  ),
                                  ShowDistanceVertical(UserData.lat,UserData.long,ds['latlong'].toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  loadMoreItem() async{
    setState(() {
      numSkip += 20;
    });
    getUrlByCategory();

    var skipDataList = [];

    skipDataList = await ApiMethods().getTractorsByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      currentTabType,
      numSkip,
      20,
      currentLocation!,
      "viewall",
    );
    if(skipDataList.length==0){
      setState(() {
        loadMoreData = false;
      });
    }
    setState(() {
      initDataList.addAll(skipDataList);
      loadData = false;
    });
  }

  void lowToHighMethod() {
    if (listData[0]['price'].runtimeType == String) {
      listData.sort(
              (a, b) => int.parse(a['price']).compareTo(int.parse(b['price'])));
      setState(() {});
    } else {
      listData.sort((a, b) => a['price'].compareTo(b['price']));
      setState(() {});
    }
  }

  void highToLowMethod() {
    if (listData[0]['price'].runtimeType == String) {
      listData.sort(
              (a, b) => int.parse(b['price']).compareTo(int.parse(a['price'])));
      setState(() {});
    } else {
      listData.sort((a, b) => b['price'].compareTo(a['price']));
      setState(() {});
    }
  }



  doThisONLaunch() async {
    filterFlag = false;

    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    getUrlByCategory();

    initDataList = [];

    initDataList = await ApiMethods().getTractorsByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      currentTabType,
      0,
      20,
      currentLocation!,
      "viewall",
    );

    isDataObtained = false;
    setState(() {});
  }

  getUrlByCategory() {
    if (widget.categoryId == 7) {
      url = baseUrl + tyresUrlData;
      currentTabType = tyresTabType;
      currentType = tyresType;
    }
  }

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
