import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/setting_custom_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSelectedEmail = false;

  bool isSelectedWhatupNotification = false;

  bool isSelectedPromotions = false;

  bool isSelectedMarketing = false;

  bool isSelectedSocialMedia = false;

  int emailNewsLetter = 0;
  int WhatupNotification = 0;
  int Promotions = 0;
  int Marketing = 0;
  int SocialMedia = 0;

  String languageNames = "English";

  List<String> languages = <String>[
    "English",
    "Hindi",
    "Bengali",
  ];

  List locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('bd', 'BD'),
  ];

  @override
  void initState() {
    languageNames = SharedPreferencesFunctions().getLanguage() ?? languageNames;
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: grey,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    HSpace(20),
                    Image.asset(
                      AppImages.languageIcon,
                      width: 30,
                      height: 30,
                    ),
                    HSpace(20),
                    barlowSemiBold(
                      text: language.tr,
                      size: 17,
                      color: grey,
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 15,
                            top: 8,
                            right: 15,
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyShade400,
                                width: 2,
                              ),
                            ),
                            child: DropdownButton(
                              value: languageNames,
                              underline: SizedBox(),
                              items: languages.map((item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Row(
                                    children: [
                                      HSpace(8),
                                      Icon(
                                        Icons.language_rounded,
                                        size: 15,
                                      ),
                                      HSpace(10),
                                      barlowRegular(
                                        text: item,
                                        color: lightgreen,
                                        size: 13,
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (Value) async {
                                await SharedPreferencesFunctions().getUserId();
                                await SharedPreferencesFunctions().getToken();
                                setState(
                                  () {
                                    languageNames = Value.toString();
                                    SharedPreferencesFunctions()
                                        .saveLanguage(languageNames);
                                    if (languageNames == "English") {
                                      getBannerAndVideoListUpdate();
                                      languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),1);
                                      setState(() {});
                                      Get.updateLocale(locales[0]);
                                    } else if (languageNames == "Hindi") {
                                      getBannerAndVideoListUpdate();
                                      languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),2);
                                      setState(() {});
                                      Get.updateLocale(locales[1]);
                                    } else {
                                      getBannerAndVideoListUpdate();
                                      languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),3);
                                      setState(() {});
                                      Get.updateLocale(locales[2]);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SettingCustomWidget(
              title: emailSletter.tr,
              settingIcon: AppImages.emailIcon,
              onTap: (value) {
                setState(
                  () {
                    isSelectedEmail = value!;
                    if (value == true) {
                      emailNewsLetter = 1;
                    } else {
                      emailNewsLetter = 0;
                    }
                  },
                );
              },
              isSwitch: isSelectedEmail,
              message: "Email Newsletter",
            ),
            SettingCustomWidget(
              title: whatsAppNotification.tr,
              settingIcon: AppImages.whatupIcon,
              onTap: (value) {
                setState(
                  () {
                    isSelectedWhatupNotification = value!;
                    if (value == true) {
                      WhatupNotification = 1;
                    } else {
                      WhatupNotification = 0;
                    }
                  },
                );
              },
              isSwitch: isSelectedWhatupNotification,
              message: "Whatsapp Notification",
            ),
            SettingCustomWidget(
              title: promotionOffer.tr,
              settingIcon: AppImages.promotionIcon,
              onTap: (value) {
                setState(
                  () {
                    isSelectedPromotions = value!;
                    if (value == true) {
                      Promotions = 1;
                    } else {
                      Promotions = 0;
                    }
                  },
                );
              },
              isSwitch: isSelectedPromotions,
              message: "Promition And Offers",
            ),
            SettingCustomWidget(
              title: marketingCommunication.tr,
              settingIcon: AppImages.supportIcon,
              onTap: (value) {
                setState(
                  () {
                    isSelectedMarketing = value!;
                    if (value == true) {
                      Marketing = 1;
                    } else {
                      Marketing = 0;
                    }
                  },
                );
              },
              isSwitch: isSelectedMarketing,
              message: "Marketing Communication",
            ),
            SettingCustomWidget(
              title: socialMediaPromotion.tr,
              settingIcon: AppImages.socialMediaIcon,
              onTap: (value) {
                setState(
                  () {
                    isSelectedSocialMedia = value!;
                    if (value == true) {
                      SocialMedia = 1;
                    } else {
                      SocialMedia = 0;
                    }
                  },
                );
              },
              isSwitch: isSelectedSocialMedia,
              message: "Social Media Promotion",
            ),
          ],
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () => addSettingsData(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
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
  void languageSet(String userId, String userToken, int languageId) async {
    final apiUrl =baseUrl + languageSave;
    // Replace with your API endpoint
    final Map<String, dynamic> data = {
      'user_id': userId,
      'user_token': userToken,
      'language_id': languageId,
      // Add other data fields as needed
    };
    final dio = Dio();
    try {
      final response = await dio.post(apiUrl, data: data);
      if (response.statusCode == 200) {
        // Successfully updated data
        print('Data updated successfully.');
      } else {
        // Handle errors
        print('Failed to update data. Error: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  doThisOnLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    var userInfo = await ApiMethods().getUserInfoByPostApi(
      baseUrl + profileUrl,
      await SharedPreferencesFunctions.userId!,
      await SharedPreferencesFunctions.token!,
    );

    if (userInfo != null) {
      if (userInfo["email_newslatter"] == 1) {
        isSelectedEmail = true;
        emailNewsLetter = 1;
      } else {
        isSelectedEmail = false;
        emailNewsLetter = 0;
      }
      if (userInfo["whatsapp_notification"] == 1) {
        isSelectedWhatupNotification = true;
        WhatupNotification = 1;
      } else {
        isSelectedWhatupNotification = false;
        WhatupNotification = 0;
      }
      if (userInfo["promotin"] == 1) {
        isSelectedPromotions = true;
        Promotions = 1;
      } else {
        isSelectedPromotions = false;
        Promotions = 0;
      }
      if (userInfo["marketing_communication"] == 1) {
        isSelectedMarketing = true;
        Marketing = 1;
      } else {
        isSelectedMarketing = false;
        Marketing = 0;
      }
      if (userInfo["social_media_promotion"] == 1) {
        isSelectedSocialMedia = true;
        SocialMedia = 1;
      } else {
        isSelectedSocialMedia = false;
        SocialMedia = 0;
      }
      print(userInfo["email_newslatter"]);
      print("userInfo");
      print(userInfo);
    }
    setState(
      () {},
    );
  }

  addSettingsData() async {
    await SharedPreferencesFunctions().getUserId();

    await SharedPreferencesFunctions().getToken();

    Map<String, dynamic> data = {
      "user_id": SharedPreferencesFunctions.userId,
      "user_token": SharedPreferencesFunctions.token,
      "email_newslatter": emailNewsLetter,
      "whatsapp_notification": WhatupNotification,
      "promotin": Promotions,
      "marketing_communication": Marketing,
      "social_media_promotion": SocialMedia,
    };

    var result = await ApiMethods().sendSettingsPromotion(
      baseUrl + promotionUrl,
      data,
    );

    print("Send Data");
    print(data);
    print("Received result");
    print(result);

    if (result == true) {
    } else {}

    setState(() {
      showSnackbar(
        context,
        sucess.tr,
      );
    });
  }
}
