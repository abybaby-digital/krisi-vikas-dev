import 'package:get/get.dart';
import 'package:krishivikas/services/api_methods.dart';
import '../const/api_urls.dart';
import '../services/save_user_info.dart';

class UpdateTokenController extends GetxController {
  RxBool dToken = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  ///FCM Token Update
  getTokenUpdate(String updatedDeviceId, String updateToken) async {
    await SharedPreferencesFunctions().getUserId();
    try {
      Map<String, dynamic> data = {
        "id": SharedPreferencesFunctions.userId,
        "updated_device_id": updatedDeviceId,
        "updated_token": updateToken,
      };
      var response = await ApiMethods()
          .getLatestDeviceIdToken(baseUrl + updateTokenUrl, data);

      if (response != false) {
        dToken.value = response;
        update();
      }
    } catch (e) {
      return e;
    }
  }
}
