import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
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
class FilterScreen extends StatefulWidget {
  // List ds;

  int? CatId;

  FilterScreen(
    this.CatId,
  );

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int menuIndex = 0;

  bool isDataObtained = false;

  String FilterMenu = "";

  bool individual = false;

  List stateList = [];

  List filterState = [];

  List stateParticularId = [];

  List brandList = [];

  List filterBrand = [];

  List modelList = [];

  List filterModel = [];

  List filterDistrict = [];

  List districtList = [];

  @override
  void initState() {
    getFilterStateList();
    getFilterBrandList();

    if (widget.CatId != 0) {
      SharedPreferencesFunctions().saveCategoryId(widget.CatId.toString());
      // SharedPreferencesFunctions().saveFilterBrandId(widget.ds[0]['brand_id']);
    }
    // getFilterModelList(brandList[0]);

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
      body: Row(
        children: [
          ///Filter Menu
          Container(
            color: Colors.grey[300],
            width: MediaQuery.of(context).size.width * 0.35,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: Utils.filterTitles.length,
                  shrinkWrap: true,
                  itemBuilder: (context, int index) {
                    return FilterTitleWidget(
                      filterTitle: Utils.filterTitles[index],
                      isSelected: individual,
                      colorSelect:
                          menuIndex == index ? white : Colors.grey[300],
                      index: index,
                      onValueChanged: (value) {
                        setState(() {
                          individual = value;
                          menuIndex = index;
                          FilterMenu = Utils.filterTitles[index];

                          getFilterDistrictList();                          
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
            Utils().filterByIndexValue(menuIndex),
            FilterMenu,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: CommonBottomButtonsWidget(
          bottomButtonTitle1: "Clear",
          onTap1: () {
            resetFilterData();
          },
          bottomButtonTitle2: apply.tr,
          onTap2: () {
            checkProductIdInFilter(
              // int.parse(SharedPreferencesFunctions().getCategoryId()!)
              int.parse(
                widget.CatId.toString(),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<dynamic>> getFilterStateList() async {
    var result = await ApiMethods().getStateData(
      baseUrl + stateUrl,
    );

    List<FilterValidation> arrayList = [];
    result.forEach(
      (element) {
        filterState.add(
          element['state_name'],
        );
        stateParticularId.add(
          element['id'],
        );

        isDataObtained = true;
        var filter = FilterValidation(
          title: element['state_name'],
          isCheck: SharedPreferencesFunctions().getFilterStateId() != null &&
                  SharedPreferencesFunctions().getFilterStateId() ==
                      element['id']
              ? true
              : false,
          id: element['id'],
        );

        arrayList.add(filter);
      },
    );
    Utils.mapList["State"] = arrayList;

    setState(() {});
    return Future.value(this.stateList);
  }

  ///Filter Brand Api Call Function.
  Future<List<dynamic>> getFilterBrandList() async {
    brandList = await ApiMethods().getBrandsByPostApi(
      baseUrl + brandUrl,
      int.parse(widget.CatId.toString()),
    );

    List<FilterValidation> arrayBrandList = [];
    brandList.forEach(
      (element) {
        filterBrand.add(
          element['name'],
        );
        isDataObtained = true;
        var Brandfilter = FilterValidation(
          title: element['name'],
          isCheck: false,
          id: element['id'],
        );
        arrayBrandList.add(Brandfilter);
      },
    );
    Utils.mapList["Brand"] = arrayBrandList;
    setState(() {});
    return Future.value(this.brandList);
  }

  // Filter Model Api Call Function.
  Future<List<dynamic>> getFilterModelList(brandId) async {
    modelList = await ApiMethods().getModelsByPostApi(
        baseUrl + modelUrl,
        int.parse(SharedPreferencesFunctions().getCategoryId()!),
        // int.parse(SharedPreferencesFunctions().geteFilterBrandId()!)
        // int.parse(widget.ds[0]['category_id']),
        int.parse(brandId.toString()),
        );
    List<FilterValidation> arrayModelList = [];
    modelList.forEach(
      (element) {
        filterModel.add(
          element['model_name'],
        );
        isDataObtained = true;
        var Modelfilter = FilterValidation(
          title: element['model_name'],
          isCheck: false,
          id: element['id'],
        );
        arrayModelList.add(Modelfilter);
      },
    );
    Utils.mapList["Model"] = arrayModelList;

    setState(() {});
    return Future.value(this.modelList);
  }

  ///Filter District Api Call Function.
  Future<List<dynamic>> getFilterDistrictList() async {
    districtList = await ApiMethods().getCitiesByPostApi(
      baseUrl + districtUrl,
      SharedPreferencesFunctions().getFilterStateId().toString(),
    );

    List<FilterValidation> arrayDistrictList = [];
    districtList.forEach((element) {
      filterDistrict.add(
        element['district_name'],
      );
      isDataObtained = true;
      var Districtfilter = FilterValidation(
        title: element['district_name'],
        isCheck: false,
        id: element['id'],
      );
      arrayDistrictList.add(Districtfilter);
    });
    if (Utils.districtList[
            SharedPreferencesFunctions().getFilterStateId().toString()] ==
        null) {
      Utils.districtList[SharedPreferencesFunctions()
          .getFilterStateId()
          .toString()] = arrayDistrictList;
      setState(() {});
    }

    return Future.value(this.districtList);
  }

  filterOfProductMethod(String url) async {
    await SharedPreferencesFunctions().getUserId();

    await SharedPreferencesFunctions().getToken();

    var stateId = Utils.getSelectedValueForId("State");

    var districtData = Utils.getSelectedValueForDistrict(stateId);

    var priceStarts = Utils.getSelectedValueFor("Price");

    var priceRange = priceStarts.replaceAll("Rs.", " ").split("-");

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "type": Utils.getSelectedValueFor("Condition"),
      "set": Utils.getSelectedValueFor('Type'),
      "state": stateId != 0 ? stateId : SharedPreferencesFunctions.stateId,
      "district": districtData != 0
          ? districtData
          : SharedPreferencesFunctions.districtId,
      "skip": 0,
      "take": 100,
      "purchase_year": Utils.getSelectedValueFor("Year"),
      "price_start": priceRange[0].trim(),
      "price_end": priceRange[1].trim(),
    };

    var result = await ApiMethods().getApplyFilter(
      url,
      data,
    );

    var responseList = result;

    // ///Brand Filter
    // List<String> selectionBrands =
    //     Utils.selectionBrand.map((e) => e.toString()).toList();
    // var brandResultData = result
    //     .where((element) => selectionBrands.contains(element['brand_id']));

    // ///Model Filter
    // List<String> selectionModels =
    //     Utils.selectionModel.map((e) => e.toString()).toList();
    // var modelResultData = result
    //     .where((element) => selectionModels.contains(element['model_id']));

    // if (brandResultData.isNotEmpty) {
    //   responseList.addAll(brandResultData);
    // }
    // if (modelResultData.isNotEmpty) {
    //   responseList.addAll(modelResultData);
    // }


    Navigator.pop(context, responseList);
  }

  checkProductIdInFilter(productFilterId) {
    switch (productFilterId) {
      case 1:
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

      case 6:
        return filterOfProductMethod(
          baseUrl + seedsFilterUrl,
        );

      case 7:
        return filterOfProductMethod(
          baseUrl + tyresFilterUrl,
        );

      case 8:
        return filterOfProductMethod(
          baseUrl + pesticidesFilterUrl,
        );

      case 9:
        return filterOfProductMethod(
          baseUrl + fertilizerFilterUrl,
        );

      default:
        return noDataFound.tr;
    }
  }

  resetFilterData() {}
}
