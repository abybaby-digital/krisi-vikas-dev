import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/condition_select_screen.dart';
import 'package:krishivikas/Screens/select_brand_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/models/harvester_model.dart';
import 'package:krishivikas/models/implements_model.dart';
import 'package:krishivikas/screens/rent/widget/rent_category_widget.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../const/app_images.dart';
import '../../services/save_user_info.dart';
import '../notification/notifications_screen.dart';

class RentCategoryScreen extends StatefulWidget {
  const RentCategoryScreen({
    Key? key,
  }) : super(
    key: key,
  );

  @override
  State<RentCategoryScreen> createState() => _RentCategoryScreenState();
}

class _RentCategoryScreenState extends State<RentCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            color: greenShade300,
            child: barlowBold(
              text: whatWouldYouLiketoRent.tr,
              color: white,
              size: 19,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 8,
                bottom: 8,
              ),
              child: FutureBuilder<List>(
                future: ApiMethods().getData(
                  baseUrl + categoryUrl,
                ),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data!.length == 0
                      ? Center(
                    child: Text(
                      "No Category",
                    ),
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          RentCategoryWidget(
                            rentCategoryImage: AppImages.images[0],
                            rentCategoryText:
                            SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Hindi"
                                ? snapshot.data![0]["ln_hn"]
                                : SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Bengali"
                                ? snapshot.data![0]["ln_bn"]
                                : snapshot.data![0]
                            ["category"],
                            onTap: () {
                              if (CurrentUserType == 2) {
                                TractorData.categoryId =
                                snapshot.data![0]["id"];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConditionSelectScreen(
                                          snapshot.data![0]["id"],
                                          "rent",
                                        ),
                                  ),
                                );
                              } else {
                                TractorData.type = "old";
                                HarvesterData.type = "old";
                                ImplementsData.type = "old";
                                TractorData.productType = "rent";
                                HarvesterData.productType = "rent";
                                HarvesterData.categoryId =
                                snapshot.data![0]["id"];
                                ImplementsData.productType = "rent";
                                ImplementsData.categoryId =
                                snapshot.data![0]["id"];
                                goto(
                                  context,
                                  SelectBrandScreen(
                                    snapshot.data![0]["id"],
                                    "rent",
                                    "old",
                                  ),
                                );
                              }
                            },
                          ),
                          RentCategoryWidget(
                            rentCategoryImage: AppImages.images[1],
                            rentCategoryText:
                            SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Hindi"
                                ? snapshot.data![1]["ln_hn"]
                                : SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Bengali"
                                ? snapshot.data![1]["ln_bn"]
                                : snapshot.data![1]
                            ["category"],
                            onTap: () {
                              if (CurrentUserType == 2) {
                                TractorData.categoryId =
                                snapshot.data![1]["id"];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConditionSelectScreen(
                                          snapshot.data![1]["id"],
                                          "rent",
                                        ),
                                  ),
                                );
                              } else {
                                TractorData.type = "old";
                                HarvesterData.type = "old";
                                ImplementsData.type = "old";
                                TractorData.productType = "rent";
                                HarvesterData.productType = "rent";
                                HarvesterData.categoryId =
                                snapshot.data![1]["id"];
                                ImplementsData.productType = "rent";
                                ImplementsData.categoryId =
                                snapshot.data![1]["id"];
                                goto(
                                  context,
                                  SelectBrandScreen(
                                    snapshot.data![1]["id"],
                                    "rent",
                                    "old",
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      VSpace(30),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          RentCategoryWidget(
                            rentCategoryImage: AppImages.images[5],
                            rentCategoryText:
                            SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Hindi"
                                ? snapshot.data![5]["ln_hn"]
                                : SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Bengali"
                                ? snapshot.data![5]["ln_bn"]
                                : snapshot.data![5]
                            ["category"],
                            onTap: () {
                              if (CurrentUserType == 2) {
                                TractorData.categoryId =
                                snapshot.data![5]["id"];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConditionSelectScreen(
                                          snapshot.data![5]["id"],
                                          "rent",
                                        ),
                                  ),
                                );
                              } else {
                                TractorData.type = "old";
                                HarvesterData.type = "old";
                                ImplementsData.type = "old";
                                TractorData.productType = "rent";
                                HarvesterData.productType = "rent";
                                HarvesterData.categoryId =
                                snapshot.data![5]["id"];
                                ImplementsData.productType = "rent";
                                ImplementsData.categoryId =
                                snapshot.data![5]["id"];
                                goto(
                                  context,
                                  SelectBrandScreen(
                                    snapshot.data![5]["id"],
                                    "rent",
                                    "old",
                                  ),
                                );
                              }
                            },
                          ),
                          RentCategoryWidget(
                            rentCategoryImage: AppImages.images[6],
                            rentCategoryText:
                            SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Hindi"
                                ? snapshot.data![6]["ln_hn"]
                                : SharedPreferencesFunctions()
                                .getLanguage() ==
                                "Bengali"
                                ? snapshot.data![6]["ln_bn"]
                                : snapshot.data![6]
                            ["category"],
                            onTap: () {
                              if (CurrentUserType == 2) {
                                TractorData.categoryId =
                                snapshot.data![6]["id"];

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ConditionSelectScreen(
                                          snapshot.data![6]["id"],
                                          "rent",
                                        ),
                                  ),
                                );
                              } else {
                                TractorData.type = "old";
                                HarvesterData.type = "old";
                                ImplementsData.type = "old";
                                TractorData.productType = "rent";
                                HarvesterData.productType = "rent";
                                HarvesterData.categoryId =
                                snapshot.data![6]["id"];
                                ImplementsData.productType = "rent";
                                ImplementsData.categoryId =
                                snapshot.data![6]["id"];
                                goto(
                                  context,
                                  SelectBrandScreen(
                                    snapshot.data![6]["id"],
                                    "rent",
                                    "old",
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  )
                      : Center(
                    child: progressIndicator(context),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
