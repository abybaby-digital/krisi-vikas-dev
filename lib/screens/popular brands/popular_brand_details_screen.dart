import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../const/colors.dart';
import '../notification/notification.dart';
import '../notification/notifications_screen.dart';
import '../../widgets/custom_header_button.dart';
import '../../widgets/custom_horizontal_product_list_widget.dart';
import 'widget/popular_brand_titles.widget.dart';

class PopularBrandDetailsScreen extends StatefulWidget {
  const PopularBrandDetailsScreen({Key? key}) : super(key: key);

  @override
  State<PopularBrandDetailsScreen> createState() =>
      _PopularBrandDetailsScreenState();
}

class _PopularBrandDetailsScreenState extends State<PopularBrandDetailsScreen> {
  get tabController => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: "TATA MOTORS",
          color: white,
          size: 20,
        ),
        actions: [
          IconButton(
            onPressed: () {
              goto(
                context,
                NotificationsPage(),
              );
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            AppImages.sliderImage1,
            width: fullWidth(context),
            height: fullHeight(context) * 0.18,
            fit: BoxFit.cover,
          ),
          PopularBrandTitlesWidget(),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: darkgreen,
                      width: fullWidth(context),
                      child: TabBar(
                        labelPadding: EdgeInsets.zero,
                        labelColor: lightgreen,
                        unselectedLabelColor: white,
                        indicatorColor: Colors.transparent,
                        isScrollable: false,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding: EdgeInsets.zero,
                        tabs: [
                          Tab(
                            text: "Tractor",
                          ),
                          Tab(
                            text: "Goods Vehicle",
                          ),
                          Tab(
                            text: "Harvester",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // VSpace(20),
                SizedBox(
                  height: fullHeight(context) * 0.50,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      CustomHorizontalProductListWidget(),
                      Text("Goods"),
                      Text("Harvester"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          CustomHeaderButton(
            icon: Icons.format_line_spacing_rounded,
            title: 'Sort',
          ),
          CustomHeaderButton(
            icon: Icons.filter_list_outlined,
            title: "Filter",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
