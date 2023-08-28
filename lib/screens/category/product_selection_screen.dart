import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/select_category_screen.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../rent/rent_category_screen.dart';

class ProductSelectionScreen extends StatefulWidget {
  const ProductSelectionScreen({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<ProductSelectionScreen> createState() => _ProductSelectionScreenState();
}

class _ProductSelectionScreenState extends State<ProductSelectionScreen> {
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
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 60,
            width: double.infinity,
            color: greenShade300,
            child: barlowBold(
              text: whatWouldYouLikeToDo.tr,
              size: 20,
              color: white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(
              18.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectCategoryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: fullWidth(context) * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.3),
                          blurRadius: 3,
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppImages.buyIcon,
                            width: fullWidth(context) * 0.30,
                            height: fullWidth(context) * 0.20,
                          ),
                          VSpace(10),
                          barlowBold(
                            text: sell.tr,
                            size: 20,
                            color: black,
                          ),
                          const SizedBox(
                            height: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RentCategoryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: fullWidth(context) * 0.40,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey.withOpacity(0.3),
                          blurRadius: 3,
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            AppImages.rentIcon,
                            width: fullWidth(context) * 0.30,
                            height: fullWidth(context) * 0.20,
                          ),
                          VSpace(10),
                          barlowBold(
                            text: rent.tr,
                            size: 20,
                            color: black,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
