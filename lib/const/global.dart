import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/models/filter_validation.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/utils/dynamicLink.dart';

bool IsRegistered = false;
List<dynamic> allcategory = [];
List<String> appBannerVideo = [];

int? currentLocation = SharedPreferencesFunctions.zipcode;

getUserCurrentLocation() async {
  await SharedPreferencesFunctions().getUserZipcode();
  Position position = await ApiMethods().getGeoLocationPosition();
  double lat = position.latitude;
  double long = position.longitude;
  List<Placemark> placemarks = await placemarkFromCoordinates(
    lat,
    long,
  );
  currentLocation = int.parse(
    placemarks[0].postalCode ?? SharedPreferencesFunctions.zipcode.toString(),
  );
  SharedPreferencesFunctions().saveUserCurrentZipcode(currentLocation!);
}

String tractorTabType = "";
String tractorType = "";

String gvTabType = "";
String gvType = "";

String implementTabType = "";
String implementType = "";

String harvesterTabType = "";
String harvesterType = "";

String tyresTabType = "";
String tyresType = "";

/* Dynamic link */
DynamicLinkService dynamicLinkService = DynamicLinkService();

/* Dynamic link */

int? CurrentUserType = 0;

String? CategoryIdWhilePosting = "0";

List<FilterValidation> arrayDistrictList = [];

bool IsPressedFilterButton = false;

getBannerAndVideoListUpdate() async {
  appBannerVideo = [];
  var result = await ApiMethods().getBanners(
    baseUrl + bannersVideosUrl,
  );

  var sliderType;

  if (SharedPreferencesFunctions().getLanguage() == "English") {
    sliderType = "slider_en";
  } else if (SharedPreferencesFunctions().getLanguage() == "Hindi") {
    sliderType = "slider_hn";
  } else {
    sliderType = "slider_bn";
  }
  result.forEach((element) {
    if (element['name'].toString().contains(sliderType)) {
      appBannerVideo.add(
        element['value'],
      );
    }
  });
  print("SharedPreferencesFunctions().getLanguage()");
  print(SharedPreferencesFunctions().getLanguage());
  print("appBannerVideo.length");
  print(appBannerVideo.length);
  appBannerVideo.forEach((element) { 
    print("appBannerVideo");
    print(element);
  });
  // setState(() {});
  // isDataObtained = true;
}
