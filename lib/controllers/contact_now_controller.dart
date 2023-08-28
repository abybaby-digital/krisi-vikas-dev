import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';

class ContactNowController extends GetxController {
  RxBool isLoading = true.obs;
  RxList contactList = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  ///Contact Now Api Calling
  getContactInformation({
    required String postUserId,
    required String categoryId,
    required int postId,
    required String callStatus,
    required String messageStatus,
  }) async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "post_user_id": postUserId,
      "category_id": categoryId,
      "post_id": postId,
      "calls_status": callStatus,
      "messages_status": messageStatus,
      "sms": "",
      "user_token": SharedPreferencesFunctions.token,
    };
    isLoading.value = false;

    var result = await ApiMethods().getContactUsByPostApi(
      baseUrl + leadGeneratedUrl,
      data,
    );

    // ignore: unnecessary_null_comparison
    if (result.isNotEmpty && result != null) {
      result.forEach(
        (element) {
          contactList.add(element);
        },
      );
    }

    isLoading.value = false;
  }
}
