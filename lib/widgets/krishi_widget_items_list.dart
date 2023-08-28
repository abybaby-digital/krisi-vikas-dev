import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_details_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_details_screen.dart';
import 'package:krishivikas/Screens/seeds/seeds_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/distence_widget.dart';
import '../Screens/tractor/data.dart';
import '../language/language_key.dart';

class KrishiWidgetItemsList extends StatefulWidget {
  final int? categoryId;

  const KrishiWidgetItemsList({
    this.categoryId,
  });

  @override
  State<KrishiWidgetItemsList> createState() => _KrishiWidgetItemsListState();
}

class _KrishiWidgetItemsListState extends State<KrishiWidgetItemsList> {
  String url = "";

  String otherDistrictUrl = "";

  List dataList = [];

  List newDataList = [];

  List otherDistrictDataList = [];

  List newOtherDistrictDataList = [];

  late final Future<List<dynamic>> futureList;

  Future<List<dynamic>> doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    getUrlByCategory();

    dataList = await ApiMethods().getKrishiDataByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      0,
      7,
      currentLocation!,
      "dashboard",
    );

    // ignore: unnecessary_null_comparison
    if (dataList != null) {
      for (var item in dataList) {
        newDataList.add(item);
      }
    }

    setState(() {});
    return Future.value(this.newDataList);
  }

  getUrlByCategory() {
    if (widget.categoryId == 6) {
      url = baseUrl + seedUrlData;
    } else if (widget.categoryId == 8) {
      url = baseUrl + pesticidesUrlData;
    } else if (widget.categoryId == 9) {
      url = baseUrl + fetilizerUrlData;
    }
  }

  @override
  void initState() {
    this.futureList = doThisONLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: this.futureList,
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
              itemCount: newDataList.length,
              itemBuilder: (context, index) {
                var ds = newDataList[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 8.0, right: 12.0, bottom: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (widget.categoryId == 6) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SeedsDetailsScreen(ds),
                          ),
                        );
                      } else if (widget.categoryId == 8) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PesticidesDetailsScreen(ds),
                          ),
                        );
                      } else if (widget.categoryId == 9) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FertilizerDetailsScreen(ds),
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
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: ds["image1"],
                                    fit: BoxFit.cover,
                                    width: fullWidth(context),
                                    height: fullHeight(context) * 0.24,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  child: barlowBoldForHome(
                                    text: ds["title"] ?? "",
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
                                  padding: const EdgeInsets.only(left: 10.0,top: 2.0,right: 10.0,bottom: 6.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: grey,
                                        size: 18,
                                      ),
                                      barlowRegularForHome(
                                        text: ds["city_name"] ?? "",
                                        color: grey,
                                        size: 13,
                                        maxLine: 1,
                                      ),
                                      const Spacer(),
                                      barlowBold(
                                        text: "₹ ",
                                        size: 18,
                                        color: kPrimaryColor,
                                      ),
                                      barlowBold(
                                        text: "${ds["price"] ?? ""}",
                                        size: 15,
                                        color: kPrimaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                                ShowDistanceHorizontal(UserData.lat,UserData.long,ds['latlong'].toString()),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 0.42 * fullHeight(context),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Image.asset('assets/WaterMark.png',fit: BoxFit.cover,)),
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
}
