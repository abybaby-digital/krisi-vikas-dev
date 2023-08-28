import 'package:krishivikas/widgets/filter_page/screen/brand_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/district_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/manufacturing_screen.dart';
import 'package:krishivikas/widgets/filter_page/screen/price_page.dart';
import 'package:krishivikas/widgets/filter_page/screen/state_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? _preferences;

  // Method to initialize shared preferences
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Method to save a value to shared preferences
  static Future<void> setValue(var coustomKey, dynamic value) async {
    if (_preferences == null) {
      await init();
    }
    if (value is String) {
      await _preferences?.setString(coustomKey, value);

    } else if (value is int) {
      await _preferences?.setInt(coustomKey, value);

    } else if (value is bool) {
      await _preferences?.setBool(coustomKey, value);
    } else if (value is double) {
      await _preferences?.setDouble(coustomKey, value);
    }
  }

  // Method to retrieve a value from shared preferences
  static dynamic getValue(String key) {
    if (_preferences == null) {
      return null;
    }
    return _preferences?.get(key);
  }

  // Method to remove a value from shared preferences
  static Future<void> removeValue(String key, dynamic value) async {
    if (_preferences == null) {
      await init();
    }
    await _preferences?.remove(key,);

  }
  static Future<void> clearAllSharedPreferences() async {
    await _preferences?.clear();
    selectedItems = [];
    selectedStateItems = [];
    selectedDistrictItems = [];
    selectedContainerIndex = -1;
    selectedPriceIndex = -1;
  }
}