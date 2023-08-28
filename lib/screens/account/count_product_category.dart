import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/account/my_post_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/product_custom_widget.dart';

// ignore: must_be_immutable
class CountProductCategory extends StatefulWidget {
  String k, url;
  CountProductCategory(
    this.k,
    this.url,
  );

  @override
  State<CountProductCategory> createState() => _CountProductCategoryState();
}

class _CountProductCategoryState extends State<CountProductCategory> {
  List adCounters = [];

  @override
  void initState() {
    super.initState();
    getAdCounter();
  }

  @override
  Widget build(BuildContext context) {
    return adCounters.length > 0
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            shrinkWrap: true,
            physics: ScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: adCounters[0][widget.k][0].length,
            itemBuilder: (context, index) {
              var ds = adCounters[0][widget.k][0][index];

              return InkWell(
                onTap: () {
                  goto(
                    context,
                    MyPostScreen(
                      ds["category_id"],
                      ds["name"],
                      widget.url,
                      widget.k,
                    ),
                  );
                },
                child: ProductCustomWidget(
                  imageUrl: AppImages.images_profile[index],
                  count: ds["count"].toString(),
                  categoryName: SharedPreferencesFunctions().getLanguage() ==
                          "Hindi"
                      ? ds["ln_hn"]
                      : SharedPreferencesFunctions().getLanguage() == "Bengali"
                          ? ds["ln_bn"]
                          : ds["name"],
                          // : ds["name"],
                ),
              );
            },
          )
        : Center(
            child: progressIndicator(context),
          );
  }

  getAdCounter() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    adCounters = await ApiMethods().getProductsByPostApi(
      baseUrl + accountCounter,
      {
        "user_id": SharedPreferencesFunctions.userId,
        "user_token": SharedPreferencesFunctions.token,
      },
    );
    if (mounted) setState(() {});
  }
}
