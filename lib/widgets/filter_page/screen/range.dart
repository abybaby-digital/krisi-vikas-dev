import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final String _kRangeSliderValueKey = 'range_slider_value';

  static Future<double> getRangeSliderValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_kRangeSliderValueKey) ?? 0.0;
  }

  static Future<bool> setRangeSliderValue(double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(_kRangeSliderValueKey, value);
  }
}