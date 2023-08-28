import 'package:krishivikas/main.dart';

class SharedPreferencesFunctions {
  static String? name;
  static String? phoneNumber;
  static String? email;
  static String? state;
  static String? district;
  static int? userId;
  static String? token;
  static int? isRegistered;
  static int? zipcode;
  static int? userCurrentzipcode;
  static String? stateName;
  static String? cityName;
  static String? districtName;
  static int? countryId;
  static int? stateId;
  static int? cityId;
  static int? districtId;
  static double? latitude;
  static double? longitude;
  static String? deviceToken;
  static String? userProfileImage;
  static bool? readMessage;
  static String? registerUserId;

  saveDeviceToken(
      String deviceToken,
      ) {
    preferences.setString("DEVICETOKEN", deviceToken);
  }

  getDeviceToken() async {
    deviceToken = await preferences.getString("DEVICETOKEN");
    print("deviceToken");
    print(deviceToken);
  }

  saveUserId(int userId) {
    preferences.setInt("USERID", userId);
  }

  getUserId() async {
    userId = await preferences.getInt("USERID");

    print("User_id" + " " + userId.toString());
  }

  Future<int?> getUserId1() async {
    return await preferences.getInt("USERID");
  }

  saveToken(String token) {
    preferences.setString("TOKEN", token);
  }

  getToken() async {
    token = await preferences.getString("TOKEN");
    print("user_token" + " " + token!);
  }

  Future<String?> getToken1() async {
    token = await preferences.getString("TOKEN");
    return null;
  }

  saveIsRegistered(int isRegistered) {
    preferences.setInt("REGISTERED", isRegistered);
  }

  getIsRegistered() async {
    isRegistered = await preferences.getInt("REGISTERED");
  }

  saveUserPhoneNumber(String userPhoneNumber) {
    preferences.setString("PHONENUMBER", userPhoneNumber);
  }

  getUserPhoneNumber() async {
    phoneNumber = await preferences.getString("PHONENUMBER");
    print("phoneNumber");
    print(phoneNumber);
  }

  ///Save User Email
  saveUserEmail(String userEmail) {
    preferences.setString("EMAIL", userEmail);
  }

  ///Get User Email
  getUserEmail() async {
    email = await preferences.getString("EMAIL");
  }

  saveUserZipcode(int zipcode) {
    preferences.setInt("ZIPCODE", zipcode);
  }

  getUserZipcode() async {
    zipcode = await preferences.getInt("ZIPCODE");
  }

  saveUserCurrentZipcode(int userCurrentzipcode) {
    preferences.setInt("CurrentZIP", userCurrentzipcode);
  }

  getUserCurrentZipcode() async {
    userCurrentzipcode = await preferences.getInt("CurrentZIP");
  }

  saveCountryId(int countryId) {
    preferences.setInt("COUNTRYID", countryId);
  }

  getCountryId() async {
    countryId = await preferences.getInt("COUNTRYID");
  }

  saveStateId(int stateId) {
    preferences.setInt("STATEID", stateId);
  }

  int? getStateId() {
    return preferences.getInt("STATEID");
  }

  saveCityId(int cityId) {
    preferences.setInt("CITYID", cityId);
  }

  getCityId() async {
    cityId = await preferences.getInt("CITYID");
  }

  saveDistrictId(int districtId) {
    preferences.setInt("DISTRICTID", districtId);
  }

  int? getDistrictId() {
    return preferences.getInt("DISTRICTID");
  }

  saveLatitude(double latitude) {
    print("My Latitude sp $latitude");

    preferences.setDouble("LATITUDE", latitude);
  }

  getLatitude() async {
    latitude = await preferences.getDouble("LATITUDE");
  }

  saveLongitude(double longitude) {
    print("My Longitude SP $longitude");
    preferences.setDouble("LONGITUDE", longitude);
  }

  getLongitude() async {
    longitude = await preferences.getDouble("LONGITUDE");
  }

  saveStateName(String stateName) {
    preferences.setString("STATE", stateName);
  }

  getStateName() async {
    stateName = await preferences.getString("STATE");
  }

  saveCityName(String cityName) {
    preferences.setString("CITY", cityName);
  }

  getCityName() async {
    cityName = await preferences.getString("CITY");
  }

  saveDistrictName(String districtName) {
    preferences.setString("DISTRICT", districtName);
  }

  getDistrictName() async {
    districtName = await preferences.getString("DISTRICT");
  }

  ///Save User Name
  saveUserName(String userName) {
    preferences.setString("NAME", userName);
  }

  ///Get User Name
  getUserName() async {
    name = await preferences.getString("NAME");
  }

  ///Save Profile Image
  saveUserProfileImage(String userProfilePic) {
    preferences.setString("IMAGE", userProfilePic);
  }

  ///Get Profile Image
  getUserProfileImage() async {
    userProfileImage = await preferences.getString("IMAGE");
  }

  saveReadMessage(bool readMessage) {
    preferences.setBool("CHATMESSAGE", readMessage);
  }

  bool? getReadMessage() {
    return preferences.getBool("CHATMESSAGE");
  }

  saveFilterStateId(int stateId) {
    preferences.setInt("FILTERSTATEID", stateId);
  }

  int? getFilterStateId() {
    return preferences.getInt("FILTERSTATEID");
  }

  saveFilterDistrictId(int districtId) {
    preferences.setInt("DISTRICTID", districtId);
  }

  int? getFilterDistrictId() {
    return preferences.getInt("DISTRICTID");
  }

  saveLanguage(String languageName) {
    preferences.setString("LANGUAGE", languageName);
  }

  String? getLanguage() {
    return preferences.getString("LANGUAGE");
  }

  saveOtherNumber(String otherNumber) {
    preferences.setString("OTHERNUMBER", otherNumber);
  }

  String? getOtherNumber() {
    return preferences.getString("OTHERNUMBER");
  }

  saveOtherToken(String otherNumber) {
    preferences.setString("OTHERTOKEN", otherNumber);
  }

  String? getOtherToken() {
    return preferences.getString("OTHERTOKEN");
  }

  saveCategoryId(String categoryId) {
    preferences.setString("CATEGORYID", categoryId);
  }

  String? getCategoryId() {
    return preferences.getString("CATEGORYID");
  }

  saveFilterBrandId(String filterBrandId) {
    preferences.setString("FILTERBRANDID", filterBrandId);
  }

  String? geteFilterBrandId() {
    return preferences.getString("FILTERBRANDID");
  }

  ///Save Facebook UserId
  saveFacebookUserId(int fbUserId) {
    preferences.setInt("FB_ID", fbUserId);
  }

  ///Get Facebook UserId
  getFacebookUserId() async {
    await preferences.getInt("FB_ID");
  }

  ///Save Gmail UserId
  saveGmailUserId(int gmUserId) {
    preferences.setInt("GM_ID", gmUserId);
  }

  ///Get Gmail UserId
  getGmailUserId() async {
    await preferences.getInt("GM_ID");
  }
}
