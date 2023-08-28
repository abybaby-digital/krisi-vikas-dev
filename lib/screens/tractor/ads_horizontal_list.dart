import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/Screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import '../../Screens/tractor/data.dart';
import '../../const/distance_calculation.dart';
import '../../language/language_key.dart';
import '../../widgets/all_widgets.dart';
import '../../widgets/distence_widget.dart';

class AdsHorizontalList extends StatefulWidget {
  final String category;
  final int categoryId;
  final String type;
  final String productType;

  AdsHorizontalList({
    Key? key,
    required this.category,
    required this.categoryId,
    required this.type,
    required this.productType,
  }) : super(key: key);

  @override
  State<AdsHorizontalList> createState() => _AdsHorizontalListState();
}

class _AdsHorizontalListState extends State<AdsHorizontalList> {

  String url = "";
  List newTractorsList = [];

  late final Future<List<dynamic>> _futureList;

  @override
  void initState() {
    // setState(() {
    //   tractorTabType = widget.type;
    // });
    checkType();
    super.initState();

    this._futureList = widget.categoryId == 7 || widget.categoryId == 5
        ? addDataLaunch()
        : doThisONLaunch();
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
                      } else if (widget.categoryId == 7) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TyresDetailsScreen(ds),
                          ),
                        );
                      } else {
                        // print("ds Objetct");
                        // print(ds);
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
                          ),
                          BoxShadow(
                            color: grey,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      height: fullHeight(context) * 0.5,
                      width: fullWidth(context) * 0.6,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.categoryId == 7
                                          ? ds['image1']
                                          : ds["front_image"],
                                      fit: BoxFit.cover,
                                      width: fullWidth(context),
                                      height: fullHeight(context) * 0.24,
                                      placeholder: (context, url) {
                                        return Center(
                                          child: barlowRegularForHome(
                                            text: loading.tr,
                                            size: 15,
                                            color: black,
                                            maxLine: 1,
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
                                  ds["status"]== 4? SizedBox(
                                    height: 50,
                                    width: 100,
                                    child: Image.asset("assets/sold_tag.png"),):Container()
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
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
                              ShowDistanceHorizontal(UserData.lat,UserData.long,ds['latlong'].toString())
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 0.29 * fullHeight(context),
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
                );
              },
            ),
          )
              : snapshot.connectionState == ConnectionState.waiting
              ? Center(
            child: progressIndicator(context),
          )
              : Center(
            child: barlowRegular(
              text: noDataFound.tr,
              color: black,
              size: 15,
            ),
          ),
        );
      },
    );
  }

  Future<List<dynamic>> doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    await getUrlByCategory();

    List tractorsList = await ApiMethods().getTractorsByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      widget.type,
      0,
      5,
      currentLocation!,
      "dashboard",
    );

    // print("tractorsList");
    // print(tractorsList);
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

  Future<List<dynamic>> addDataLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    await getUrlByCategory();

    List tractorsList = await ApiMethods().getTractorsByPostApiData(
      url,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
      widget.type,
      0,
      5,
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

    print("newTractorsList");
    print(newTractorsList);
    return Future.value(this.newTractorsList);
  }
  checkType(){
    switch (widget.categoryId){
      case 1:
        if(widget.type == "old" ){
          tractorType = usedValue.tr;
        }else if(widget.type == "new"){
          tractorType = newValue.tr;
        }
        break;
      case 3:
        if(widget.type == "old" ){
          gvType = usedValue.tr;
        }else if(widget.type == "new"){
          gvType = newValue.tr;
        }
        break;
      case 4:
        if(widget.type == "old" ){
          harvesterType = usedValue.tr;
        }else if(widget.type == "new"){
          harvesterType = newValue.tr;
        }
        break;
      case 5:
        if(widget.type == "old" ){
          implementType = usedValue.tr;
        }else if(widget.type == "new"){
          implementType = newValue.tr;
        }
        break;
      case 7:
        if(widget.type == "old" ){
          tyresType = usedValue.tr;
        }else if(widget.type == "new"){
          tyresType = newValue.tr;
        }
        break;
      default:
        return Text("Something went wrong.");
    }
  }
  getUrlByCategory() {
    switch (widget.categoryId) {
      case 1:
        url = baseUrl + tractorDataUrl;
        tractorTabType = widget.type;
        break;
      case 3:
        url = baseUrl + goodsVehicleUrlData;
        gvTabType = widget.type;
        break;
      case 4:
        url = baseUrl + harvesterUrlData;
        harvesterTabType = widget.type;
        break;
      case 5:
        url = baseUrl + implementsUrlData;
        implementTabType = widget.type;
        break;
      case 7:
        url = baseUrl + tyresUrlData;
        tyresTabType = widget.type;
        break;

      default:
        return Text("Something went wrong.");
    }
  }
}
