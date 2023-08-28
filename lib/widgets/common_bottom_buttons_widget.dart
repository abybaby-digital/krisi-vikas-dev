import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class CommonBottomButtonsWidget extends StatelessWidget {
  final String? bottomButtonTitle1;
  final String? bottomButtonTitle2;
  final Function()? onTap1;
  final Function()? onTap2;

  const CommonBottomButtonsWidget({
    Key? key,
    this.bottomButtonTitle1 = "",
    this.bottomButtonTitle2 = "",
    this.onTap1,
    this.onTap2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onTap1,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: lightgreen,
              ),
              child: Center(
                child: barlowRegular(
                  text: bottomButtonTitle1!,
                  color: white,
                  size: 17,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: onTap2,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: darkgreen,
              ),
              child: Center(
                  child: IsPressedFilterButton
                      ? Center(
                          child: progressIndicator(context),
                        )
                      : barlowRegular(
                          text: bottomButtonTitle2!,
                          color: white,
                          size: 17,
                        )),
            ),
          ),
        ),
      ],
    );
  }
}
