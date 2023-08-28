import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import '../../../widgets/all_widgets.dart';

class PopularBrandTitlesWidget extends StatelessWidget {
  const PopularBrandTitlesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                AppImages.infoIcon,
                width: 30,
                height: 30,
              ),
              HSpace(10),
              barlowBold(
                text: "Tata Motors",
                color: darkgreen,
                size: 20,
              ),
            ],
          ),
          VSpace(10),
          barlowThin(
            text:
                "Tata Motors Limited, a USD 34 billion organisation,is a leading global automobile manufature with a portfoli that covers a wide range of cars,SUVs,buses,trucks,pickups and defence vehicles.",
            color: darkgreen,
            size: 10,
          ),
        ],
      ),
    );
  }
}
