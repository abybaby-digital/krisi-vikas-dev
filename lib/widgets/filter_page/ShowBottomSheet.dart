import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/filter_page/screen/brand_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/district_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/manufacturing_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/price_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/state_screen.dart';
import 'package:krishivikas/widgets/filter_page/tyre_screen.dart';
import 'package:krishivikas/widgets/filter_page/varieble_const.dart';
import 'package:krishivikas/widgets/filter_page/vehicle_filter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../const/colors.dart';
import '../../Screens/tractor/all_ads_vertical_list.dart';
import '../../Screens/tyres/tyres_ads_vertical_list.dart';
import '../../const/utils.dart';
import 'Api/api_method.dart';
import 'harvester_filter_screen.dart';
import 'inplement_screen.dart';
import 'shared_preference.dart';
import 'tractor_filter.dart';
class ShowBottomSheet {
  static void show(
    BuildContext context,
    PageController pageController,
    int selectedIndex,
    String item,
    String type,
    String categoryID,
  ) {
    bool isLoading = false;
    bool isApplyLoading = false;
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
                                            Utils().dataString[index],
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
                        itemCount: Utils().dataString.length,
                      ),
                    ),
                    // VerticalDivider(thickness: 1,),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        children:  [
                          BrandPage(),
                          StateScreen(item: item,),
                          DistrictListWidget(item: item),
                          ManufacturingScreen(),
                          PricePage()
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
                    child: isLoading
                        ?  SizedBox(
                            width: 20,
                            height: 20,
                            child: progressIndicator(context)
                          )
                        : Text(
                            clear.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                    onPressed: ()  {
                      setState(() {
                        isLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 5), ()  {
                        if (stateId == "" && districtId == "" && priceStart == "0" && priceEnd == "5000" && byYear == ""){
                          priceStart = "0";
                          priceEnd = "50000";
                          byYear = "";
                          selectedItems = [];
                          selectedContainerIndex = -1;
                          selectedPriceIndex = -1;
                          closeBottomSheet(context);
                        }else{
                          priceStart = "0";
                          priceEnd = "50000";
                          byYear = "";
                          selectedItems = [];
                          selectedContainerIndex = -1;
                          selectedPriceIndex = -1;
                          closeBottomSheet(context);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    color: darkgreen,
                    child: isApplyLoading
                        ?  SizedBox(
                        width: 20,
                        height: 20,
                        child: progressIndicator(context)
                    )
                        : Text(
                      apply.tr,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setState(() {
                        isApplyLoading = true;
                      });
                      Future.delayed(const Duration(seconds: 5), ()  {
                        if (item == tractor.tr) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => FilterScreen(
                                categoryId: categoryID,
                                type: item,
                                currentTabType: type,
                              ),
                            ),
                          );
                        } else if (item == goodsVehicle.tr) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => VahicleFilterScreen(
                                categoryId: categoryID,
                                type: item,
                                currentTabType: type,
                              ),
                            ),
                          );
                        } else if (item == harvester.tr) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => HarvesterFilterScreen(
                                categoryId: categoryID,
                                type: item,
                                currentTabType: type,
                              ),
                            ),
                          );
                        } else if (item == implement.tr) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ImplementScreen(
                                categoryId: categoryID,
                                type: item,
                                currentTabType: type,
                              ),
                            ),
                          );
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => TyreScreen(
                                type: item,
                                currentTabType: type,
                                categoryId: categoryID,
                              ),
                            ),
                          );
                        }

                        setState(() {
                          isApplyLoading = false;
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
