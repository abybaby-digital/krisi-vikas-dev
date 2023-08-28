import 'package:flutter/material.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/screens/category/sub_categories_seed.dart';
import 'package:krishivikas/screens/category/sub_categories_tractor.dart';
import 'package:krishivikas/screens/category/sub_categories_tyre.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/colors.dart';
import '../services/save_user_info.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<dynamic>> getCategory() async {
    if (allcategory.isEmpty) {
      allcategory = (await ApiMethods().getData(
        baseUrl + categoryUrl,
      ));
    }
    return allcategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getCategory(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: InkWell(
                            onTap: () {
                              ///Seeds List Screen
                              if (snapshot.data![index]["id"] == 6 ||
                                  snapshot.data![index]["id"] == 8 ||
                                  snapshot.data![index]["id"] == 9) {
                                goto(
                                  context,
                                  SubCategoriesSeed(
                                    category: SharedPreferencesFunctions()
                                                .getLanguage() ==
                                            "Hindi"
                                        ? snapshot.data![index]["ln_hn"]
                                        : SharedPreferencesFunctions()
                                                    .getLanguage() ==
                                                "Bengali"
                                            ? snapshot.data![index]["ln_bn"]
                                            : snapshot.data![index]["category"],
                                    categoryId: snapshot.data![index]["id"],
                                  ),
                                );
                              } else if (snapshot.data![index]["id"] == 7) {
                                ////Tyre list Screen
                                goto(
                                  context,
                                  SubCategoriesTyre(
                                    category: SharedPreferencesFunctions()
                                                .getLanguage() ==
                                            "Hindi"
                                        ? snapshot.data![index]["ln_hn"]
                                        : SharedPreferencesFunctions()
                                                    .getLanguage() ==
                                                "Bengali"
                                            ? snapshot.data![index]["ln_bn"]
                                            : snapshot.data![index]["category"],
                                    categoryId: snapshot.data![index]["id"],
                                  ),
                                );
                              } else {
                                ///Tractor,Rent Tractor,Good Vehical ,harvester and implement List Screen
                                goto(
                                  context,
                                  SubCategoriesTractor(
                                    category: SharedPreferencesFunctions()
                                                .getLanguage() ==
                                            "Hindi"
                                        ? snapshot.data![index]["ln_hn"]
                                        : SharedPreferencesFunctions()
                                                    .getLanguage() ==
                                                "Bengali"
                                            ? snapshot.data![index]["ln_bn"]
                                            : snapshot.data![index]["category"],
                                    categoryId: snapshot.data![index]["id"],
                                  ),
                                );
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: fullHeight(context) * 0.01,
                                ),
                                Container(
                                  height: fullHeight(context) * 0.13,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: grey,
                                        blurRadius: 3,
                                      ),
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Image.asset(
                                        AppImages.images[index],
                                      ),
                                    ),
                                  ),
                                ),
                                // VSpace(5),
                                Container(
                                  height: fullHeight(context) * 0.05,
                                  width: 90,
                                  child: barlowSemiBold(
                                    // maxLine: 2,
                                    text: SharedPreferencesFunctions()
                                                .getLanguage() ==
                                            "Hindi"
                                        ? snapshot.data![index]["ln_hn"]
                                        : SharedPreferencesFunctions()
                                                    .getLanguage() ==
                                                "Bengali"
                                            ? snapshot.data![index]["ln_bn"]
                                            : snapshot.data![index]["category"],
                                    size: 13,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : progressIndicator(context);
      },
    );
  }
}
