import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_model_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../const/api_urls.dart';
import 'notification/notifications_screen.dart';

class SelectBrandScreen extends StatefulWidget {
  final categoryId;
  final s;
  final String type;

  SelectBrandScreen(
    this.categoryId,
    this.s,
    this.type,
  );

  @override
  State<SelectBrandScreen> createState() => _SelectBrandScreenState();
}

class _SelectBrandScreenState extends State<SelectBrandScreen> {
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: greenShade300,
              child: barlowBold(
                text: selectBrand.tr,
                size: 20,
                color: white,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<List>(
                  future: ApiMethods().getBrandsByPostApi(
                    baseUrl + brandUrl,
                    widget.categoryId,
                  ),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? snapshot.data!.length == 0
                            ? Center(
                                child: Text(
                                  noDataFound.tr,
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
                                  return InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: InkWell(
                                        onTap: () {
                                          goto(
                                            context,
                                            SelectModelScreen(
                                              widget.categoryId,
                                              snapshot.data![index]["id"],
                                              widget.s,
                                              widget.type,
                                              snapshot.data![index]["name"],
                                            ),
                                          );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: grey,
                                                  blurRadius: 2,
                                                )
                                              ]),
                                          height: fullWidth(context) /
                                              (fullHeight(context) / 2.3),
                                          child: Column(
                                            children: [
                                              //image_error_case
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: setImageForBrandAndModel(
                                                    snapshot.data![index]
                                                        ["logo"],
                                                    context),
                                              ),
                                              FittedBox(
                                                child: barlowBold(
                                                  text: snapshot.data![index]
                                                      ["name"],
                                                  size: 13,
                                                  color: black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                        : Center(
                            child: progressIndicator(context),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
