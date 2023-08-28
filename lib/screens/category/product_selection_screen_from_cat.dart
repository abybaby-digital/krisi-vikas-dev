import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/condition_select_screen.dart';
import 'package:krishivikas/Screens/select_brand_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/models/harvester_model.dart';
import 'package:krishivikas/models/implements_model.dart';
import 'package:krishivikas/models/tyres_model.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ProductSelectionScreenFromCatSection extends StatefulWidget {
  final int? SetWhere;
  final String? ProductType;
  final String? ProductFor;
  const ProductSelectionScreenFromCatSection({
    this.SetWhere,
    this.ProductFor,
    this.ProductType,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<ProductSelectionScreenFromCatSection> createState() =>
      _ProductSelectionScreenFromCatSectionState();
}

class _ProductSelectionScreenFromCatSectionState
    extends State<ProductSelectionScreenFromCatSection> {
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
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            color: greenShade300,
            child: barlowBold(
              text: whatWouldYouLikeToDo.tr,
              size: 20,
              color: white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(
              18.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    print("sell");
                    if (CurrentUserType == 1) {
                      TractorData.type = "old";
                      HarvesterData.type = "old";
                      ImplementsData.type = "old";
                      TyresData.type = "old";
                      TractorData.productType = "sell";
                      HarvesterData.productType = "sell";
                      ImplementsData.productType = "sell";
                      HarvesterData.categoryId = widget.SetWhere;
                      ImplementsData.categoryId = widget.SetWhere;
                      TractorData.categoryId = widget.SetWhere;
                      TyresData.categoryId = widget.SetWhere;
                      goto(
                        context,
                        SelectBrandScreen(
                          widget.SetWhere,
                          "sell",
                          "old",
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ConditionSelectScreen(widget.SetWhere, "sell"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: fullWidth(context) * 0.40,
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
                            AppImages.buyIcon,
                            width: fullWidth(context) * 0.30,
                            height: fullWidth(context) * 0.20,
                          ),
                          VSpace(10),
                          barlowBold(
                            text: sell.tr,
                            size: 20,
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
                    print("rent");
                    if (CurrentUserType == 1) {
                      TractorData.type = "old";
                      HarvesterData.type = "old";
                      ImplementsData.type = "old";
                      TractorData.productType = "sell";
                      HarvesterData.productType = "sell";
                      ImplementsData.productType = "sell";
                      HarvesterData.categoryId = widget.SetWhere;
                      ImplementsData.categoryId = widget.SetWhere;
                      TractorData.categoryId = widget.SetWhere;
                      TyresData.categoryId = widget.SetWhere;
                      goto(
                        context,
                        SelectBrandScreen(
                          widget.SetWhere,
                          "rent",
                          "old",
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ConditionSelectScreen(widget.SetWhere, "rent"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: fullWidth(context) * 0.40,
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
                            AppImages.rentIcon,
                            width: fullWidth(context) * 0.30,
                            height: fullWidth(context) * 0.20,
                          ),
                          VSpace(10),
                          barlowBold(
                            text: rent.tr,
                            size: 20,
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
