import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class FilterTitleWidget extends StatelessWidget {
  final String? filterTitle;
  final bool isSelected;
  final Function()? onTap;
  final int? index;
  final List? selectIndex;
  final Color? colorSelect;
  final ValueChanged<bool> onValueChanged;

  FilterTitleWidget({
    Key? key,
    this.filterTitle = "",
    this.isSelected = false,
    this.index,
    this.selectIndex,
    this.colorSelect,
    @Deprecated('Use onValueChanged') this.onTap,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      width: MediaQuery.of(context).size.width * 0.50,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onValueChanged(!isSelected);
            },
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.05,
              color: colorSelect,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 12.0,
                ),
                child: barlowRegular(
                  text: filterTitle!,
                  size: 12,
                  color: black,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
