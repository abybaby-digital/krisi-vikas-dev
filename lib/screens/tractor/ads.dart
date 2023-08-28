import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/tractor/ads_horizontal_list.dart';
import 'package:krishivikas/Screens/tractor/all_ads_vertical_list.dart';
import 'package:krishivikas/Screens/tyres/tyres_ads_vertical_list.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/screens/rent/rent_horizontallist_.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/view_all_widget.dart';
import '../../language/language_key.dart';
import '../../widgets/filter_page/screen/brand_page.dart';
import '../../widgets/filter_page/screen/manufacturing_screen.dart';
import '../../widgets/filter_page/screen/price_page.dart';
import '../../widgets/filter_page/varieble_const.dart';

class Ads extends StatefulWidget {
  final String categoryType;
  final String tabBar;
  final int categoryId;

  Ads({
    Key? key,
    required this.categoryType,
    required this.categoryId,
    required this.tabBar,
  }) : super(key: key);

  @override
  State<Ads> createState() => _AdsState();
}

class _AdsState extends State<Ads> {
  get tabController => null;

  @override
  void initState() {
    setState(() {
      tractorTabType = "";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight(context) * 0.50,
      width: fullWidth(context),
      color: white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: barlowBold(
                text: widget.categoryType,
                size: 18,
                color: black,
              ),
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: fullWidth(context) * 0.80,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.0),
                              border: Border(
                                bottom: BorderSide(
                                  color: grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: TabBar(
                              labelPadding: EdgeInsets.zero,
                              labelColor: black,
                              indicatorColor: black,
                              indicatorWeight: 3.0,
                              isScrollable: false,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: EdgeInsets.zero,
                              unselectedLabelColor: grey,
                              labelStyle: TextStyle(
                                fontFamily: "Barlow",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelStyle: TextStyle(
                                fontFamily: "Barlow",
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),

                              tabs: (widget.categoryId == 7)
                                  ? [
                                      Tab(
                                        text: usedCaps.tr,
                                      ),
                                      Tab(
                                        text: newCaps.tr,
                                      ),
                                    ]
                                  : [
                                      Tab(
                                        text: rentCaps.tr,
                                      ),
                                      Tab(
                                        text: usedCaps.tr,
                                      ),
                                      Tab(
                                        text: newCaps.tr,
                                      ),
                                    ],

                              // tabs: [
                              //   (widget.categoryId == 7)
                              //       ? SizedBox.shrink()
                              //       : Tab(
                              //           text: rentCaps.tr,
                              //         ),
                              //   Tab(
                              //     text: usedCaps.tr,
                              //   ),
                              //   Tab(
                              //     text: newCaps.tr,
                              //   ),
                              // ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      ViewAllWidget(
                        buttonTitle: viewAll.tr,
                        onTap: () {
                          priceStart = "0";
                          priceEnd = "50000";
                          byYear = "";
                          selectedItems = [];
                          selectedContainerIndex = -1;
                          selectedPriceIndex = -1;
                          (widget.categoryId == 7)
                              ? goto(
                                  context,
                                  TyresAdsVerticalList(
                                    categoryId: widget.categoryId,
                                    categoryName: widget.categoryType,
                                  ),
                                )
                              : goto(
                                  context,
                                  AllAdsVerticalList(
                                    category: widget.categoryType,
                                    categoryId: widget.categoryId,
                                  ),
                                );
                        },
                      )
                    ],
                  ),
                  VSpace(10),
                  SizedBox(
                    height: fullHeight(context) * 0.38,
                    child: TabBarView(
                        controller: tabController,
                        children: (widget.categoryId == 7)
                            ? [
                                AdsHorizontalList(
                                  category: widget.categoryType,
                                  categoryId: widget.categoryId,
                                  type: "old",
                                  productType: "sell",
                                ),
                                AdsHorizontalList(
                                  category: widget.categoryType,
                                  categoryId: widget.categoryId,
                                  type: "new",
                                  productType: "sell",
                                ),
                              ]
                            : [
                                RentHorizontalList(
                                  category: widget.categoryType,
                                  categoryId: widget.categoryId,
                                  type: "rent",
                                ),
                                AdsHorizontalList(
                                  category: widget.categoryType,
                                  categoryId: widget.categoryId,
                                  type: "old",
                                  productType: "sell",
                                ),
                                AdsHorizontalList(
                                  category: widget.categoryType,
                                  categoryId: widget.categoryId,
                                  type: "new",
                                  productType: "sell",
                                ),
                              ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
