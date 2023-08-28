import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/fonts.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/const/utils.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../Screens/tractor/data.dart';
import '../../const/api_urls.dart';
import '../../widgets/distence_widget.dart';
import '../../widgets/filter_page/ShowBottomSheet.dart';
import '../../widgets/filter_page/varieble_const.dart';
import '../harvester/harvester_details_screen.dart';

class AllAdsVerticalList extends StatefulWidget {
  final String? category;
  final String? type;
  final int? categoryId;

  final List? result;

  AllAdsVerticalList({
    Key? key,
    this.category,
    this.categoryId,
    this.result,
    this.type,
  }) : super(key: key);

  @override
  State<AllAdsVerticalList> createState() => _AllAdsVerticalListState();
}

class _AllAdsVerticalListState extends State<AllAdsVerticalList> {
  var ds;

  List filterData = [];

  String url = "";

  var currentTabType = "";
  var currentType = "";

  List initDataList = [];

  bool isDataObtained = true;

  String sortBy = '';

  List listData = [];

  bool filterFlag = false;
  bool isChecked = false;
  PageController _pageController = PageController();
  int selectedIndex = 0;

  checkType() {
    if (currentTabType == "rent") {
      type = "rent";
      condition = "old";
    } else if (currentTabType == "old") {
      type = "buy";
      condition = "old";
    } else {
      type = "buy";
      condition = "new";
    }
  }

  bool loadData = false;
  int numSkip = 0;
  bool loadMoreData = true;

  @override
  void initState() {
    super.initState();
    doThisONLaunch();
    checkType();
    category = widget.categoryId.toString();
    _pageController = PageController(initialPage: selectedIndex);
    Utils.getUserCurrentLocationUtils();
  }

  @override
  Widget build(BuildContext context) {
    listData = filterData.isEmpty
        ? filterFlag
            ? []
            : initDataList
        : filterData;
    print("filterData");
    print(filterData);
    print("initDataList");
    print(initDataList);
    print("listData");
    print(listData);
    print("isDataObtained");
    print(isDataObtained);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkgreen,
          title: barlowBold(
            text: "${currentType} ${widget.category.toString()}",
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
                                      Text(
                                        sort.tr,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                                    "${widget.category.toString()}",
                                    "${currentType.toString()}",
                                    "${widget.categoryId.toString()}");
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
                                    "${widget.category.toString()}",
                                    "${currentType.toString()}",
                                    "${widget.categoryId.toString()}");
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
                                    "${widget.category.toString()}",
                                    "${currentType.toString()}",
                                    "${widget.categoryId.toString()}");
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
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
                            child: ListView.builder(
                              itemCount: listData.length + 1,
                              itemBuilder: (context, index) {
                                if (index == listData.length) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      loadData == false && loadMoreData == true
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    darkgreen, // Background color
                                              ),
                                              onPressed: () {
                                                loadMoreItem();

                                                setState(() {
                                                  loadData = true;
                                                });
                                              },
                                              child: Text(load_more.tr))
                                          : loadMoreData == true
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: progressIndicator(
                                                      context),
                                                )
                                              : Container()
                                    ],
                                  );
                                }

                                var ds = listData[index];
                                AppFonts.dateFormatChanged(ds["created_at"]);
                                return InkWell(
                                  onTap: () {
                                    ds["category_id"] == 4
                                        ? goto(
                                            context,
                                            HarvesterDetailsScreen(ds),
                                          )
                                        : ds["category_id"] == 5
                                            ? goto(
                                                context,
                                                ImplementsDetailsScreen(ds),
                                              )
                                            : goto(
                                                context,
                                                TractorDetailsScreen(
                                                  ds,
                                                ),
                                              );
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: ds["front_image"],
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
                                                ),
                                              ),
                                              ds["status"]== 4? SizedBox(
                                                height: 50,
                                                width: 100,
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
                                                    text: (ds["brand_name"] ??
                                                            "") +
                                                        " " +
                                                        (ds["model_name"] ??
                                                            ""),
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
                                                      text: "Rs. ${ds["price"] ?? ""}" +
                                                          ((ds['type'] == 'rent' ||
                                                              ds['set'] == 'rent')
                                                              ? "${(ds['rent_type']).toString().replaceAll('Per', '/')}"
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
                                                                      .only(
                                                                  left: 4),
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
                                                          "assets/calendar.png",
                                                          width: 15,
                                                          height: 15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4),
                                                          child: barlowRegular(
                                                            text: AppFonts
                                                                .newDate
                                                                .toString(),
                                                            color: black,
                                                            size: 13,
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                ShowDistanceVertical(
                                                    UserData.lat,
                                                    UserData.long,
                                                    ds['latlong'].toString())
                                              ],
                                            ),
                                          ),
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
        ));
  }

  loadMoreItem() async {
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
    if (skipDataList.length == 0) {
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
    if (widget.categoryId == 1) {
      url = baseUrl + tractorDataUrl;
      currentTabType = tractorTabType;
      currentType = tractorType;
    } else if (widget.categoryId == 3) {
      url = baseUrl + goodsVehicleUrlData;
      currentTabType = gvTabType;
      currentType = gvType;
    } else if (widget.categoryId == 4) {
      url = baseUrl + harvesterUrlData;
      currentTabType = harvesterTabType;
      currentType = harvesterType;
    } else if (widget.categoryId == 5) {
      url = baseUrl + implementsUrlData;
      currentTabType = implementTabType;
      currentType = implementType;
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
