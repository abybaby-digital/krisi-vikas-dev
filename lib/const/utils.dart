import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import '../language/language_key.dart';
import '../models/filter_validation.dart';

class Utils {
  static Map<String, List<FilterValidation>> mapList = {
    "Type": getTypes(),
    "Condition": getCondition(),
    "State": getState(),
    "Brand": getBrand(),
    "Model": getModel(),
    "Year": getYears(),
    "Price": getPrice(),
  };
  List<String> dataString = [
    brands.tr,
    states.tr,
    district.tr,
    by_year.tr,
    price_page.tr,
    ""
  ];
  List<String> data1String = [
    states.tr,
    district.tr,
    price_page.tr,
    ""
  ];
  static Map<String, List<FilterValidation>> districtList = {};
  static List<int> selectionBrand = [];
  static List<int> selectionModel = [];

  ///Filter Type
  static List<FilterValidation> getTypes() {
    return [
      FilterValidation(isCheck: true, title: 'Buy'),
      FilterValidation(isCheck: false, title: 'Rent'),
    ];
  }

  ///Filter Condition
  static List<FilterValidation> getCondition() {
    return [
      FilterValidation(isCheck: true, title: 'New'),
      FilterValidation(isCheck: false, title: 'Old'),
    ];
  }

  ///Filter State
  static List<FilterValidation> getState() {
    return [
      // for (var stateNames in filterState)
      FilterValidation(isCheck: false, title: ""),
    ];
  }

  ///Filter State
  static List<FilterValidation> getBrand() {
    return [
      FilterValidation(isCheck: false, title: ""),
    ];
  }

  ///Filter State
  static List<FilterValidation> getModel() {
    return [
      FilterValidation(isCheck: false, title: ""),
    ];
  }

  ///Filter State
  static List<FilterValidation> getDistrict() {
    return [
      FilterValidation(isCheck: false, title: ""),
    ];
  }

  static const List<String> year = [];
  static var item;

  ///Filter Year
  static List<FilterValidation> getYears() {
    return [
      for (var i in filterYear) FilterValidation(isCheck: false, title: i),
    ];
  }

  static const List filterTitles = [
    "Type",
    "Condition",
    "State",
    "District",
    "Brand",
    "Model",
    "Price Range",
    "Year of Manufacturing",
  ];

  static const List filterTitlesTwo = [
    "State",
    "District",
    "Price Range",
  ];

  static const List filterTitlesFour = [
    "Type",
    "Condition",
    "District",
    "Price Range",
    "Year of Manufacturing",
  ];

  static const List seedsFertilizerTitles = [
    "State",
    "District",
    "Price Range",
    "Year of Manufacturing",
  ];

  static List<String> filterYear = [
    "2023",
    "2022",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009",
    "2008",
    "2007",
    "2006",
    "2005",
    "2004",
    "2003",
    "2002",
    "2001",
    "2000",
    "1999",
    "1998",
    "1997",
    "1996",
    "1995",
    "1994",
    "1993",
    "1992",
    "1991",
    "1990",
  ];

  static const List filterPrice = [
    "Rs.0 - Rs.50,000",
    "Rs.50,001 - Rs.1,00,000",
    "Rs.1,00,001 - Rs.3,00,000",
    "Rs.3,00,001 - Rs.6,00,000",
    "Rs.6,00,001 - Rs.10,00,000",
    "Rs.10,00,001 - Rs.20,00,000",
    "Rs.20,00,001 - Rs.30,00,000",
    "Rs.30,00,001 - Rs.50,00,000",
  ];

  ///Filter Year
  static List<FilterValidation> getPrice() {
    return [
      for (var i in filterPrice) FilterValidation(isCheck: false, title: i),
    ];
  }

