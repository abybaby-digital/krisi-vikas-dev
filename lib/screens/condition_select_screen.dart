import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_brand_screen.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/tractor/data.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../models/harvester_model.dart';
import '../models/implements_model.dart';
import '../models/tyres_model.dart';
import '../services/save_user_info.dart';
import 'notification/notifications_screen.dart';

class ConditionSelectScreen extends StatefulWidget {
  final categoryId;
  final s;

  ConditionSelectScreen(
    this.categoryId,
    this.s,
  );

  @override
  State<ConditionSelectScreen> createState() => _ConditionSelectScreenState();
}

class _ConditionSelectScreenState extends State<ConditionSelectScreen> {
  String category = "";

  String newCategoryImage = "";

  String usedCategoryImage = "";

  getCategory() {
    if (widget.categoryId == 1) {
      category = SharedPreferencesFunctions().getLanguage() == "Hindi"
          ? tractor.tr
          : SharedPreferencesFunctions().getLanguage() == "Bengali"
              ? tractor.tr
              : tractor.tr;
      newCategoryImage = AppImages.newTractor;
      usedCategoryImage = AppImages.oldTractor;
    } else if (widget.categoryId == 3) {
      category = SharedPreferencesFunctions().getLanguage() == "Hindi"
          ? goodsVehicle.tr
          : SharedPreferencesFunctions().getLanguage() == "Bengali"
              ? goodsVehicle.tr
              : goodsVehicle.tr;
      newCategoryImage = AppImages.newGoodsVehicle;
      usedCategoryImage = AppImages.oldGoodsVehicle;
    } else if (widget.categoryId == 4) {
      category = SharedPreferencesFunctions().getLanguage() == "Hindi"
          ? harvester.tr
          : SharedPreferencesFunctions().getLanguage() == "Bengali"
              ? harvester.tr
              : harvester.tr;
      newCategoryImage = AppImages.newHarvester;
      usedCategoryImage = AppImages.oldHarvester;
    } else if (widget.categoryId == 5) {
      category = SharedPreferencesFunctions().getLanguage() == "Hindi"
          ? implement.tr
          : SharedPreferencesFunctions().getLanguage() == "Bengali"
              ? implement.tr
              : implement.tr;
      newCategoryImage = AppImages.newImplements;
      usedCategoryImage = AppImages.oldImplements;
    } else if (widget.categoryId == 7) {
      category = SharedPreferencesFunctions().getLanguage() == "Hindi"
          ? tyre.tr
          : SharedPreferencesFunctions().getLanguage() == "Bengali"
              ? tyre.tr
              : tyre.tr;
      newCategoryImage = AppImages.newTyres;
      usedCategoryImage = AppImages.oldTyres;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: appTitle.tr,
          color: white,
          size: 20,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       goto(
        //         context,
        //         NotificationsScreen(),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.notifications,
        //       color: white,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            color: greenShade300,
            child: barlowBold(
              text: whatIsCondition.tr,
              size: 20,
              color: white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    goto(
                      context,
                      SelectBrandScreen(
                        widget.categoryId,
                        widget.s,
                        "new",
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.3),
                          blurRadius: 3,
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            newCategoryImage,
                            height: fullHeight(context) * 0.10,
                            width: fullWidth(context) * 0.30,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          barlowBold(
                            text: newValue.tr + " $category",
                            size: usedValue.tr.length < 12 ||
                                    usedValue.tr.length > 9
                                ? 12
                                : 20,
                            color: black,
                          ),
                          const SizedBox(
                            height: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    TractorData.type = "old";
                    HarvesterData.type = "old";
                    ImplementsData.type = "old";
                    TyresData.type = "old";
                    TractorData.productType = widget.s;
                    HarvesterData.productType = widget.s;
                    HarvesterData.categoryId = widget.categoryId;
                    ImplementsData.productType = widget.s;
                    ImplementsData.categoryId = widget.categoryId;
                    goto(
                      context,
                      SelectBrandScreen(
                        widget.categoryId,
                        widget.s,
                        "old",
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.3),
                          blurRadius: 3,
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            usedCategoryImage,
                            height: fullHeight(context) * 0.10,
                            width: fullWidth(context) * 0.30,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          (widget.categoryId == 4 ||
                                  widget.categoryId == 5 ||
                                  widget.categoryId == 7)
                              ? barlowBold(
                                  text: oldValue.tr + " $category",
                                  size: usedValue.tr.length < 12 ||
                                          usedValue.tr.length > 9
                                      ? 12
                                      : 20,
                                  color: black,
                                )
                              : barlowBold(
                                  text: usedValue.tr + " $category",
                                  size: usedValue.tr.length < 12 ||
                                          usedValue.tr.length > 9
                                      ? 12
                                      : 20,
                                  color: black,
                                ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
