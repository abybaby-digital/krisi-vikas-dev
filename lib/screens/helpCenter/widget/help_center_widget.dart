import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class CustomExpansionWidget extends StatelessWidget {
  final String? title;
  final Function()? onTap;

  CustomExpansionWidget({
    Key? key,
    this.title = "",
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: fullWidth(context),
          height: fullHeight(context) * 0.07,
          decoration: BoxDecoration(
            border: Border.all(
              color: grey,
              width: 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                barlowSemiBold(
                  text: title!,
                  color: grey,
                  size: 15,
                ),
                (title == "LogOut")
                    ? SizedBox.shrink()
                    : Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: grey,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
