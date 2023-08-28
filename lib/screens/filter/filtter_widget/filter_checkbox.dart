import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/checkbox_widget.dart';
import '../../../models/filter_validation.dart';

// ignore: must_be_immutable
class FilterCheckBox extends StatefulWidget {
  final FilterValidation? checkBoxTitle;
  final Function(bool?)? onTap;
  bool? previous;

  FilterCheckBox({
    Key? key,
    this.checkBoxTitle,
    this.onTap,
  }) : super(key: key);

  @override
  State<FilterCheckBox> createState() => _FilterCheckBoxState();
}

class _FilterCheckBoxState extends State<FilterCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckBoxWidget(
      value: this.widget.checkBoxTitle?.isCheck,
      checkBoxTitle: widget.checkBoxTitle!.title,
      onCheckBoxUpdate: widget.onTap,
    );
  }
}
