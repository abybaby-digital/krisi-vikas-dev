// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'all_widgets.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool? value;
  final String? checkBoxTitle;
  final Function(bool?)? onCheckBoxUpdate;

  CheckBoxWidget({
    Key? key,
    this.value = false,
    this.checkBoxTitle = "",
    this.onCheckBoxUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onCheckBoxUpdate,
      contentPadding: EdgeInsets.only(left: 8),
      title: barlowRegular(
        text: checkBoxTitle!,
        size: 12,
        color: black,
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: lightgreen,
      checkColor: white,
      side: MaterialStateBorderSide.resolveWith(
        (states) => BorderSide(
          width: 2.0,
          color: lightgreen,
        ),
      ),
    );
  }
}
