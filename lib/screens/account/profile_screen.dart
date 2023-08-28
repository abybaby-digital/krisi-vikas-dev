import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/Screens/account/edit_profile_screen.dart';
import 'package:krishivikas/Screens/helpCenter/help_center_screen.dart';
import 'package:krishivikas/Screens/home/home_screen.dart';
import 'package:krishivikas/Screens/settings/settings_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/controllers/profile_controller.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'count_product_category.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());

  bool isLoading = false;

  get tabController => null;

  String? name;

  String? email;

  String? phoneNumber;

  String? cityName;

  String? stateName;

  int? userTypeId;

  String? companyName;

  String? gstNo;

  int? countryId;

  int? stateId;

  int? districtId;

  int? cityId;

  String? address;

  int? zipCode;

  String? dob;

  String? latLong;

  String? photo;

  File? image;

  String? mobile;

  bool isImageSelected = false;

  final ImagePicker picker = new ImagePicker();

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        gotoWithoutBack(
          context,
          HomeScreen(),
        );
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(profile.tr),
          backgroundColor: darkgreen,
        ),
        body: (!isLoading)
            ? Center(
                child: progressIndicator(context),
              )
            : ListView(
                children: [
                  Container(
                    height: 270,
                    width: double.infinity,
                    color: green400,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: grey200,
                              child: photo != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: photo!,
                                        fit: BoxFit.cover,
                                        width: fullWidth(context),
                                        height: fullHeight(context),
                                        placeholder: (context, url) {
                                          return Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: white,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, dynamic) {
                                          return Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: white,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 60,
                                      color: white,
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                takeImage();
                              },
                              child: CircleAvatar(
                                backgroundColor: teal,
                                radius: 22,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        barlowBold(
                          text: name!.isNotEmpty || name != null
                              ? name.toString()
                              : "Guest",
                          color: black,
                          size: 25,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.mobile_friendly,
                                color: white,
                                size: 19,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: barlowRegular(
                                  text: phoneNumber!.isEmpty ||
                                          phoneNumber == "null"
                                      ? ""
                                      : phoneNumber!,
                                  color: white,
                                  size: 15,
                                ),
                              ),
                              Spacer(),
                              Image.asset(
                                AppImages.emailIcon,
                                width: 20,
                                height: 20,
                                color: white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: barlowRegular(
                                  text: email!.isEmpty || email == "null"
                                      ? " "
                                      : email!,
                                  color: white,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: 6,
                    child: Column(
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: grey,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: TabBar(
                            labelPadding: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            labelColor: blueGrey,
                            indicatorColor: blueGrey,
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorPadding: EdgeInsets.zero,
                            indicatorWeight: 2,
                            padding: EdgeInsets.zero,
                            tabs: [
                              Tab(
                                child: barlowSemiBold(
                                  text: myPosts.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                              Tab(
                                child: barlowSemiBold(
                                  text: myLeads.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                              Tab(
                                child: barlowSemiBold(
                                  text: myEnquiry.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                              Tab(
                                child: barlowSemiBold(
                                  text: profile.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                              Tab(
                                child: barlowSemiBold(
                                  text: setting.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                              Tab(
                                child: barlowSemiBold(
                                  text: helpCenter.tr,
                                  color: grey,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: fullHeight(context) / 1.9,
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              CountProductCategory(
                                "mypost",
                                baseUrl + myPostUrl,
                              ),
                              CountProductCategory(
                                "mylead",
                                baseUrl + myLeadUrl,
                              ),
                              CountProductCategory(
                                "enquiry",
                                baseUrl + myEnquiryUrl,
                              ),
                              EditProfileScreen(
                                userTypeId!,
                              ),
                              SettingsScreen(),
                              HelpCenterScreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserEmail();
    await SharedPreferencesFunctions().getUserName();
    await SharedPreferencesFunctions().getUserProfileImage();
  }

  getUserInfo() async {
    Map<String, dynamic> userInfo = await ApiMethods().getUserInfoByPostApi(
      baseUrl + profileUrl,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
    );

    name = userInfo['name'] ?? "Guest";

    email = userInfo['email'] ?? "";

    phoneNumber = userInfo["mobile"] ?? "";

    userTypeId = userInfo["user_type_id"] ?? 1;

    companyName = userInfo["company_name"] ?? "";

    gstNo = userInfo["gst_no"] ?? "";

    countryId = userInfo["country_id"] ?? 1;

    stateId = userInfo["state_id"] ?? "";

    districtId = userInfo["district_id"] ?? 1;

    cityId = userInfo["city_id"] ?? "";

    address = userInfo['address'] ?? "";

    zipCode = userInfo['zipcode'] ?? "";

    dob = userInfo['dob'] ?? "";

    photo = userInfo['photo'];

    latLong = userInfo['latlong'] ?? "";

    isLoading = true;
    if (mounted) {
      setState(() {});
    }
  }

  Future getImageFromGallery() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      String fileName = image!.path.split('/').last;
      // ignore: unused_local_variable
      final formData = FormData(
        {
          'photo': MultipartFile(
            image,
            filename: fileName,
          ),
        },
      );
      profileController
          .uploadImage(
            image!,
            userTypeId,
            companyName,
            gstNo,
            name,
            email,
            countryId,
            stateId,
            districtId,
            cityId,
            address,
            zipCode,
            dob,
            latLong,
            phoneNumber,
          )
          .then(
            (value) => getUserInfo(),
          );
      setState(
        () {
          this.image = image;
        },
      );
    }
  }

  Future captureImageFromCamera() async {
    Navigator.of(context).pop();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);
      profileController
          .uploadImage(
              image!,
              userTypeId,
              companyName,
              gstNo,
              name,
              email,
              countryId,
              stateId,
              districtId,
              cityId,
              address,
              zipCode,
              dob,
              latLong,
              phoneNumber)
          .then(
            (value) => getUserInfo(),
          );
      setState(
        () {
          this.image = image;
        },
      );
    }
  }

  takeImage() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: barlowBold(
            text: selectOption.tr,
            color: black,
            size: 20,
          ),
          children: [
            SimpleDialogOption(
              child: barlowRegular(
                text: imageFromGallery.tr,
                color: black,
                size: 17,
              ),
              onPressed: () async {
                getImageFromGallery();
              },
            ),
            SimpleDialogOption(
              child: barlowRegular(
                text: imageFromCamera.tr,
                color: black,
                size: 17,
              ),
              onPressed: () async {
                captureImageFromCamera();
              },
            ),
            SimpleDialogOption(
              child: barlowRegular(
                text: cancel.tr,
                color: black,
                size: 17,
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
