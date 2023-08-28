import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_ads_vertical_list.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_data_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticide_data_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_ads_vertical_list.dart';
import 'package:krishivikas/Screens/seeds/seeds_ads_vertical_list.dart';
import 'package:krishivikas/Screens/seeds/seeds_data_screen.dart';
import 'package:krishivikas/Screens/select_user_type_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../../language/language_key.dart';

class SubCategoriesSeed extends StatefulWidget {
  final String? category;

  final int? categoryId;

  const SubCategoriesSeed({
    Key? key,
    this.category,
    this.categoryId,
  }) : super(
          key: key,
        );
  @override
  State<SubCategoriesSeed> createState() => _SubCategoriesSeedState();
}

class _SubCategoriesSeedState extends State<SubCategoriesSeed> {
  List subCategoryData = [];

  bool isDataObtained = false;

  String SellSeed = "";
  String ByeSeed = "";

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

    // Seed
    if (categoryIdData == 6) {
      SellSeed = AppImages.SellSeeds;
      ByeSeed = AppImages.BuySeeds;
    }
    // Pesticides
    if (categoryIdData == 8) {
      SellSeed = AppImages.SellPesticides;
      ByeSeed = AppImages.BuyPesticides;
    }
    // Fertilizers
    if (categoryIdData == 9) {
      SellSeed = AppImages.SellFertilizers;
      ByeSeed = AppImages.BuyFertilizers;
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
                                sell_a.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                SellSeed,
                                context,
                                1),
                          ),
                          Container(
                            child: iconDataList(
                                buy_a.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                ByeSeed,
                                context,
                                2),
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
        print("on CLick Data Value");
        print(IsSelect);
        if (IsSelect == 1) {
          if (CurrentUserType == 0) {
           await goto(
              context,
              SelectUserType("subcat"),
            );
            setState(() {});
          } else {
            if (widget.categoryId == 6) {
              goto(
                context,
                SeedsDataScreen(
                  categoryId: widget.categoryId,
                ),
              );
            } else if (widget.categoryId == 8) {
              goto(
                context,
                PesticideDataScreen(
                  categoryId: widget.categoryId,
                ),
              );
            } else if (widget.categoryId == 9) {
              goto(
                context,
                FertilizerDataScreen(
                  categoryId: widget.categoryId,
                ),
              );
            }
          }
        } else if (IsSelect == 2) {
          if (widget.categoryId == 6) {
            goto(
              context,
              SeedsAdsVerticalList(
                categoryId: widget.categoryId,
                categoryName: widget.category.toString(),
              ),
            );
          } else if (widget.categoryId == 8) {
            goto(
              context,
              PesticidesAdsVerticalList(
                categoryId: widget.categoryId,
                categoryName: widget.category.toString(),
              ),
            );
          } else if (widget.categoryId == 9) {
            goto(
              context,
              FertilizerAdsVerticalList(
                categoryId: widget.categoryId,
                categoryName: widget.category.toString(),
              ),
            );
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 4,
          ),
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
            width: w,
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
