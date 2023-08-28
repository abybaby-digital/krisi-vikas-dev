import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/popular%20brands/new_brands_list.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/fonts.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/popular%20brands/popular_brand_details_screen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/view_all_widget.dart';

class PopularBrands extends StatelessWidget {
  const PopularBrands({Key? key}) : super(key: key);

  get tabController => null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        popularBrand.tr,
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontFamily: AppFonts.barlowBold,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ViewAllWidget(
                        buttonTitle: viewAll.tr,
                        onTap: () {
                          // goto(context, ViewAllBrandsList());
                          goto(
                            context,
                            PopularBrandDetailsScreen(),
                          );
                        },
                      )
                    ],
                  ),
                ),
                NewBrandsList()

                // DefaultTabController(

                //    length: 2,
                //    child: Column(
                //      children: [
                //        Row(
                //          children: [

                //            SizedBox(
                //              width: width * 0.62,
                //              child: const TabBar(
                //                labelPadding: EdgeInsets.zero,
                //                labelColor: Colors.blueGrey,
                //                indicatorColor: Colors.blueGrey,
                //                isScrollable: false,
                //                indicatorSize: TabBarIndicatorSize.label,

                //                tabs: [
                //                Tab(text: "New Tractor",),
                //                Tab(text: "Used Tractor",),

                //              ]),
                //            ),

                //          ],
                //        ),

                //        SizedBox(
                //          height: height * 0.40,
                //          child: TabBarView(
                //           controller: tabController,
                //            children:  [
                //            NewBrandsList(),
                //            UsedBrandsList()
                //          ]),
                //        ),

                //      ],
                //    )
                //  ),
              ],
            ),
          )),
    );
  }
}
