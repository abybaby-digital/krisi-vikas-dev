import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_brand_screen.dart';
import 'package:krishivikas/Screens/select_user_type_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/models/tyres_model.dart';
import 'package:krishivikas/screens/category/tyre_vertical_list_category.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class SubCategoriesTyre extends StatefulWidget {
  final String? category;

  final int? categoryId;

  const SubCategoriesTyre({
    Key? key,
    this.category,
    this.categoryId,
  }) : super(
          key: key,
        );
  @override
  State<SubCategoriesTyre> createState() => _SubCategoriesTyreState();
}

class _SubCategoriesTyreState extends State<SubCategoriesTyre> {
  List subCategoryData = [];

  bool isDataObtained = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSubCategory();
    print("CurrentUserType");
    print(CurrentUserType);
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
                                AppImages.SellNewTyres,
                                context,
                                1),
                          ),
                          Container(
                            child: iconDataList(
                                sell_used.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                AppImages.SellUsedTyres,
                                context,
                                2),
                          ),
                        ],
                      ),
                    ),
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
                                AppImages.BuyNewTyres,
                                context,
                                3),
                          ),
                          Container(
                            child: iconDataList(
                                buy_used.tr + widget.category.toString(),
                                100.00,
                                100.00,
                                AppImages.BuyUsedTyres,
                                context,
                                4),
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
            TyresData.type = "new";
            TyresData.categoryId = widget.categoryId;
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
            TyresData.type = "old";
            TyresData.categoryId = widget.categoryId;
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
          goto(
              context,
              TyreVerticalListCategory(
                category: widget.category,
                categoryId: widget.categoryId,
                productType: "new",
              ));
        } else if (IsSelect == 4) {
          goto(
              context,
              TyreVerticalListCategory(
                category: widget.category,
                categoryId: widget.categoryId,
                productType: "old",
              ));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VSpace(8),
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
            height: 50,
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
