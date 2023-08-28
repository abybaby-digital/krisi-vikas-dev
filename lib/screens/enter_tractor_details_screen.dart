import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/screens/tractor_images_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/api_urls.dart';
import '../language/language_key.dart';
import 'notification/notifications_screen.dart';

class EnterTractordetailsScreen extends StatefulWidget {
  final s;
  final String type;
  final int brandId;
  final int modelId;
  final int categoryId;
  final int yearOfPurchase;
  final String brandName;

  EnterTractordetailsScreen(
    this.s,
    this.type,
    this.brandId,
    this.modelId,
    this.categoryId,
    this.yearOfPurchase,
    this.brandName,
  );

  @override
  State<EnterTractordetailsScreen> createState() =>
      _EnterTractordetailsScreenState();
}

class _EnterTractordetailsScreenState extends State<EnterTractordetailsScreen> {
  bool rcAvailabel = false;

  bool financierNoc = false;

  bool isNegotiable = false;

  TextEditingController regNo = TextEditingController();

  TextEditingController price = TextEditingController();

  TextEditingController titleForOthersBrand = TextEditingController();

  TextEditingController tractorDetails = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController zipController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var addressInfo;

  String productSelect = "Select From";

  final List<String> productSelectionDropDownList = <String>[
    "Per Hour",
    "Per Day",
    "Per Month",
  ];

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserZipcode();
    addressInfo = await ApiMethods().getDataByPostApi(
      {"pincode": currentLocation},
      baseUrl + zipCodeUrl,
    );

    if (addressInfo.isNotEmpty) {
      zipController.text = currentLocation.toString();
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    doThisOnLaunch();
    productSelect = productSelectionDropDownList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: fullWidth(context) * 0.50,
              decoration: BoxDecoration(
                color: darkgreen,
                border: Border(
                  right: BorderSide(
                    color: white,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: barlowBold(
                text: previous.tr,
                color: white,
                size: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                // SharedPreferencesFunctions().saveUserZipcode(int.parse(zipController.text));
                addressInfo = await ApiMethods().getDataByPostApi(
                  {"pincode": zipController.text},
                  baseUrl + zipCodeUrl,
                );
                if (addressInfo.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TractorImagesScreen(
                        setType: widget.s,
                        type: widget.type,
                        regNo: regNo.text,
                        rentType: productSelect.toString(),
                        price: int.parse(price.text),
                        rcAvailabel: rcAvailabel,
                        financierNoc: financierNoc,
                        tractorDetails: tractorDetails.text,
                        isNegotiable: isNegotiable,
                        countryId: addressInfo[0]["country_id"],
                        stateId: addressInfo[0]["state_id"],
                        cityId: addressInfo[0]["city_id"],
                        districtId: addressInfo[0]["district_id"],
                        lat: addressInfo[0]["latitude"],
                        lang: addressInfo[0]["longitude"],
                        zipcode: int.parse(zipController.text),
                        brandId: widget.brandId,
                        modelId: widget.modelId,
                        categoryId: widget.categoryId,
                        yearOfPurchase: widget.yearOfPurchase,
                        titleForSelectOthers: titleForOthersBrand.text,
                      ),
                    ),
                  );
                } else {
                  showSnackbar(
                    context,
                    notValidZipCode.tr,
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
              height: 50,
              width: fullWidth(context) * 0.50,
              decoration: BoxDecoration(
                color: darkgreen,
                border: Border(
                  left: BorderSide(
                    color: white,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: barlowBold(
                text: next.tr,
                color: white,
                size: 20,
              ),
            ),
          )
        ],
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
        //   )
        // ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: greenShade300,
              child: barlowBold(
                text: enterDetails.tr,
                color: white,
                size: 19,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 10,
                bottom: 8,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      barlowBold(
                        text: rcAvailableValue.tr,
                        color: black,
                        size: 18,
                      ),
                      Switch(
                        activeColor: darkgreen,
                        inactiveTrackColor: darkgreen,
                        value: rcAvailabel,
                        onChanged: (value) {
                          setState(
                            () {
                              rcAvailabel = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 14,
                right: 14,
                top: 2,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      barlowBold(
                        text: nocAvailableValue.tr,
                        color: black,
                        size: 18,
                      ),
                      Switch(
                        activeColor: darkgreen,
                        inactiveTrackColor: darkgreen,
                        value: financierNoc,
                        onChanged: (value) {
                          setState(
                            () {
                              financierNoc = value;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VSpace(10),
            widget.brandName == "Others"
                ? CustomTextfield(
                    titleForOthersBrand,
                    enterBrandAndModel.tr,
                    enterBrandAndModel.tr,
                    fillBrandAndModel.tr,
                    TextInputType.text,
                  )
                : SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 8,
                right: 15,
              ),
              child: SizedBox(
                child: TextFormField(
                  controller: regNo,
                  cursorColor: grey,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: barlowRegular(
                        text: regNumber.tr, size: 15, color: grey),
                    contentPadding: EdgeInsets.only(left: 15),
                    hintText: enterRegNumber.tr,
                    enabledBorder: customOutlineBorder(),
                    focusedBorder: customOutlineBorder(),
                  ),
                ),
              ),
            ),
            VSpace(10),
            CustomTextfield(
              price,
              enterPrice.tr,
              priceValue.tr,
              fillPrice.tr,
              TextInputType.number,
            ),
            widget.s == "sell"
                ? SizedBox.shrink()
                : Container(
                    margin: const EdgeInsets.only(
                      left: 15,
                      top: 8,
                      right: 15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: greyShade400,
                        width: 2,
                      ),
                    ),
                    child: DropdownButton(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.arrow_drop_down_circle_sharp,
                          ),
                        ),
                        isExpanded: true,
                        underline: SizedBox(),
                        value: productSelect.isNotEmpty ? productSelect : "",
                        items: productSelectionDropDownList.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: barlowRegular(
                                text: item,
                                color: black,
                                size: 19,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (Value) {
                          setState(() {
                            productSelect = Value.toString();
                          });
                        }),
                  ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 14, right: 14, top: 10, bottom: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      barlowBold(
                        text: negotiableValue.tr,
                        color: black,
                        size: 18,
                      ),
                      Switch(
                        activeColor: darkgreen,
                        inactiveTrackColor: darkgreen,
                        value: isNegotiable,
                        onChanged: (value) {
                          setState(() {
                            isNegotiable = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
                  contentPadding: EdgeInsets.only(left: 15),
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
                  label: barlowRegular(
                    text: cityTownArea.tr,
                    size: 15,
                    color: grey,
                  ),
                  contentPadding: EdgeInsets.only(left: 15),
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
                      {
                        "pincode": value,
                      },
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
            Padding(
              padding: EdgeInsets.only(
                left: 18,
                top: 20,
              ),
              child: barlowBold(
                text: description.tr,
                size: 16,
                color: black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                top: 8,
                right: 18,
              ),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                controller: tractorDetails,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white24,
                  hintText: description.tr,
                  hintStyle: TextStyle(
                    fontFamily: "Barlow",
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  enabledBorder: customOutlineBorder(),
                  focusedBorder: customOutlineBorder(),
                  errorBorder: customOutlineBorder(),
                  focusedErrorBorder: customOutlineBorder(),
                ),
              ),
            ),
            VSpace(20)
          ],
        ),
      ),
    );
  }
}
