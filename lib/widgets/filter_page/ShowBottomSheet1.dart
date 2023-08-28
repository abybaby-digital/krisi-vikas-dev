import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/widgets/filter_page/Api/api_method.dart';
import 'package:krishivikas/widgets/filter_page/screen/brand_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/district_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/manufacturing_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/price_tyre_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/state_screen.dart';
import 'package:krishivikas/widgets/filter_page/sedds.dart';
import 'package:krishivikas/widgets/filter_page/shared_preference.dart';
import 'package:krishivikas/widgets/filter_page/varieble_const.dart';
import '../../const/colors.dart';
import '../../const/utils.dart';
import '../../language/language_key.dart';
import '../all_widgets.dart';
import 'Fertilizers.dart';
import 'Pesticides.dart';

class ShowBottomSheet1 {
  static void show1(BuildContext context, PageController pageController,
      int selectedIndex, String item) {
    bool checkLoading = false;
    bool applyLoading = false;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: darkgreen,
                title: Text(filters.tr),
              ),
              body: SafeArea(
                child: Row(
                  children: [
                    SizedBox(
                      width: 120,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 5,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                pageController.jumpToPage(index);
                              });
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      width: 5,
                                      height: (selectedIndex == index) ? 50 : 0,
                                      color: Colors.blue,
                                    ),
                                    Expanded(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        height: 40,
                                        alignment: Alignment.center,
                                        color: (selectedIndex == index
                                            ? Colors.white.withOpacity(0.2)
                                            : Colors.grey.withOpacity(0.2)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 5),
                                          child: Text(
                                            Utils().data1String[index],
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight:
                                                  (selectedIndex == index
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: Utils().data1String.length,
                      ),
                    ),
                    // VerticalDivider(thickness: 1,),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children:  [
                          StateScreen(item: item),
                          DistrictListWidget(item: item),
                          PriceTyrePage()
                        ],
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    color: Colors.lightGreen,
                    child: checkLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: progressIndicator(context))
                        : Text(
                            clear.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: () {
                      setState(() {
                        checkLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 5), () {
                        if (stateId == "" &&
                            districtId == "" &&
                            priceStart == "0" &&
                            priceEnd == "5000" &&
                            byYear == "") {
                          priceStart = "0";
                          priceEnd = "50000";
                          selectedContainerIndex = -1;
                          selectedPriceIndex = -1;
                          closeBottomSheet(context);
                        } else {
                          priceStart = "0";
                          priceEnd = "50000";
                          selectedContainerIndex = -1;
                          selectedPriceIndex = -1;
                          closeBottomSheet(context);
                        }
                        setState(() {
                          checkLoading = false;
                        });
                      });
                    },
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    color: darkgreen,
                    child: applyLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: progressIndicator(context))
                        : Text(
                            apply.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: () {
                      setState(() {
                        applyLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 5), () {
                        if (item == seeds.tr) {
                          goto(
                            context,
                            SeedsScreen(
                              type: item,
                            ),
                          );
                        } else if (item == pesticides.tr) {
                          goto(
                            context,
                            PesticidesScreen(
                              type: item,
                            ),
                          );
                        } else if(item == fertilizer.tr){
                          goto(
                            context,
                            FertilizersScreen(
                              type: item,
                            ),
                          );
                        }
                        setState(() {
                          applyLoading = false;
                        });
                      });
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}

void closeBottomSheet(BuildContext context) {
  Navigator.of(context).pop();
}