  static String getSelectedValueFor(String key) {
    Iterable<FilterValidation>? data = mapList[key]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      return data.first.title ?? '';
    }
    return '';
  }

  static String getSelectedValueForPrice(String key, String position) {
    Iterable<FilterValidation>? data = mapList[key]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      if (position == "first") {
        return data.first.title ?? '';
      } else {
        return data.last.title ?? '';
      }
    }
    return '';
  }

  static String getSelectedValueForConditionTractor(String key) {
    Iterable<FilterValidation>? data = mapList[key]?.where((element) {
      return element.isCheck == true;
    });
    String ConditionData = "";
    if (data != null) {
      for (var dist in data) {
        // print("dist");
        // print(dist);
        ConditionData =
            ConditionData + dist.title.toString().toLowerCase() + ",";
      }
      // return data.first.id;
    }

    print("ConditionData ===");
    print(ConditionData);
    print("ConditionData ===");
    return ConditionData;
  }

  static int getSelectedValueForId(String key) {
    Iterable<FilterValidation>? data = mapList[key]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      return data.first.id;
    }
    return 0;
  }

  static int getSelectedValueForDistrict(int key) {
    Iterable<FilterValidation>? data =
        districtList[key.toString()]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      return data.first.id;
    }
    return 0;
  }

  static String? getSelectedValueForDistrictTractor() {
    Iterable<FilterValidation>? data = arrayDistrictList.where((element) {
      return element.isCheck == true;
    });
    print("getSelectedValueForDistrictTractor");
    print(data.toString());
    String? DistrictData = "";
    if (data.isNotEmpty) {
      for (var dist in data) {
        // print("dist");
        // print(dist);
        DistrictData = DistrictData! + dist.id.toString() + ",";
      }
      // return data.first.id;
    }

    print("DistrictData ===");
    print(DistrictData);
    print("DistrictData ===");
    return DistrictData;
  }

  ///Filter Data List
  List<FilterValidation> filterByIndexValue(
    int filterIndex,
  ) {
    switch (filterIndex) {
      case 0:
        return mapList["Type"] ?? [];

      case 1:
        return mapList["Condition"] ?? [];

      case 2:
        return mapList["State"] ?? [];

      case 3:
        return districtList[
                SharedPreferencesFunctions().getFilterStateId().toString()] ??
            [];

      case 4:
        return mapList["Brand"] ?? [];

      case 5:
        return mapList["Model"] ?? [];

      case 6:
        return mapList['Price'] ?? [];

      case 7:
        return mapList["Year"] ?? [];

      default:
        return [];
    }
  }

  List<FilterValidation> filterByIndexValueFour(
    int filterIndex,
  ) {
    switch (filterIndex) {
      case 0:
        return mapList["Type"] ?? [];

      case 1:
        return mapList["Condition"] ?? [];

      case 2:
        return arrayDistrictList;

      case 3:
        return mapList['Price'] ?? [];

      case 4:
        return mapList["Year"] ?? [];

      default:
        return [];
    }
  }

  // Tyre Filter Section

  static Map<String, List<FilterValidation>> mapListTyre = {
    "Condition": getCondition(),
    "Price": getPriceForTyre(),
  };

  List<FilterValidation> filterByIndexValueTyre(
    int filterIndex,
  ) {
    switch (filterIndex) {
      case 0:
        return mapListTyre["Condition"] ?? [];

      case 1:
        return arrayDistrictList;

      case 2:
        return mapListTyre['Price'] ?? [];

      default:
        return [];
    }
  }

  static const List filterTitlesTyre = [
    "Condition",
    "District",
    "Price Range",
  ];

  static const List filterPriceForTyre = [
    "Rs.0 - Rs.5,000",
    "Rs.5,001 - Rs.10,000",
    "Rs.10,001 - Rs.20,000",
    "Rs.20,001 - Rs.30,000",
    "Rs.30,001 - Rs.40,000",
    "Rs.40,001 - Rs.50,000",
    "Rs.50,001 - Rs.1,00,000",
  ];

  static List<FilterValidation> getPriceForTyre() {
    return [
      for (var i in filterPriceForTyre)
        FilterValidation(isCheck: false, title: i),
    ];
  }

  static String getSelectedValueForPriceTyre(String key, String position) {
    Iterable<FilterValidation>? data = mapListTyre[key]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      if (position == "first") {
        return data.first.title ?? '';
      } else {
        return data.last.title ?? '';
      }
    }
    return '';
  }

  static String getSelectedValueForConditionTyre(String key) {
    Iterable<FilterValidation>? data = mapListTyre[key]?.where((element) {
      return element.isCheck == true;
    });
    String ConditionData = "";
    if (data != null) {
      for (var dist in data) {
        // print("dist");
        // print(dist);
        ConditionData =
            ConditionData + dist.title.toString().toLowerCase() + ",";
      }
      // return data.first.id;
    }

    print("ConditionData ===");
    print(ConditionData);
    print("ConditionData ===");
    return ConditionData;
  }

  // Tyre Filter Section

  // Seeds Filter Section

  static Map<String, List<FilterValidation>> mapListSeeds = {
    "Price": getPriceForSeeds(),
  };

  static const List filterTitlesSeeds = [
    "Price Range",
    "District",
  ];

  static const List filterPriceForSeeds = [
    "Rs.0 - Rs.2,000",
    "Rs.2,001 - Rs.5,000",
    "Rs.5,001 - Rs.15,000",
    "Rs.15,001 - Rs.30,000",
    "Rs.30,001 - Rs.40,000",
    "Rs.40,001 - Rs.50,000",
    "Rs.50,001 - Rs.1,00,000",
  ];

  static List<FilterValidation> getPriceForSeeds() {
    return [
      for (var i in filterPriceForSeeds)
        FilterValidation(isCheck: false, title: i),
    ];
  }

  static String getSelectedValueForPriceSeeds(String key, String position) {
    Iterable<FilterValidation>? data = mapListSeeds[key]?.where((element) {
      return element.isCheck == true;
    });

    if (data != null && data.isNotEmpty) {
      if (position == "first") {
        return data.first.title ?? '';
      } else {
        return data.last.title ?? '';
      }
    }
    return '';
  }

  List<FilterValidation> filterByIndexValueSeeds(
    int filterIndex,
  ) {
    switch (filterIndex) {
      case 0:
        return mapListSeeds['Price'] ?? [];

      case 1:
        return arrayDistrictList;

      default:
        return [];
    }
  }

  // Seeds Filter Section

  static String capturedImagePath = "";

  static String platformVersion = 'Unknown';
  static String imeiNo = "";
  static String modelName = "";
  static String manufacturerName = "";
  static dynamic apiLevel;
  static dynamic addressInfoData;
  static dynamic zipcodeData;

  static getUserCurrentLocationUtils() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserZipcode();

    zipcodeData = SharedPreferencesFunctions.zipcode.toString();
    addressInfoData = await ApiMethods().getDataByPostApi(
      {"pincode": SharedPreferencesFunctions.zipcode},
      baseUrl + zipCodeUrl,
    );
    if (addressInfoData.isNotEmpty) {
      SharedPreferencesFunctions()
          .saveCountryId(addressInfoData[0]["country_id"]);
      SharedPreferencesFunctions().saveStateId(addressInfoData[0]["state_id"]);
      SharedPreferencesFunctions()
          .saveStateName(addressInfoData[0]["state_name"]);
      SharedPreferencesFunctions()
          .saveDistrictId(addressInfoData[0]["district_id"]);
      SharedPreferencesFunctions()
          .saveDistrictName(addressInfoData[0]["district_name"]);
      SharedPreferencesFunctions().saveCityId(addressInfoData[0]["city_id"]);
      SharedPreferencesFunctions()
          .saveCityName(addressInfoData[0]["city_name"]);
    }
  }
}
