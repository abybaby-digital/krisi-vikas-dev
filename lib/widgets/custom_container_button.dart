import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class CustomContainerButton extends StatelessWidget {
  final String? title;
  final Function()? onTap;
  
  CustomContainerButton({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth(context) * 0.30,
        height: fullHeight(context) * 0.05,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Center(
          child: barlowBold(
            text: title!,
            color: darkgreen,
            size: 15,
          ),
        ),
      ),
    );
  }
}



class CustomContainerButton2 extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  CustomContainerButton2({
    Key? key,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: fullWidth(context) * 0.30,
        height: fullHeight(context) * 0.05,
        decoration: BoxDecoration(
          color: darkgreen,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Center(
          child: barlowBold(
            text: title!,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
    );
  }
}
