import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  RxList profileData = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  ///Insert Profile Data Api
  insertUserData({
    required int? userTypeId,
    required String? companyName,
    required String? gstNo,
    required String? name,
    required String? email,
    required int? countryId,
    required int? stateId,
    required int? districtId,
    required int? cityId,
    required String? address,
    required int? zipCode,
    required String? dob,
    required String? latLong,
    required String? mobile,
    required String? profilePhoto,    
  }) async {
    await SharedPreferencesFunctions().getUserId();
    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_type_id": userTypeId,
      "company_name": companyName,
      "gst_no": gstNo,
      "name": name,
      "email": email,
      "country_id": countryId,
      "state_id": stateId,
      "district_id": districtId,
      "city_id": cityId,
      "address": address,
      "zipcode": zipCode,
      "dob": dob,
      "latlong": latLong,
      "mobile": mobile,
      "photo": profilePhoto,      
    };

    var result = await ApiMethods().insertProfileMultipartPostApi(
      baseUrl + registrationUrl,
      data,
    );

    result.forEach(
      (element) {
        profileData.add(element);
      },
    );
    
    isLoading.value = false;
  }

  Uri imageUri = Uri.parse(
    baseUrl + registrationUrl,
  );

  ///MultiPart Image
  Future<Map<String, dynamic>?> uploadImage(
    File image,
    int? userTypeId,
    String? companyName,
    String? gstNo,
    String? name,
    String? email,
    int? countryId,
    int? stateId,
    int? districtId,
    int? cityId,
    String? address,
    int? zipCode,
    String? dob,
    String? latLong,
    String? mobile,
  ) async {
    final imageRequest = await http.MultipartRequest("POST", imageUri);

    final file = await http.MultipartFile.fromPath("photo", image.path);

    imageRequest.files.add(file);
    imageRequest.fields['user_id'] =
        SharedPreferencesFunctions.userId.toString();

    imageRequest.fields['user_type_id'] = userTypeId.toString();

    imageRequest.fields['company_name'] = companyName.toString();

    imageRequest.fields['gst_no'] = gstNo.toString();

    imageRequest.fields['name'] = name.toString();

    imageRequest.fields['email'] = email.toString();

    imageRequest.fields['country_id'] = countryId.toString();

    imageRequest.fields['state_id'] = stateId.toString();

    imageRequest.fields['district_id'] = districtId.toString();

    imageRequest.fields['city_id'] = cityId.toString();

    imageRequest.fields['address'] = address.toString();

    imageRequest.fields['zipcode'] = zipCode.toString();

    imageRequest.fields['dob'] = dob.toString();

    imageRequest.fields['latlong'] = latLong.toString();

    imageRequest.fields['mobile'] = mobile.toString();
    
    try {
      final streamResponse = await imageRequest.send();
      final response = await http.Response.fromStream(streamResponse);
      if (response.statusCode != 200) {
        return null;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } catch (e) {
      return Future.error(
        e.toString(),
      );
    }
  }
}
