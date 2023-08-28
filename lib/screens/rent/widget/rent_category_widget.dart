import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class RentCategoryWidget extends StatelessWidget {
  final String? rentCategoryText;
  final String? rentCategoryImage;
  final Function()? onTap;

  RentCategoryWidget({
    Key? key,
    this.rentCategoryImage,
    this.rentCategoryText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth(context) * 0.42,
        height: fullHeight(context) * 0.18,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 3,
            )
          ],
          color: white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                rentCategoryImage!,
                width: fullWidth(context) * 0.25,
                height: fullWidth(context) * 0.25,
              ),
            ),
            FittedBox(
              child: barlowBold(
                text: rentCategoryText!,
                size: 16,
                color: black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
