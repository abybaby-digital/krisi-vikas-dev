import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ViewAllWidget extends StatelessWidget {
  final String? buttonTitle;
  final Function()? onTap;

  const ViewAllWidget({
    Key? key,
    this.onTap,
    this.buttonTitle = "View All",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 2,
        ),
        child: Container(
          width: (viewAll.tr.length > 8) ? 70 : 50,
          height: 20,
          decoration: BoxDecoration(
            color: darkgreen,
            borderRadius: BorderRadius.circular(
              2,
            ),
          ),
          child: Center(
            child: barlowRegular(
              text: buttonTitle!,
              color: white,
              size: 12,
            ),
          ),
        ),
      ),
    );
  }
}
