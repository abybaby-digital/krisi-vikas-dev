import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class CustomHeaderButton extends StatelessWidget {
  final IconData? icon;

  final String? title;

  final Function()? onTap;

  const CustomHeaderButton({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth(context) * 0.50,
        height: fullHeight(context) * 0.05,
        decoration: BoxDecoration(
          color: lightgreen,
          border: Border(
            right: BorderSide(
              color: black,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: white,
            ),
            SizedBox(
              width: 10,
            ),
            barlowBold(
              text: title!,
              color: white,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
