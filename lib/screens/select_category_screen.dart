import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_data_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticide_data_screen.dart';
import 'package:krishivikas/Screens/seeds/seeds_data_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/models/harvester_model.dart';
import 'package:krishivikas/models/implements_model.dart';
import 'package:krishivikas/screens/condition_select_screen.dart';
import 'package:krishivikas/screens/select_brand_screen.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/api_urls.dart';
import '../const/app_images.dart';
import '../models/fertilizer_model.dart';
import '../models/pesticides_model.dart';
import '../models/seeds_model.dart';
import '../models/tyres_model.dart';
import '../services/save_user_info.dart';
import 'notification/notifications_screen.dart';

class SelectCategoryScreen extends StatelessWidget {
  SelectCategoryScreen({
    Key? key,
  }) : super(
          key: key,
        );

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
        //   )
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
              text: whatWouldYouLiketoSell.tr,
              size: 20,
              color: white,
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
                              child: barlowRegular(
                                text: noCategory.tr,
                                size: 15,
                                color: black,
                              ),
                            )
                          : GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.25,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      ///Categeory Id Add To Tractor Model
                                      TractorData.categoryId =
                                          snapshot.data![index]["id"];

                                      ///Category Id Added To Seeds Model
                                      SeedsData.categoryId =
                                          snapshot.data![index]["id"];

                                      ///Category Id Added To Pesticides Model
                                      PesticidesData.categoryId =
                                          snapshot.data![index]["id"];

                                      ///Category Id Added To Fertilizers Model
                                      FertilizerData.categoryId =
                                          snapshot.data![index]["id"];

                                      ///Category Id Added To Tyres Model
                                      TyresData.categoryId =
                                          snapshot.data![index]["id"];

                                      if (SeedsData.categoryId == 6) {
                                        goto(
                                          context,
                                          SeedsDataScreen(
                                            categoryId: snapshot.data![index]
                                                ["id"],
                                          ),
                                        );
                                      } else if (PesticidesData.categoryId ==
                                          8) {
                                        goto(
                                          context,
                                          PesticideDataScreen(
                                            categoryId: snapshot.data![index]
                                                ["id"],
                                          ),
                                        );
                                      } else if (FertilizerData.categoryId ==
                                          9) {
                                        goto(
                                          context,
                                          FertilizerDataScreen(
                                            categoryId: snapshot.data![index]
                                                ["id"],
                                          ),
                                        );
                                      } else {
                                        if (CurrentUserType == 2) {
                                          goto(
                                            context,
                                            ConditionSelectScreen(
                                              snapshot.data![index]["id"],
                                              "sell",
                                            ),
                                          );
                                        } else {
                                          TractorData.type = "old";
                                          HarvesterData.type = "old";
                                          ImplementsData.type = "old";
                                          TyresData.type = "old";
                                          TractorData.productType = "sell";
                                          HarvesterData.productType = "sell";
                                          HarvesterData.categoryId =
                                              snapshot.data![index]["id"];
                                          ImplementsData.productType = "sell";
                                          ImplementsData.categoryId =
                                              snapshot.data![index]["id"];
                                          goto(
                                            context,
                                            SelectBrandScreen(
                                              snapshot.data![index]["id"],
                                              "sell",
                                              "old",
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 3,
                                          )
                                        ],
                                        color: white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              AppImages.images[index],
                                              width: fullWidth(context) * 0.25,
                                              height: fullWidth(context) * 0.25,
                                            ),
                                          ),
                                          barlowBold(
                                            text: SharedPreferencesFunctions()
                                                        .getLanguage() ==
                                                    "Hindi"
                                                ? snapshot.data![index]["ln_hn"]
                                                : SharedPreferencesFunctions()
                                                            .getLanguage() ==
                                                        "Bengali"
                                                    ? snapshot.data![index]
                                                        ["ln_bn"]
                                                    : snapshot.data![index]
                                                        ["category"],
                                            size: 14,
                                            color: black,
                                          ),
                                          VSpace(5),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
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
