import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_ads_vertical_list.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_ads_vertical_list.dart';
import 'package:krishivikas/Screens/seeds/seeds_ads_vertical_list.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/krishi_widget_items_list.dart';
import 'package:krishivikas/widgets/view_all_widget.dart';
import '../language/language_key.dart';
import 'filter_page/screen/brand_page.dart';
import 'filter_page/screen/manufacturing_screen.dart';
import 'filter_page/screen/price_page.dart';
import 'filter_page/varieble_const.dart';

class KrishiItemAds extends StatefulWidget {
  final String? tabSeed;
  final String? tabPesticides;
  final String? tabFertilizer;
  final int? seedId;
  final int? pesticidesId;
  final int? fertilizerID;
  final String? categoryTitle;

  const KrishiItemAds({
    this.tabSeed,
    this.tabPesticides,
    this.tabFertilizer,
    this.seedId,
    this.pesticidesId,
    this.fertilizerID,
    this.categoryTitle,
  });

  @override
  State<KrishiItemAds> createState() => _KrishiItemAdsState();
}

class _KrishiItemAdsState extends State<KrishiItemAds> {
  get tabController => null;

  int tabIndex = 0;

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
              padding: EdgeInsets.only(
                left: 10,
                top: 5,
              ),
              child: barlowBold(
                text: widget.categoryTitle!,
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
                      SizedBox(
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
                              onTap: (index) {
                                tabIndex = index;
                              },
                              labelPadding: EdgeInsets.zero,
                              labelColor: black,
                              indicatorColor: black,
                              isScrollable: false,
                              indicatorWeight: 3.0,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorPadding: EdgeInsets.zero,
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
                              tabs: [
                                Tab(
                                  text: "${seeds.tr}",
                                ),
                                Tab(
                                  text: "${pesticides.tr}",
                                ),
                                Tab(
                                  text: "${fertilizer.tr}",
                                )
                              ],
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
                          if (tabIndex == 0) {
                            goto(
                              context,
                              SeedsAdsVerticalList(
                                categoryName: widget.tabSeed,
                                categoryId: widget.seedId,
                              ),
                            );
                          } else if (tabIndex == 1) {
                            goto(
                              context,
                              PesticidesAdsVerticalList(
                                categoryName: widget.tabPesticides,
                                categoryId: widget.pesticidesId,
                              ),
                            );
                          } else if (tabIndex == 2) {
                            goto(
                              context,
                              FertilizerAdsVerticalList(
                                categoryName: widget.tabFertilizer,
                                categoryId: widget.fertilizerID,
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  VSpace(10),
                  SizedBox(
                    height: fullHeight(context) * 0.38,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        KrishiWidgetItemsList(
                          categoryId: widget.seedId,
                        ),
                        KrishiWidgetItemsList(
                          categoryId: widget.pesticidesId,
                        ),
                        KrishiWidgetItemsList(
                          categoryId: widget.fertilizerID,
                        ),
                      ],
                    ),
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
