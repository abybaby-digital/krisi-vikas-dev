import 'package:krishivikas/widgets/filter_page/shared_preference.dart';

import 'Api/api_method.dart';
import 'Model/pin_code_nodel.dart';
import 'Model/tractor_model.dart';

var type = "";
var allType = "";
String tabtype = "";
String currentType = "";
var typeScreen = "";
var condition = "";
String brandId = "";
String category = "";
String priceStart = "0";
String priceEnd = "50000";
String byYear = "";
String districtId = "";
String stateId = "";
String stateNam = "";
List<PinCodeDatum> listData = [];
List<Tractor> apiValues = [];
