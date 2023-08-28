import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/category/product_selection_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../language/language_key.dart';
import 'notification/notifications_screen.dart';

class EnterUserDetails extends StatefulWidget {
  final int userTypeId;
  final String? where;
  EnterUserDetails(this.userTypeId, this.where);

  @override
  State<EnterUserDetails> createState() => _EnterUserDetailsState();
}

class _EnterUserDetailsState extends State<EnterUserDetails> {
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var addressInfo;

  getUserInfo() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserEmail();
    await SharedPreferencesFunctions().getUserPhoneNumber();
    await SharedPreferencesFunctions().getUserZipcode();

    phoneNumberController.text = SharedPreferencesFunctions.phoneNumber ?? "";
    emailController.text = SharedPreferencesFunctions.email ?? "";
    zipController.text = SharedPreferencesFunctions.zipcode.toString();
    addressInfo = await ApiMethods().getDataByPostApi(
      {"pincode": SharedPreferencesFunctions.zipcode},
      baseUrl + zipCodeUrl,
    );
    if (addressInfo.isNotEmpty) {
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (formKey.currentState!.validate()) {
            setState(
              () {
                showCPI = true;
              },
            );

            Map<String, dynamic> individualUserData = {
              "user_id": SharedPreferencesFunctions.userId,
              "user_type_id": widget.userTypeId == 0 ? 1 : widget.userTypeId,
              "name": nameController.text.trim(),
              "mobile": phoneNumberController.text.trim(),
              "email": emailController.text.trim(),
              "address": addressController.text.trim(),
              "country_id": addressInfo[0]["country_id"],
              "state_id": addressInfo[0]["state_id"],
              "district_id": addressInfo[0]["district_id"],
              "city_id": addressInfo[0]["city_id"],
              "zipcode": zipController.text.trim(),
              "dob": "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
              "latlong":
                  "${addressInfo[0]["latitude"]},${addressInfo[0]["longitude"]}",
              "photo": ""
            };
            Map<String, dynamic> dealerUserData = {
              "user_id": SharedPreferencesFunctions.userId,
              "user_type_id": widget.userTypeId == 0 ? 1 : widget.userTypeId,
              "name": nameController.text.trim(),
              "mobile": phoneNumberController.text.trim(),
              "email": emailController.text.trim(),
              "address": addressController.text.trim(),
              "country_id": addressInfo[0]["country_id"],
              "state_id": addressInfo[0]["state_id"],
              "district_id": addressInfo[0]["district_id"],
              "city_id": addressInfo[0]["city_id"],
              "zipcode": zipController.text.trim(),
              "dob": "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
              "company_name": companyNameController.text.trim(),
              "gst_no": gstNumberController.text.trim(),
              "latlong":
                  "${addressInfo[0]["latitude"]},${addressInfo[0]["longitude"]}",
              "photo": ""
            };

            // var result;
            var result = await ApiMethods().postData(
              widget.userTypeId == 2 ? dealerUserData : individualUserData,
              baseUrl + registrationUrl,
            );
            Future.delayed(
              Duration(
                milliseconds: 300,
              ),
            );
            setState(() {
              showCPI = false;
            });

            print(result);

            if (result == true) {
              CurrentUserType = widget.userTypeId;
              if (widget.where == "home") {
                gotoWithoutBack(
                  context,
                  ProductSelectionScreen(),
                );
              } else {
                Navigator.pop(context);
              }

              showSnackbar(
                context,
                welcomeTitle.tr,
              );
            } else {
              showSnackbar(
                context,
                tryAgain.tr,
              );
            }
          } else {
            showSnackbar(
              context,
              pleaseFillFileds.tr,
            );
          }
        },
        child: Container(
          color: darkgreen,
          height: 50,
          width: double.infinity,
          alignment: Alignment.center,
          child: showCPI
              ? progressIndicator(context)
              : barlowBold(
                  text: compleRegistration.tr,
                  size: 24,
                  color: white,
                ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: appTitle.tr,
          color: white,
          size: 20,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       goto(
        //         context,
        //         NotificationsScreen(),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.notifications,
        //       color: white,
        //     ),
        //   ),
        // ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 70,
              width: double.infinity,
              color: greenShade300,
              child: barlowBold(
                text: enterYourDetails.tr,
                size: 23,
                color: white,
              ),
            ),
            VSpace(10),
            CustomTextfield(
              nameController,
              enterName.tr,
              name.tr,
              fillName.tr,
              TextInputType.text,
            ),
            VSpace(10),
            phoneNumberController.text != ""
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 8,
                      right: 15,
                    ),
                    child: TextFormField(
                      enabled: false,
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        label: Text(
                          phoneNumber.tr,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 15,
                        ),
                        border: customOutlineBorder(),
                      ),
                    ),
                  )
                : CustomTextfield(
                    phoneNumberController,
                    enterPhone.tr,
                    phoneNumber.tr,
                    fillPhoneNo.tr,
                    TextInputType.phone,
                  ),
            VSpace(10),
            // emailController.text != ""
            //     ?

            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextFormField(
                enabled: true,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text(
                    email.tr,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            // : CustomTextfield(
            //     emailController,
            //     enterEmail.tr,
            //     email.tr,
            //     fillEmail.tr,
            //     TextInputType.emailAddress,
            //   ),
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
                enabled: false,
                decoration: InputDecoration(
                  label: Text(
                    stateName.tr,
                  ),
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
                enabled: false,
                decoration: InputDecoration(
                  label: Text(
                    cityTownArea.tr,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  border: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(10),
            CustomTextfield(
              addressController,
              enterAddress.tr,
              address.tr,
              fillAddress.tr,
              TextInputType.text,
            ),
            VSpace(10),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: zipController,
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
                  if (value.length == 6) {
                    addressInfo = await ApiMethods().getDataByPostApi(
                      {"pincode": zipController.text},
                      baseUrl + zipCodeUrl,
                    );
                    if (addressInfo.isNotEmpty) {
                      stateController.text = addressInfo[0]["state_name"];
                      cityController.text = addressInfo[0]["city_name"];

                      setState(() {});
                    }
                  }
                },
                decoration: InputDecoration(
                  label: Text(
                    enterZipcode.tr,
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 15,
                  ),
                  hintText: enterZipcode.tr,
                  enabledBorder: customOutlineBorder(),
                  focusedBorder: customOutlineBorder(),
                  errorBorder: customOutlineBorder(),
                  focusedErrorBorder: customOutlineBorder(),
                  counterText: "",
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: greyShade400,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    barlowRegular(
                      text:
                          "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}",
                      color: black,
                      size: 17,
                    ),
                    IconButton(
                      onPressed: () {
                        showDate();
                      },
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                ),
              ),
            ),
            VSpace(20)
          ],
        ),
      ),
    );
  }

  Future showDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (date != null) {
      pickedDate = date;
      setState(() {});
    }
  }
}
