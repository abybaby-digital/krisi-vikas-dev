import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/seeds/seeds_image_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../models/seeds_model.dart';
import '../notification/notifications_screen.dart';

class SeedsDataScreen extends StatefulWidget {
  final categoryId;

  SeedsDataScreen({this.categoryId});

  @override
  State<SeedsDataScreen> createState() => _SeedsDataScreenState();
}

class _SeedsDataScreenState extends State<SeedsDataScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController stateController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController zipController = TextEditingController();

  TextEditingController seedsDescriptionController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  bool isNegotiable = false;

  var addressInfo;

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
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
                addressInfo = await ApiMethods().getDataByPostApi(
                  {"pincode": zipController.text},
                  baseUrl + zipCodeUrl,
                );

                if (addressInfo.isNotEmpty) {
                  SeedsData.title = titleController.text;
                  SeedsData.price = priceController.text;
                  SeedsData.description = seedsDescriptionController.text;
                  SeedsData.IsNegotiable = isNegotiable ? 1 : 0;

                  SeedsData.countryId = addressInfo[0]["country_id"];

                  SeedsData.stateId = addressInfo[0]["state_id"];
                  SeedsData.cityId = addressInfo[0]["city_id"];
                  SeedsData.districtId = addressInfo[0]["district_id"];
                  SeedsData.lat = addressInfo[0]["latitude"];
                  SeedsData.long = addressInfo[0]["longitude"];
                  SeedsData.zipcode = int.parse(zipController.text);
                  SeedsData.categoryId = widget.categoryId;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SeedsImageScreen(),
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
            VSpace(10),
            CustomTextfield(
              titleController,
              enterTitle.tr+'*',
              title.tr+'*',
              fillTitle.tr,
              TextInputType.text,
            ),
            VSpace(10),
            CustomTextfield(
              priceController,
              enterPrice.tr,
              priceValue.tr,
              fillPrice.tr,
              TextInputType.number,
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
                        text: negotiableValue.tr,
                        color: black,
                        size: 18,
                      ),
                      Switch(
                        activeColor: darkgreen,
                        inactiveTrackColor: darkgreen,
                        value: isNegotiable,
                        onChanged: (value) {
                          setState(
                            () {
                              isNegotiable = value;
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
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
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
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
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
              padding: const EdgeInsets.only(left: 15, top: 8, right: 15),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: zipController,
                validator: MultiValidator([
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
                ]),
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
              padding: EdgeInsets.only(left: 18, top: 20),
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
                controller: seedsDescriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: white24,
                  hintText: aboutSeeds.tr,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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

  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserZipcode();
    addressInfo = await ApiMethods().getDataByPostApi(
      {
        "pincode": currentLocation.toString(),
      },
      baseUrl + zipCodeUrl,
    );
    if (addressInfo.isNotEmpty) {
      zipController.text = currentLocation.toString().toString();
      stateController.text = addressInfo[0]["state_name"];
      cityController.text = addressInfo[0]["city_name"];
    }

    setState(() {});
  }
}
