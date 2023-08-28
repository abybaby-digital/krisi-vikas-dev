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
class FilterScreenTyre extends StatefulWidget {
  int? CatId;

  FilterScreenTyre(
    this.CatId,
  );

  @override
  State<FilterScreenTyre> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreenTyre> {
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

    print("Tyre Filter Page Category Id");
    print(widget.CatId.toString());
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
                itemCount: Utils.filterTitlesTyre.length,
                shrinkWrap: true,
                itemBuilder: (context, int index) {
                  return FilterTitleWidget(
                    filterTitle: Utils.filterTitlesTyre[index],
                    isSelected: individual,
                    colorSelect: menuIndex == index ? white : Colors.grey[300],
                    index: index,
                    onValueChanged: (value) {
                      setState(() {
                        individual = value;
                        menuIndex = index;
                        FilterMenu = Utils.filterTitlesTyre[index];
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
          Utils().filterByIndexValueTyre(menuIndex),
          FilterMenu,
        ),
      ],
    );
  }

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

    String? districtData = Utils.getSelectedValueForDistrictTractor();

    var priceStarts = Utils.getSelectedValueForPriceTyre("Price", "first");

    var pricelast = Utils.getSelectedValueForPriceTyre("Price", "last");

    var priceRangefirst = priceStarts.replaceAll("Rs.", " ").split("-");

    var priceRangelast = pricelast.replaceAll("Rs.", " ").split("-");

    var TypeData = Utils.getSelectedValueForConditionTractor('Condition');


    print("priceRangefirst");
    print(priceRangefirst);
    print(priceRangefirst == []);
    print("priceRangelast");
    print(priceRangelast);
    print(priceRangelast == []);
    // print("PurchaseYearData");
    // print(PurchaseYearData);
    // print("districtData");
    // print(districtData);

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "type": TypeData,
      "state": 37,
      "district": districtData != ""
          ? districtData.toString()
          : SharedPreferencesFunctions.districtId.toString(),
      "skip": 0,
      "take": 100,
      "price_start": priceRangefirst == [] ? priceRangefirst[0].trim() : 0,
      "price_end": priceRangelast == [] ? priceRangelast[1].trim() : 5000000,
    };

    var result = await ApiMethods().getApplyFilter(
      url,
      data,
    );
    var responseList = result;

    print("Send Data");
    print(data);

    print("responseList Data");
    print(responseList);

    Navigator.pop(context, responseList);

    setState(() {
      IsPressedFilterButton = false;
    });
  }

  checkProductIdInFilter(productFilterId) {
    switch (productFilterId) {
      case 7:
        return filterOfProductMethod(
          baseUrl + tyresFilterUrl,
        );

      default:
        return noDataFound.tr;
    }
  }

  resetFilterData() {
    print("On click Clear");
    // getFilterDistrictList();
    setState(() {
      // filterPage();
    });
  }
}
