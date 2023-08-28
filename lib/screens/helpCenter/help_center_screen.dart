import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/Screens/helpCenter/widget/help_center_widget.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/helpCenter/widget/about_app_page.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import '../../const/colors.dart';
import '../../main.dart';
import '../../services/auth_methods.dart';
import '../../widgets/all_widgets.dart';
import 'widget/data_privacy_page.dart';
import 'widget/privacy_policy_page.dart';
import 'widget/terms_use_page.dart.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({
    Key? key,
  }) : super(
    key: key,
  );

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomExpansionWidget(
              title: aboutUs.tr,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutAppPage(
                      tearmsTitle: aboutUs.tr,
                    ),
                  ),
                );
              },
            ),
            CustomExpansionWidget(
              title: termsOfUse.tr,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TermsOfUsePage(
                      tearmsTitle: termsOfUse.tr,
                    ),
                  ),
                );
              },
            ),
            CustomExpansionWidget(
              title: privacyPolicy.tr,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage(
                      tearmsTitle: privacyPolicy.tr,
                    ),
                  ),
                );
              },
            ),
            CustomExpansionWidget(
              title: dataPrivacy.tr,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataPrivacyPage(
                      tearmsTitle: dataPrivacy.tr,
                    ),
                  ),
                );
              },
            ),
            CustomExpansionWidget(
              title: rateUs.tr,
              onTap: () {
                StoreRedirect.redirect(
                  androidAppId: "com.krishivikas.android",
                  // iOSAppId: "585027354",
                );
              },
            ),
            CustomExpansionWidget(
              title: shareApp.tr,
              onTap: () {
                share(context);
              },
            ),
            CustomExpansionWidget(
              title: logOut.tr,
              onTap: () {
                showExitPopup(context);
              },
            ),
            CustomExpansionWidget(
              title: account_disable.tr,
              onTap: () {
                showDisablePopup(context);
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Future<void> share(BuildContext context) async {
    await Share.share(
        'https://play.google.com/store/apps/details?id=com.krishivikas.android',
        subject: "Krishi Vikas Udhyog");
  }

  showExitPopup(context) {
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
                  text: logOutApp.tr,
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
                          await preferences.clear();
                          await AuthMethods().logoutFromPhone();
                          await AuthMethods().logOutFromGoogle();
                          await AuthMethods().facebookSignOut();

                          gotoUtillBack(
                            context,
                            LoginScreen(),
                          );
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

  showDisablePopup(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(account_disable_notice.tr),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await preferences.clear();
                          print(SharedPreferencesFunctions.userId);
                          print(SharedPreferencesFunctions.token);
                          await ApiMethods()
                              .UserDisable(baseUrl + user_disable)
                              .then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Disabled Successfully"),
                              backgroundColor: darkgreen,
                            ));
                          }).then((value) async {
                            await FirebaseAuth.instance.signOut().then((value) {
                              gotoWithoutBack(context, LoginScreen());
                            });
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
}
