// ignore_for_file: body_might_complete_normally_nullable, unnecessary_cast

import 'dart:convert';

import 'package:krishivikas/controllers/providers.dart';
import 'package:krishivikas/main.dart';

import '../Screens/search_screen/category_model.dart';
import '../widgets/filter_page/Model/tractor_model.dart';

// Category configs
const String categoryKey = "KV_CATEGORY";

Future setCategoryData(dynamic json) async {
  try {
    await preferences.setString(categoryKey, jsonEncode(json));
  } catch (e) {
    print("Set Category Error" + e.toString());
  }
}

Future<List<Category>?> getCategoryData() async {
  try {
    List data = await jsonDecode(preferences.getString(categoryKey) ?? '[]');
    if (data.isNotEmpty) {
      return (data as List).map((e) => Category.fromJson(e)).toList();
    }
  } catch (e) {
    print("Get Category Error" + e.toString());
  }
}

// Tractor configs
const String usedTractorKey = "KV_USEDTRACTOR";
const String newTractorKey = "KV_NEWTRACTOR";
const String rentTractorKey = "KV_RENTTRACTOR";

// used tractor
Future setUsedTractordata(dynamic json) async {
  try {
    await preferences.setString(usedTractorKey, jsonEncode(json));
  } catch (e) {
    print("Set Category Error" + e.toString());
  }
}

Future getUsedTractordata() async {
  tractorAdsDataProvider.setLoading = true;
  try {
    List data = await jsonDecode(preferences.getString(usedTractorKey) ?? '[]');
    if (data.isNotEmpty) {
      tractorAdsDataProvider.setUsedData(
          List.from(data.map((e) => Tractor.fromJson(e)).toList()));
    }
  } catch (e) {
    print("Get Category Error" + e.toString());
  }
  tractorAdsDataProvider.setLoading = false;
}

// new tractor
Future setNewTractordata(dynamic json) async {
  try {
    await preferences.setString(newTractorKey, jsonEncode(json));
  } catch (e) {
    print("Set Category Error" + e.toString());
  }
}

Future getNewTractordata() async {
  tractorAdsDataProvider.setLoading = true;
  try {
    List data = await jsonDecode(preferences.getString(newTractorKey) ?? '[]');
    if (data.isNotEmpty) {
      tractorAdsDataProvider
          .setNewData(List.from(data.map((e) => Tractor.fromJson(e)).toList()));
    }
  } catch (e) {
    print("Get Category Error" + e.toString());
  }
  tractorAdsDataProvider.setLoading = false;
}

// rent tractor
Future setRentTractordata(dynamic json) async {
  try {
    await preferences.setString(rentTractorKey, jsonEncode(json));
  } catch (e) {
    print("Set Category Error" + e.toString());
  }
}

Future getRentTractordata() async {
  tractorAdsDataProvider.setLoading = true;
  try {
    List data = await jsonDecode(preferences.getString(rentTractorKey) ?? '[]');
    if (data.isNotEmpty) {
      tractorAdsDataProvider.setRentData(
          List.from(data.map((e) => Tractor.fromJson(e)).toList()));
    }
  } catch (e) {
    print("Get Category Error" + e.toString());
  }
  tractorAdsDataProvider.setLoading = false;
}
