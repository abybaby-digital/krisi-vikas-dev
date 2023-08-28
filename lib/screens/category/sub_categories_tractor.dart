import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_brand_screen.dart';
import 'package:krishivikas/Screens/select_user_type_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/models/harvester_model.dart';
import 'package:krishivikas/models/implements_model.dart';
import 'package:krishivikas/screens/category/all_ads_vertical_list_category.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../../language/language_key.dart';

class SubCategoriesTractor extends StatefulWidget {
  final String? category;

  final int? categoryId;

  const SubCategoriesTractor({
    Key? key,
    this.category,
    this.categoryId,
  }) : super(
          key: key,
        );
  @override
  State<SubCategoriesTractor> createState() => _SubCategoriesTractorState();
}

class _SubCategoriesTractorState extends State<SubCategoriesTractor> {
  var ds;

  var filterData;

  List subCategoryData = [];

  bool isDataObtained = false;

  String listData = " ";

  String SellNew = "";
  String SellUsed = "";
  String RentYour = "";
  String BuyNew = "";
  String BuyUsed = "";
  String Rent = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCategory();
    getImagesUrl(widget.categoryId);
    if (mounted) {
      setState(() {});
    }
    print("CurrentUserType");
    print(CurrentUserType);
  }

  getImagesUrl(categoryIdData) {
    print(categoryIdData.runtimeType);

    // Tractor
    if (categoryIdData == 1) {
      SellNew = AppImages.SellNewTractor;
      SellUsed = AppImages.SellUsedTractor;
      RentYour = AppImages.RentYourTractor;
      BuyNew = AppImages.BuyNewTractor;
      BuyUsed = AppImages.BuyUsedTractor;
      Rent = AppImages.RentTractor;
    }
    // GoodsVehicle
    if (categoryIdData == 3) {
      SellNew = AppImages.SellNewGoodsVehicle;
      SellUsed = AppImages.SellUsedGoodsVehicle;
      RentYour = AppImages.RentYourGoodsVehicle;
      BuyNew = AppImages.BuyNewGoodsVehicle;
      BuyUsed = AppImages.BuyUsedGoodsVehicle;
      Rent = AppImages.RentGoodsVehicle;
    }
    // Harvester
    if (categoryIdData == 4) {
      SellNew = AppImages.SellNewHarvester;
      SellUsed = AppImages.SellUsedHarvester;
      RentYour = AppImages.RentYourHarvester;
      BuyNew = AppImages.BuyNewHarvester;
      BuyUsed = AppImages.BuyUsedHarvester;
      Rent = AppImages.RentHarvester;
    }
    // Implements
    if (categoryIdData == 5) {
      SellNew = AppImages.SellNewImplements;
      SellUsed = AppImages.SellUsedImplements;
      RentYour = AppImages.RentYourImplements;
      BuyNew = AppImages.BuyNewImplements;
      BuyUsed = AppImages.BuyUsedImplements;
      Rent = AppImages.RentImplements;
    }
  }

  Future<List> getSubCategory() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    if (subCategoryData.isEmpty) {
      subCategoryData = (await ApiMethods().getSubCategoryApi(
        baseUrl + categoryPage,
        SharedPreferencesFunctions.userId!,
        SharedPreferencesFunctions.token!,
        widget.categoryId.toString(),
      ));
    }
    isDataObtained = true;
    if (mounted) {
      setState(() {});
    }
    return subCategoryData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: widget.category.toString(),
          size: 20,
          color: white,
        ),
      ),
      body: Container(
          child: isDataObtained
              ? SingleChildScrollView(
                  child: Column(children: [
                    CachedNetworkImgData(
                        subCategoryData[0]["banner"][0]["banner"],
                        fullWidth(context),
                        180,
                        AppImages.bannerPlaceHolder,
                        context),
                    // Container(
                    //   height: fullHeight(context) * 0.18,
                    //   width: fullWidth(context),
                    //   color: greenShade300,
                    //   child: Center(
                    //     child: Container(
                    //       height: fullHeight(context) * 0.16,
                    //       width: fullWidth(context) * 0.65,
                    //       child: Center(
                    //         child: barlowBold(
                    //             color: white,
                    //             maxLine: 2,
                    //             size: 35,
                    //             text: "WHAT ARE YOU LOOKING FOR?"),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    VSpace(20),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: iconDataList(
                                sell_new.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                SellNew,
                                context,
                                1),
                          ),
                          Container(
                            child: iconDataList(
                                sell_used.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                SellUsed,
                                context,
                                2),
                          ),
                          Container(
                            child: iconDataList(
                                rent_your.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                RentYour,
                                context,
                                3),
                          ),
                        ],
                      ),
                    ),
                    VSpace(15),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: iconDataList(
                                buy_new.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                BuyNew,
                                context,
                                4),
                          ),
                          Container(
                            child: iconDataList(
                                buy_used.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                BuyUsed,
                                context,
                                5),
                          ),
                          Container(
                            child: iconDataList(
                                rent_a.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                Rent,
                                context,
                                6),
                          ),
                        ],
                      ),
                    ),
                    VSpace(25),
                    CachedNetworkImgData(
                        subCategoryData[0]["banner"][1]["banner"],
                        fullWidth(context),
                        180,
                        AppImages.bannerPlaceHolder,
                        context),
                  ]),
                )
              : Center(
                  child: progressIndicator(context),
                )),
    );
  }

  Widget CachedNetworkImgData(
      String url, double w, double h, String assetImage, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        width: w,
        height: h,
        placeholder: (context, url) {
          return Center(
            child: Text("Loading"),
          );
        },
        errorWidget: (context, url, dynamic) {
          return Center(
            child: Image.asset(
              assetImage,
              width: w * 0.50,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget iconDataList(String subCatName, double w, double h, String assetImage,
      BuildContext context, int IsSelect) {
    return InkWell(
      onTap: () async {
        if (IsSelect == 1) {
          if (CurrentUserType == 0) {
            await goto(
              context,
              SelectUserType("subcat"),
            );
            setState(() {});
          } else if (CurrentUserType == 1) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: barlowBold(
                  color: red,
                  maxLine: 1,
                  size: 20,
                  text: 'Alert!',
                ),
                // title: const Text('Alert!'),
                content: barlowSemiBold(
                  color: green,
                  size: 15,
                  text: 'New Upload Only For Corporate Users!',
                  maxLine: 2,
                ),
                // content: const Text('New Upload Only For Corporate Users!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else {
            TractorData.type = "new";
            HarvesterData.type = "new";
            ImplementsData.type = "new";
            TractorData.productType = "sell";
            HarvesterData.productType = "sell";
            ImplementsData.productType = "sell";
            HarvesterData.categoryId = widget.categoryId;
            ImplementsData.categoryId = widget.categoryId;
            TractorData.categoryId = widget.categoryId;
            goto(
              context,
              SelectBrandScreen(
                widget.categoryId,
                "sell",
                "new",
              ),
            );
          }
        } else if (IsSelect == 2) {
          if (CurrentUserType == 0) {
            await goto(
              context,
              SelectUserType("subcat"),
            );
            setState(() {});
          } else {
            TractorData.type = "old";
            HarvesterData.type = "old";
            ImplementsData.type = "old";
            TractorData.productType = "sell";
            HarvesterData.productType = "sell";
            ImplementsData.productType = "sell";
            HarvesterData.categoryId = widget.categoryId;
            ImplementsData.categoryId = widget.categoryId;
            TractorData.categoryId = widget.categoryId;
            goto(
              context,
              SelectBrandScreen(
                widget.categoryId,
                "sell",
                "old",
              ),
            );
          }
        } else if (IsSelect == 3) {
          if (CurrentUserType == 0) {
            await goto(
              context,
              SelectUserType("subcat"),
            );
            setState(() {});
          } else {
            TractorData.type = "old";
            HarvesterData.type = "old";
            ImplementsData.type = "old";
            TractorData.productType = "sell";
            HarvesterData.productType = "sell";
            ImplementsData.productType = "sell";
            HarvesterData.categoryId = widget.categoryId;
            ImplementsData.categoryId = widget.categoryId;
            TractorData.categoryId = widget.categoryId;
            goto(
              context,
              SelectBrandScreen(
                widget.categoryId,
                "rent",
                "old",
              ),
            );
          }
        } else if (IsSelect == 4) {
          goto(
              context,
              AllAdsVerticalListCategory(
                category: widget.category,
                categoryId: widget.categoryId,
                productType: "new",
              ));
        } else if (IsSelect == 5) {
          goto(
              context,
              AllAdsVerticalListCategory(
                category: widget.category,
                categoryId: widget.categoryId,
                productType: "old",
              ));
        } else if (IsSelect == 6) {
          goto(
              context,
              AllAdsVerticalListCategory(
                category: widget.category,
                categoryId: widget.categoryId,
                productType: "rent",
              ));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 4,
          // ),
          Container(
            height: h,
            width: w,
            decoration: BoxDecoration(
              color: white,
              boxShadow: [
                BoxShadow(
                  color: grey,
                  blurRadius: 3,
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Image.asset(
                  assetImage,
                ),
              ),
            ),
          ),
          VSpace(5),
          Container(
            // color: white,
            width: w - 5,
            child: barlowSemiBoldForSubCat(
              size: 15,
              color: black,
              maxLine: 2,
              text: subCatName,
            ),
          ),
        ],
      ),
    );
  }
}
