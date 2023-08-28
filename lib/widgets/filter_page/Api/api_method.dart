import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../const/api_urls.dart';
import '../../../services/save_user_info.dart';
import '../Model/StateModel.dart';
import '../Model/brand_model.dart';
import '../Model/district_model.dart';
import '../Model/pin_code_nodel.dart';
import '../Model/price_model.dart';
import '../varieble_const.dart';

// Api Brand
class ApiRemotes {
  var headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '*',
  };
  Future<Brand?> brandData(String categoryId) async {
    Map data = {"category": categoryId};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + brandUrl),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      return Brand.fromJson(responseData);
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}
// Api District
class ApiDRemotes {
  var headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '*',
  };
  Future<DistrictModel?> brandData(String stateId) async {
    Map data = {"state": stateId,"type":condition};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + stateDistrictUrl),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      return DistrictModel.fromJson(responseData);
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}
// Api State
class ApiStateRemotes {
  var headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '*',
  };
  Future<StateModel?> brandData() async {
    Map data = {"type": condition};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + stateCounterUrl),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      return StateModel.fromJson(responseData);
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}

// Api prices
class ApiPriceRemotes {
  var headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '*',
  };
  Future<PriceModel?> brandData(String start ,String end) async {
    Map data = {"price_start": start,"price_end":end};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + priceCounterUrl),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      return PriceModel.fromJson(responseData);
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}
class PinCode {
  var brand = '';
  var headers = {
    "Accept": "application/json",
    "Access-Control_Allow_Origin": "*",
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: '*',
  };
  Future<PinCodeModal?> PinData() async {
    Map data = {"pincode":SharedPreferencesFunctions.zipcode};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + pincodeUrl),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      return PinCodeModal.fromJson(responseData);
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}