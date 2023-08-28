import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/const/utils.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/common_bottom_buttons_widget.dart';
import 'package:krishivikas/Screens/filter/filtter_widget/filter_title_widget.dart';
import '../../models/filter_validation.dart';
import 'filtter_widget/filter_menu_item_widget.dart';

// ignore: must_be_immutable
class FilterScreenFour extends StatefulWidget {
  int? CatId;

  FilterScreenFour(
    this.CatId,
  );

  @override
  State<FilterScreenFour> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreenFour> {
  int menuIndex = 0;

  bool isDataObtained = false;

  String FilterMenu = "";

  bool individual = false;

  List filterDistrict = [];

  List districtList = [];

  @override
  void initState() {
    IsPressedFilterButton = false;
    arrayDistrictList = [];
    getFilterDistrictList();

    if (widget.CatId != 0) {
      SharedPreferencesFunctions().saveCategoryId(widget.CatId.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: "Filters",
          color: white,
          size: 20,
        ),
      ),
      body: filterPage(),
      bottomNavigationBar: Container(
        height: 50,
        child: CommonBottomButtonsWidget(
          bottomButtonTitle1: "Clear",
          onTap1: () {
            resetFilterData();
          },
          bottomButtonTitle2: apply.tr,
          onTap2: () {
            setState(() {
              IsPressedFilterButton = true;
            });
            checkProductIdInFilter(
              int.parse(
                widget.CatId.toString(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget filterPage() {
    return Row(
      children: [
        ///Filter Menu
        Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            children: [
              ListView.builder(
                itemCount: Utils.filterTitlesFour.length,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return FilterTitleWidget(
                    filterTitle: Utils.filterTitlesFour[index],
                    isSelected: individual,
                    colorSelect: menuIndex == index ? white : Colors.grey[300],
                    index: index,
                    onValueChanged: (value) {
                      setState(() {
                        individual = value;
                        menuIndex = index;
                        FilterMenu = Utils.filterTitlesFour[index];
                        // getFilterDistrictList();
                      });
                    },
                  );
                },
              ),
            ],
          ),
        ),

        ///Filter Menu Items
        FilterMenuItemWidget(
          Utils().filterByIndexValueFour(menuIndex),
          FilterMenu,
        ),
      ],
    );
  }

  // Future<List<dynamic>> getFilterStateList() async {
  //   var result = await ApiMethods().getStateData(
  //     baseUrl + stateUrl,
  //   );

  //   List<FilterValidation> arrayList = [];
  //   result.forEach(
  //     (element) {
  //       filterState.add(
  //         element['state_name'],
  //       );
  //       stateParticularId.add(
  //         element['id'],
  //       );

  //       isDataObtained = true;
  //       var filter = FilterValidation(
  //         title: element['state_name'],
  //         isCheck: SharedPreferencesFunctions().getStateId() != null &&
  //                 SharedPreferencesFunctions().getStateId() == element['id']
  //             ? true
  //             : false,
  //         id: element['id'],
  //       );

  //       arrayList.add(filter);
  //     },
  //   );
  //   Utils.mapList["State"] = arrayList;

  //   setState(() {});
  //   return Future.value(this.stateList);
  // }

  ///Filter Brand Api Call Function.
  // Future<List<dynamic>> getFilterBrandList() async {
  //   brandList = await ApiMethods().getBrandsByPostApi(
  //     baseUrl + brandUrl,
  //     int.parse(widget.CatId.toString()),
  //   );

  //   List<FilterValidation> arrayBrandList = [];
  //   brandList.forEach(
  //     (element) {
  //       filterBrand.add(
  //         element['name'],
  //       );
  //       isDataObtained = true;
  //       var Brandfilter = FilterValidation(
  //         title: element['name'],
  //         isCheck: false,
  //         id: element['id'],
  //       );
  //       arrayBrandList.add(Brandfilter);
  //     },
  //   );
  //   Utils.mapList["Brand"] = arrayBrandList;
  //   setState(() {});
  //   return Future.value(this.brandList);
  // }

  ///Filter District Api Call Function.
  Future<List<dynamic>> getFilterDistrictList() async {
    var currentStateId = "37",
        districtList = await ApiMethods().getCitiesByPostApi(
          baseUrl + districtUrl,
          currentStateId,
        );

    // List<FilterValidation> arrayDistrictList = [];
    districtList.forEach((element) {
      filterDistrict.add(
        element['district_name'],
      );
      isDataObtained = true;
      var Districtfilter = FilterValidation(
        title: element['district_name'],
        isCheck: SharedPreferencesFunctions().getDistrictId() != null &&
                SharedPreferencesFunctions().getDistrictId() == element['id']
            ? true
            : false,
        id: element['id'],
      );
      arrayDistrictList.add(Districtfilter);
    });

    return Future.value(this.districtList);
  }

  filterOfProductMethod(String url) async {
    await SharedPreferencesFunctions().getUserId();

    await SharedPreferencesFunctions().getToken();

    // var districtData = Utils.getSelectedValueForDistrict(stateId);

    String? districtData = Utils.getSelectedValueForDistrictTractor();

    var priceStarts = Utils.getSelectedValueForPrice("Price", "first");

    var pricelast = Utils.getSelectedValueForPrice("Price", "last");

    var priceRangefirst = priceStarts.replaceAll("Rs.", " ").split("-");

    var priceRangelast = pricelast.replaceAll("Rs.", " ").split("-");

    var TypeData = Utils.getSelectedValueForConditionTractor('Condition');

    var SetData = Utils.getSelectedValueForConditionTractor('Type');

    var PurchaseYearData = Utils.getSelectedValueForConditionTractor("Year");

    // print("priceRange");
    // // print(priceRange);/
    // print("PurchaseYearData");
    // print(PurchaseYearData);
    // print("districtData");
    // print(districtData);

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      // "type": Utils.getSelectedValueFor("Condition"),
      "type": TypeData,
      "set": SetData,
      "state": 37,
      "district": districtData != ""
          ? districtData.toString()
          : SharedPreferencesFunctions.districtId.toString(),
      "skip": 0,
      "take": 100,
      "purchase_year": PurchaseYearData,
      "price_start": priceRangefirst == [] ? priceRangefirst[0].trim() : 0,
      "price_end": priceRangelast == [] ? priceRangelast[1].trim() : 5000000,
    };

    var result = await ApiMethods().getApplyFilter(
      url,
      data,
    );

    print("Send Data");
    print(data);
    print("Res Data");
    print(result);

    var responseList = result;

    Navigator.pop(context, responseList);

    setState(() {
      IsPressedFilterButton = false;
    });
  }

  checkProductIdInFilter(productFilterId) {
    switch (productFilterId) {
      case 1:
        print(baseUrl + tractorFilterUrl);
        return filterOfProductMethod(
          baseUrl + tractorFilterUrl,
        );

      case 3:
        return filterOfProductMethod(
          baseUrl + goodsVehicleFilterUrl,
        );

      case 4:
        return filterOfProductMethod(
          baseUrl + harvesterFilterUrl,
        );

      case 5:
        return filterOfProductMethod(
          baseUrl + implementsFiltertUrl,
        );

      default:
        return noDataFound.tr;
    }
  }

  resetFilterData() {
    // getFilterDistrictList();
    setState(() {
      Utils.getTypes();
      Utils.getCondition();
      Utils.getYears();
      Utils.getPrice();
    });
  }
}
