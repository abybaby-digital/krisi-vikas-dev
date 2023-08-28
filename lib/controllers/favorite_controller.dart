import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = true.obs;
  RxList favAds = [].obs;
  int? myId;
  String? myToken;

  getFavoriteProducts() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    try {
      Map<String, dynamic> data = {
        "user_id": SharedPreferencesFunctions.userId,
        "user_token": SharedPreferencesFunctions.token
      };
      var products = await ApiMethods().getProductsByPostApi(
        baseUrl + wishListUrl,
        data,
      );
      print("Favourites data ==");
      print(products);
      // ignore: unnecessary_null_comparison
      if (products != null) {
        favAds.value = products;
        update();
      }
    } finally {
      isLoading.value = false;
    }
  }

  addFavoriteProduct(String categoryId, int itemId) async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "category_id": categoryId,
      "item_id": itemId
    };
    isLoading.value = false;
    var result = await ApiMethods().getProductsByPostApi(
      baseUrl + wishListAddUrl,
      data,
    );
    result.forEach(
      (element) {
        favAds.add(element);
      },
    );
    isLoading.value = false;
  }

  deleteFavoriteProduct(String categoryId, int deleteId) async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "category_id": categoryId,
      "item_id": deleteId
    };
    isLoading.value = false;
    // ignore: unused_local_variable
    var result = await ApiMethods().deleteProductsByPostApi(
      baseUrl + wishListDeleteUrl,
      data,
    );

    favAds.removeWhere((item) => item["del_id"] == deleteId);
    isLoading.value = false;
  }

  @override
  void onInit() {
    getFavoriteProducts();

    super.onInit();
  }
}
