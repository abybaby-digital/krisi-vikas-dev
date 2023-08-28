import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/api_urls.dart';
import '../services/save_user_info.dart';
import '../screens/home/home_screen.dart';
import 'language_key.dart';

class LanguageScreen extends StatefulWidget {
  LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List locales = [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('bd', 'BD'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: barlowBold(
                text: selectLanguage.tr,
                color: darkgreen,
                size: 25,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    await SharedPreferencesFunctions().getUserId();
                    await SharedPreferencesFunctions().getToken();
                    SharedPreferencesFunctions().saveLanguage("English");
                    Get.updateLocale(locales[0]);
                    languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),1);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 3,
                      )
                    ]),
                    height: width * 0.4,
                    width: width * 0.4,
                    child: Image.asset(
                      AppImages.englishLanguageIcon,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await SharedPreferencesFunctions().getUserId();
                    await SharedPreferencesFunctions().getToken();
                    SharedPreferencesFunctions().saveLanguage("Bengali");
                    Get.updateLocale(locales[2]);
                    languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),3);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 3,
                      )
                    ]),
                    height: width * 0.4,
                    width: width * 0.4,
                    child: Image.asset(
                      AppImages.BengalilanguageIcon,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  await SharedPreferencesFunctions().getUserId();
                  await SharedPreferencesFunctions().getToken();
                  bool a = false;
                  SharedPreferencesFunctions().saveLanguage("Hindi");
                  Get.updateLocale(locales[1]);
                  languageSet(SharedPreferencesFunctions.userId!.toString(),SharedPreferencesFunctions.token!.toString(),2);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 3,
                    )
                  ]),
                  height: width * 0.4,
                  width: width * 0.4,
                  child: Image.asset(
                    AppImages.hindiLanguageIcon,
                  ),
                ),
              ),
            ),
          ],
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
  // Future<String?>? languageSet(String userId, String userToken, int languageId) async {
  //   String url = baseUrl + languageSave;
  //   FormData formData = FormData.fromMap({
  //     "user_id": userId,
  //     "user_token": userToken,
  //     "language_id": languageId
  //   });
  //   // logger.e(body);
  //   var response =
  //       await Dio().post(url, data: formData);
  //   if (response.statusCode == 200) {
  //     Fluttertoast.showToast(msg: "Invoice added successfully");
  //   }
  //   else{
  //     Fluttertoast.showToast(msg: "Server error!");
  //   }
  //   return null;
  // }
}
