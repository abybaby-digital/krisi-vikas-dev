import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../../controllers/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  final int userTypeId;

  EditProfileScreen(
    this.userTypeId,
  );

  @override
  State<EditProfileScreen> createState() => _EnterUserDetailsState();
}

class _EnterUserDetailsState extends State<EditProfileScreen> {
  String dobDate = "";
  String dateReplace = "";
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  TextEditingController zipController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  TextEditingController gstNumberController = TextEditingController();

  DateTime pickedDate = DateTime.now();

  bool showCPI = false;

  var addressInfo;
  Map<String, dynamic> userInfo = {};

  ProfileController profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    editMyProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextField(
                controller: nameController,
                cursorColor: grey,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: name.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextFormField(
                enabled: false,
                cursorColor: grey,
                controller: phoneNumberController,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: phoneNumber.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextFormField(
                controller: emailController,
                cursorColor: grey,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: email.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            widget.userTypeId == 2 ? VSpace(10) : SizedBox(),
            widget.userTypeId == 2
                ? CustomTextfield(
                    companyNameController,
                    enterCompanyName.tr,
                    companyName.tr,
                    fillCompany.tr,
                    TextInputType.text,
                  )
                : SizedBox(),
            widget.userTypeId == 2 ? VSpace(10) : SizedBox(),
            widget.userTypeId == 2
                ? CustomTextfield(
                    gstNumberController,
                    enterGstNo.tr,
                    gstNumber.tr,
                    fillGst.tr,
                    TextInputType.text,
                  )
                : SizedBox(),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextField(
                controller: stateController,
                cursorColor: grey,
                enabled: false,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: stateName.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextField(
                controller: cityController,
                cursorColor: grey,
                enabled: false,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: cityTownArea.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextField(
                controller: addressController,
                cursorColor: grey,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: address.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextField(
                cursorColor: grey,
                controller: zipController,
                enabled: false,
                decoration: InputDecoration(
                  label: barlowRegular(
                    text: zipCode.tr,
                    size: 15,
                    color: grey,
                  ),
                  focusedBorder: customOutlineBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 20,
              ),
              child: barlowBold(
                text: selectDob.tr,
                size: 16,
                color: black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                  border: Border.all(
                    color: greyShade400,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    barlowMedium(
                      text: dobDate.isNotEmpty
                          ? dobDate.toString()
                          : "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
                      size: 17,
                      color: black,
                    ),
                    IconButton(
                      onPressed: () {
                        showDate();
                      },
                      icon: Icon(
                        Icons.date_range,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VSpace(20),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          showSubmitPopup(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Container(
            height: fullHeight(context) * 0.07,
            color: darkgreen,
            child: Center(
              child: barlowSemiBold(
                text: submitValue.tr,
                size: 25,
                color: white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSubmitPopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                barlowRegular(
                  text: areYouWantToSubmit.tr,
                  color: black,
                  size: 15,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await profileController.insertUserData(
                            userTypeId: widget.userTypeId,
                            companyName: companyNameController.text.trim(),
                            gstNo: gstNumberController.text.trim(),
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            countryId: userInfo['country_id'],
                            stateId: userInfo['state_id'],
                            districtId: userInfo['district_id'],
                            cityId: userInfo['city_id'],
                            address: addressController.text.trim(),
                            zipCode: int.parse(
                              zipController.text.trim(),
                            ),
                            dob: pickedDate.toString(),
                            latLong: userInfo['latlong'],
                            mobile: userInfo['mobile'],
                            profilePhoto: userInfo['photo'],
                          );
                          Navigator.of(context).pop();
                          setState(() {
                            progressIndicator(context);
                          });
                        },
                        child: barlowBold(
                          text: yes.tr,
                          color: white,
                          size: 15,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: darkgreen,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: barlowBold(
                          text: no.tr,
                          color: black,
                          size: 15,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  editMyProfile() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    userInfo = await ApiMethods().getUserInfoByPostApi(
      baseUrl + profileUrl,
      SharedPreferencesFunctions.userId!,
      SharedPreferencesFunctions.token!,
    );

    nameController.text = userInfo["name"] ?? "";
    phoneNumberController.text = userInfo["mobile"] ?? "";
    emailController.text = userInfo["email"] ?? "";
    zipController.text = userInfo["zipcode"].toString();
    addressController.text = userInfo["address"] ?? "";
    stateController.text = userInfo["state_name"]["state_name"];
    cityController.text = userInfo["city_name"]["city_name"];

    String dateTimeReplace = userInfo['dob'] ?? "";
    if (dateTimeReplace.isNotEmpty) {
      dobDate = dateTimeReplace.substring(0, 10);
    }
    if (mounted) setState(() {});
  }

  Future<void> showDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      builder: (
        BuildContext context,
        Widget? child,
      ) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: black,
            textTheme: TextTheme(
              subtitle1: TextStyle(
                color: black,
              ),
              button: TextStyle(
                color: black,
              ),
            ),
            hintColor: black,
            colorScheme: ColorScheme.light(
              primary: darkgreen,
              primaryVariant: black,
              secondaryVariant: black,
              onSecondary: black,
              onPrimary: white,
              surface: black,
              onSurface: black,
              secondary: black,
            ),
            dialogBackgroundColor: white,
          ),
          child: child ?? Text(""),
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (picked != null && picked != pickedDate)
      setState(
        () {
          pickedDate = picked;

          dobDate = picked.day.toString() +
              "-" +
              picked.month.toString() +
              "-" +
              picked.year.toString();
        },
      );
  }
}
