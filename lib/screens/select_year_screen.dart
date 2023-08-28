import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/enter_tractor_details_screen.dart';
import 'package:krishivikas/Screens/harvester/enter_harvester_details_screen.dart';
import 'package:krishivikas/Screens/implements/enter_implements_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/utils.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../language/language_key.dart';
import 'notification/notifications_screen.dart';

// ignore: must_be_immutable
class SelectYearScreen extends StatelessWidget {
  final s;
  final String type;
  final int brandId;
  final int modelId;
  final int categoryId;
  final String brandName;

  SelectYearScreen(
    this.s,
    this.type,
    this.brandId,
    this.modelId,
    this.categoryId,
    this.brandName,
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
              text: selectYear.tr,
              size: 20,
              color: white,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Utils.filterYear.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (categoryId == 1 || categoryId == 3) {
                      goto(
                        context,
                        EnterTractordetailsScreen(
                          s,
                          type,
                          brandId,
                          modelId,
                          categoryId,
                          int.parse(
                            Utils.filterYear[index],
                          ),
                          brandName,
                        ),
                      );
                    } else if (categoryId == 4) {
                      goto(
                        context,
                        EnterHarvesterScreen(
                          s,
                          type,
                          brandId,
                          modelId,
                          categoryId,
                          int.parse(
                            Utils.filterYear[index],                            
                          ),
                          brandName,
                        ),
                      );
                    } else if (categoryId == 5) {
                      goto(
                        context,
                        EnterImplementsScreen(
                          setType: s,
                          type: type,
                          brandId: brandId,
                          modelId: modelId,
                          categoryId: categoryId,
                          yearOfPurchase: int.parse(
                            Utils.filterYear[index],
                          ),
                          brandName:brandName,
                        ),
                      );
                    }
                  },
                  child: Card(
                    child: ListTile(
                      title: barlowBold(
                        text: Utils.filterYear[index],
                        size: 15,
                        color: black,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
