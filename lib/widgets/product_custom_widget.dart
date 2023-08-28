import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ProductCustomWidget extends StatelessWidget {
  final String? imageUrl;
  final String? count;
  final String? categoryName;

  const ProductCustomWidget({
    Key? key,
    this.imageUrl = "",
    this.count = "",
    this.categoryName = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSpace(
          15,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 15.0,
              ),
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                border: Border.all(
                  color: darkgreen,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(
                  imageUrl!,
                  height: fullWidth(context) * 0.20,
                  width: fullWidth(context) * 0.20,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  color: lightgreen,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: barlowBold(
                    text: count!,
                    size: 20,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
        VSpace(8),
        barlowBold(
          text: categoryName!,
          size: 20,
          color: black,
        )
      ],
    );
  }
}
