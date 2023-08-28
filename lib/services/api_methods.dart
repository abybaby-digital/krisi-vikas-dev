import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/screens/Iffco/IFFCO_Model.dart';
import 'package:krishivikas/services/save_user_info.dart';
import '../screens/Iffco/IFFCO_Check/IFFCO_Check_Model.dart';
import '../screens/Iffco/Product_Model.dart';
import '../screens/disableScreen/enableModel.dart';
import '../screens/maintenace/maintenance_model.dart';
import '../screens/referral/referralModel.dart';

class ApiMethods {
  Future<List> deleteProductsByPostApi(
      String url, Map<String, dynamic> product) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(product), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getProductsByPostApi(
      String url, Map<String, dynamic> product) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(product), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }

        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());

      return [];
    }
  }

  Future postData(Map<String, dynamic> data, String url) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          data,
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)["response"];
      } else {
        return "Server Error";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> postDataForLogin(
      Map<String, dynamic> data, String url) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: json.encode(data), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<List> getDataByPostApi(Map<String, dynamic> data, String url) async {
    try {
      var response = await http.post(
          Uri.parse(
            url,
          ),
          body: json.encode(
            data,
          ),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] == "" ||
            jsonDecode(response.body)["response"] == false) {
          return [];
        } else {
          return jsonDecode(response.body)["data"];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getCitiesByPostApi(String url, String stateId) async {
    try {
      var response = await http.post(
          Uri.parse(
            url,
          ),
          body: jsonEncode(
            {
              "state_id": stateId,
            },
          ),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getBrandsByPostApi(String url, int categoryId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"category": categoryId}),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future getUserInfoByPostApi(String url, int userId, String token) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "user_id": userId,
            "user_token": token,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<List> getNotifications(String url, int userId, String token) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({"user_id": userId, "user_token": token}),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getPosts(
      String url, int userId, String token, int categoryId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "category_id": categoryId
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getSingleTractorInfoById(
      String url, int userId, String token, int tractorId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode(
              {"user_id": userId, "user_token": token, "last_id": tractorId}),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getTractorsByPostApiData(
      String url,
      int userId,
      String token,
      String tractorType,
      int skip,
      int take,
      int pincode,
      String app_section) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "type": tractorType,
            "skip": skip,
            "take": take,
            "pincode": pincode,
            "app_section": app_section
          }),
          headers: {
            "Content-Type": "application/json",
          });

      print("Tractor response");
      // print(response.body);
      print(url);
      print(userId);
      print(token);
      print(tractorType);
      print(skip);
      print(take);
      print(pincode);
      print(app_section);
      print("response");
      print(jsonDecode(response.body)["data"]);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getTractorsByPostApi(
      String url, int userId, String token, int skip, int take) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "skip": skip,
            "take": take,
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getModelsByPostApi(
      String url, int categoryId, int brandId) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "category_id": categoryId,
            "brand_id": brandId,
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getData(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return await json.decode(response.body)["data"];
      } else {
        return await [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getStateData(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> postMasterBrandData(String url) async {
    try {
      var response = await http.post(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future deleteData(String id, String url) async {
    try {
      var response = await http.delete(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return "deleted";
      } else {
        return "Server Error";
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future updateData(String id, Map<String, String> data, String url) async {
    try {
      var response = await http.put(
        Uri.parse(url),
        body: json.encode(data),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return "updated";
      } else {
        return "Server Error";
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future<List> searchUserByName(String searchedUser, String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  ///Contact Us repository
  Future<List> getContactUsByPostApi(
      String url, Map<String, dynamic> product) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(product), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }

        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> insertProfileMultipartPostApi(
      String url, Map<String, dynamic> product) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(product), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }

        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getKrishiDataByPostApiData(String url, int userId, String token,
      int skip, int take, int pincode, String app_section) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "skip": skip,
            "take": take,
            "pincode": pincode,
            "app_section": app_section,
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getKrishiDataByPostApi(
      String url, int userId, String token, int skip, int take) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "skip": skip,
            "take": take
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  ///Sorting Api Repository
  Future<List> postCategorySortByPostApi({
    required String url,
    required int userId,
    required String token,
    required int state,
    required int district,
    required int skip,
    required int take,
    required String priceFilter,
    required String orderFilter,
  }) async {
    try {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "user_id": userId,
            "user_token": token,
            "state": state,
            "district": district,
            "skip": skip,
            "take": take,
            "price_filter": priceFilter,
            "order_filter": orderFilter,
          }),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getApplyFilter(
      String url, Map<String, dynamic> productTractor) async {
    try {
      var response = await http
          .post(Uri.parse(url), body: jsonEncode(productTractor), headers: {
        "Content-Type": "application/json",
      });
      print("xxxxxxxxxxx");
      print(response.statusCode);
      print("Scsssssss");
      print(jsonDecode(response.body)["data"][0]);
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          print("object from return");
          return jsonDecode(response.body)["data"];
        } else {
          print("else try block");
          return [];
        }
      } else {
        print("else try block 1");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future getLatestDeviceIdToken(
      String url, Map<String, dynamic> product) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: jsonEncode(product), headers: {
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["response"]) {
          return jsonDecode(response.body)["response"];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> getBanners(String url) async {
    try {
      var response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          return jsonDecode(response.body)["data"];
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future getSingleProductApi(String url,
      String categoryId, String productId) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "category_id": categoryId,
            "item_id": productId,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future getSingleTractorInfoByIdAll(
      String url, int userId, String token, int tractorId) async {
    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            "user_id": userId,
            "user_token": token,
            "last_id": tractorId,
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<List> getSubCategoryApi(
      String url, int userId, String token, String catId) async {
    try {
      var response = await http.post(
          Uri.parse(
            url,
          ),
          body: jsonEncode(
            {
              "user_id": userId,
              "user_token": token,
              "category": catId,
            },
          ),
          headers: {
            "Content-Type": "application/json",
          });
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["data"];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<List> sendSettingsPromotion(
      String url, Map<String, dynamic> productTractor) async {
    try {
      var response = await http
          .post(Uri.parse(url), body: jsonEncode(productTractor), headers: {
        "Content-Type": "application/json",
      });
      print("xxxxxxxxxxx");
      print(response.statusCode);
      print("Scsssssss");
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)["data"] is List) {
          print("object from return");
          return jsonDecode(response.body);
        } else {
          print("else try block");
          return [];
        }
      } else {
        print("else try block 1");
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Future<MaintenanceModel> getMaintenance() async {
      var url = baseUrl+maintenance;
      final response = await http.get(Uri.parse(url));

      if(response.statusCode==200){
        return MaintenanceModel.fromJson(json.decode(response.body));
      }else{
        throw Exception(response.statusCode);
      }
    }

    Future<ReferralModel> checkReferral(String PhoneNumber,String url) async{

      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode(
          {
            'mobile':PhoneNumber
          },
        ),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        return ReferralModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(response.statusCode);
      }

    }

  Future<Product> IFFCO_DataByPost(String url) async{

    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {},
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }

  }

  Future<IFFCO_Check_Model> getIFFCO_Check() async {
    var url = baseUrl+IFFCO_App_Check;
    final response = await http.get(Uri.parse(url));

    if(response.statusCode==200){
      return IFFCO_Check_Model.fromJson(json.decode(response.body));
    }else{
      throw Exception(response.statusCode);
    }
  }
  Future<EnableModel> UserEnable(String PhoneNumber,String url) async{

    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'number':PhoneNumber
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return EnableModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }

  }

  Future<EnableModel> UserDisable(String url) async{

    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'user_id':'${SharedPreferencesFunctions.userId}',
          'user_token':'${SharedPreferencesFunctions.token}'
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return EnableModel.fromJson(json.decode(response.body));
    } else {
      throw Exception(response.statusCode);
    }

  }
  Future<dynamic> Lead_View(String post_user_id,String category_id,String post_id) async{

    await http.post(
      Uri.parse(baseUrl+lead_view),
      body: jsonEncode(
        {
          'user_id':'${SharedPreferencesFunctions.userId}',
          'post_user_id':post_user_id,
          'category_id':category_id,
          'post_id':post_id,
          'user_token':'${SharedPreferencesFunctions.token}'
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }
  Future<List> PostSearchResult(int category_id,int id, String Keyword) async {
    var response = await http.post(
      Uri.parse(baseUrl + 'search-result'),
      body: jsonEncode(
        {
          'category_id': category_id,
          'id': id,
          'keyword': Keyword
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<dynamic> Lead_Generate(String post_user_id,String category_id,String post_id,
      String call_status,String messages_status,String sms) async{

    await http.post(
      Uri.parse(baseUrl+lead_generate),
      body: jsonEncode(
        {
          'user_id':'${SharedPreferencesFunctions.userId}',
          'post_user_id':post_user_id,
          'category_id':category_id,
          'post_id':post_id,
          'calls_status':call_status,
          'messages_status':messages_status,
          'sms':sms,
          'user_token':'${SharedPreferencesFunctions.token}'
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }

  Future<dynamic> MarkItemSold(int category_id, int item_id ) async{
    await http.post(
      Uri.parse(baseUrl+'mark-as-sold'),
      body: jsonEncode(
        {
          'category_id':category_id,
          'item_id':item_id
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }

  Future<dynamic> ItemDisable(int category_id, int item_id ) async{
    await http.post(
      Uri.parse(baseUrl+'post-disabled'),
      body: jsonEncode(
        {
          'category_id':category_id,
          'item_id':item_id
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );
  }
}
