import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_year_screen.dart';
import 'package:krishivikas/Screens/tyres/tyres_insert_deatils_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/api_urls.dart';
import 'notification/notifications_screen.dart';

class SelectModelScreen extends StatefulWidget {
  final categoryId, brandId, s;
  final String type;
  final String brandName;

  SelectModelScreen(
    this.categoryId,
    this.brandId,
    this.s,
    this.type,
    this.brandName,
  );

  @override
  State<SelectModelScreen> createState() => _SelectModelScreenState();
}

class _SelectModelScreenState extends State<SelectModelScreen> {
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
              text: selectModel.tr,
              size: 20,
              color: white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: FutureBuilder<List>(
                future: ApiMethods().getModelsByPostApi(
                  baseUrl + modelUrl,
                  widget.categoryId,
                  widget.brandId,
                ),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? snapshot.data!.length == 0
                          ? Center(
                              child: barlowRegular(
                                text: noDataFound.tr,
                                size: 15,
                                color: black,
                              ),
                            )
                          : GridView.builder(
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 5.0,
                                childAspectRatio: fullWidth(context) /
                                    (fullHeight(context) / 2.3),
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (widget.categoryId == 7) {
                                        goto(
                                          context,
                                          TyresInsertDeatilsScreen(
                                            type: widget.type,
                                            categoryId: widget.categoryId,
                                            brandId: widget.brandId,
                                            modelId: snapshot.data![index]
                                                ['id'],
                                            brandName: widget.brandName,
                                          ),
                                        );
                                      } else {
                                        goto(
                                          context,
                                          SelectYearScreen(
                                            widget.s,
                                            widget.type,
                                            widget.brandId,
                                            snapshot.data![index]["id"],
                                            widget.categoryId,
                                            widget.brandName,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: grey,
                                            blurRadius: 2,
                                          )
                                        ],
                                      ),
                                      height: fullWidth(context) /
                                          (fullHeight(context) / 2.4),
                                      child: Column(
                                        children: [
                                          //image_error_case
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: setImageForBrandAndModel(
                                                snapshot.data![index]["icon"],
                                                context),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: FittedBox(
                                              child: barlowBold(
                                                text: snapshot.data![index]
                                                    ["model_name"],
                                                size: 13,
                                                color: black,
                                              ),
                                            ),
                                          ),
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
          ),
        ],
      ),
    );
  }
}
