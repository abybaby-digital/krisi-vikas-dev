import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../language/language_screen.dart';
import '../disableScreen/disableScreen.dart';

class CheckZipcodeScreen extends StatefulWidget {
  final int loginMethod;

  CheckZipcodeScreen(
    this.loginMethod,
  );

  @override
  State<CheckZipcodeScreen> createState() => _CheckZipcodeScreenState();
}

class _CheckZipcodeScreenState extends State<CheckZipcodeScreen> {
  TextEditingController zipcodeController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController districtController = TextEditingController();

  TextEditingController referralController = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  var addressInfo;

  bool isZipChanged = false;

  bool showCPI = false;

  setLocation() async{
    await FirebaseFirestore.instance.collection('location').doc(FirebaseAuth.instance.currentUser?.uid).set(
        {
          "location":"false"
        });
  }

  int? userExist;
  String? flag;

  checkReferral() async {
    await ApiMethods().checkReferral(UserData.phoneNumber.toString(), baseUrl+referral_check).then((value) {
      print("Data : ${value.data}");
      setState(() {
        userExist = value.data;
        flag = value.flag;
        if(flag=='disabled'){
          gotoWithoutBack(context, DisableScreen());
        }
      });
    });
  }

  @override
  void initState() {
    setLocation();
    checkReferral();
    super.initState();
    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: address.tr,
          color: white,
          size: 20,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: addressFormKey,
            child: Column(
              children: [
                VSpace(50),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 8,
                    right: 15,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: zipcodeController,
                    validator: MultiValidator(
                      [
                        RequiredValidator(
                          errorText: enterZipcode.tr,
                        ),
                        MinLengthValidator(
                          6,
                          errorText: sixDigitPinCode.tr,
                        ),
                        MaxLengthValidator(
                          6,
                          errorText: sixDigitPinCode.tr,
                        )
                      ],
                    ),
                    maxLength: 6,
                    onChanged: (value) async {
                      isZipChanged = true;
                      if (value.length == 6) {
                        addressInfo = await ApiMethods().getDataByPostApi(
                          {
                            "pincode": SharedPreferencesFunctions.zipcode != 0
                                ? SharedPreferencesFunctions.zipcode
                                : value
                          },
                          baseUrl + zipCodeUrl,
                        );
                        setState(() {
                          SharedPreferencesFunctions.zipcode = int.parse(value);
                        });
                        print("value");
                        print(value);
                        print("Address");
                        print(addressInfo);

                        if (addressInfo.isNotEmpty) {
                          SharedPreferencesFunctions()
                              .saveUserZipcode(int.parse(value));
                          stateController.text = addressInfo[0]["state_name"];
                          cityController.text = addressInfo[0]["city_name"];
                          districtController.text =
                              addressInfo[0]["district_name"];

                          setState(() {
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      label: barlowRegular(
                        text: enterZipcode.tr,
                        size: 15,
                        color: grey,
                      ),
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: enterZipcode.tr,
                      enabledBorder: customOutlineBorder(),
                      focusedBorder: customOutlineBorder(),
                      errorBorder: customOutlineBorder(),
                      focusedErrorBorder: customOutlineBorder(),
                      counterText: "",
                    ),
                  ),
                ),
                VSpace(20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 8,
                    right: 15,
                  ),
                  child: TextField(
                    controller: stateController,
                    enabled: false,
                    decoration: InputDecoration(
                      label: barlowRegular(
                        text: stateName.tr,
                        size: 15,
                        color: grey,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 15,
                      ),
                      border: customOutlineBorder(),
                    ),
                  ),
                ),
                VSpace(20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 8,
                    right: 15,
                  ),
                  child: TextField(
                    controller: cityController,
                    enabled: false,
                    decoration: InputDecoration(
                      label: barlowRegular(
                        text: cityTownArea.tr,
                        size: 15,
                        color: grey,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 15,
                      ),
                      border: customOutlineBorder(),
                    ),
                  ),
                ),
                VSpace(20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    top: 8,
                    right: 15,
                  ),
                  child: TextField(
                    controller: districtController,
                    enabled: false,
                    decoration: InputDecoration(
                      label: barlowRegular(
                        text: districtName.tr,
                        size: 15,
                        color: grey,
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 15,
                      ),
                      border: customOutlineBorder(),
                    ),
                  ),
                ),
                VSpace(20),
                userExist == 1?
                    Container():
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 8,
                        right: 15,
                      ),
                      child: TextField(
                        controller: referralController,
                        decoration: InputDecoration(
                          label: barlowRegular(
                            text: referralCode.tr,
                            size: 15,
                            color: grey,
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 15,
                          ),
                          border: customOutlineBorder(),
                        ),
                      ),
                    ),
                VSpace(30),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 45,
                    color: darkgreen,
                    onPressed: () async {
                      FirebaseFirestore.instance.collection('location').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        "location":"true"
                      });
                      if (addressFormKey.currentState!.validate()) {
                        if (mounted) {
                          setState(
                            () {
                              showCPI = true;
                            },
                          );
                        }

                        if (isZipChanged) {
                          addressInfo = await ApiMethods().getDataByPostApi(
                            {"pincode": zipcodeController.text},
                            baseUrl + zipCodeUrl,
                          );
                        }

                        if (addressInfo.isNotEmpty) {
                          Map<String, dynamic> userData = {
                            "mobile": UserData.phoneNumber,
                            "email": UserData.email,
                            "facebook_id": widget.loginMethod == 1
                                ? ""
                                : widget.loginMethod,
                            "google_id": widget.loginMethod == 1
                                ? ""
                                : widget.loginMethod,
                            "device_id": " ",
                            "firebase_token":
                                SharedPreferencesFunctions.deviceToken,
                            "phone_verified": widget.loginMethod == 1
                                ? widget.loginMethod
                                : "",
                            "country_id": addressInfo[0]["country_id"] ?? 1,
                            "state_id": addressInfo[0]["state_id"] ?? 37,
                            "district_id": addressInfo[0]["district_id"] ?? 730,
                            "city_id": addressInfo[0]["city_id"] ?? 16122,
                            "lat": addressInfo[0]["latitude"],
                            "long": addressInfo[0]["longitude"],
                            "zipcode": int.parse(zipcodeController.text.trim()),
                            "referral_code":referralController.text.trim(),
                          };
                          Map<String, dynamic> res =
                              await ApiMethods().postDataForLogin(
                            userData,
                            baseUrl + loginUrl,
                          );

                          if (res["response"]) {
                            SharedPreferencesFunctions().saveUserId(
                              res["data"]["user_id"],
                            );
                            SharedPreferencesFunctions().saveToken(
                              res["data"]["token"],
                            );
                            SharedPreferencesFunctions().saveIsRegistered(
                              res["data"]["profile_update"],
                            );

                            // SharedPreferencesFunctions()
                            //   .saveUserZipcode(int.parse(res["data"]["zipcode"]));

                            gotoWithoutBack(
                              context,
                              LanguageScreen(),
                            );
                            showSnackbar(
                              context,
                              welcomeTitle.tr,
                            );
                          } else {
                            if (mounted) {
                              setState(
                                () {
                                  showCPI = false;
                                },
                              );
                            }

                            showSnackbar(
                              context,
                              errorMessage.tr,
                            );
                          }
                        } else {
                          if (mounted) {
                            setState(
                              () {
                                showCPI = false;
                              },
                            );
                          }

                          showSnackbar(
                            context,
                            notValidZipCode.tr,
                          );
                        }
                      }
                    },
                    child: showCPI
                        ? Center(
                            child: CircularProgressIndicator(
                              color: white,
                            ),
                          )
                        : barlowBold(
                            text: continues.tr,
                            color: white,
                            size: 17,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getUserEmail();
    await SharedPreferencesFunctions().getUserZipcode();
    await SharedPreferencesFunctions().getDeviceToken();
    addressInfo = await ApiMethods().getDataByPostApi(
      {"pincode": SharedPreferencesFunctions.zipcode},
      baseUrl + zipCodeUrl,
    );
    if (addressInfo.isNotEmpty) {
      zipcodeController.text = SharedPreferencesFunctions.zipcode.toString();
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
      districtController.text = addressInfo[0]["district_name"];

      SharedPreferencesFunctions().saveStateId(
        addressInfo[0]["state_id"],
      );
      SharedPreferencesFunctions().saveDistrictId(
        addressInfo[0]["district_id"],
      );
    }

    setState(() {});
  }
}
