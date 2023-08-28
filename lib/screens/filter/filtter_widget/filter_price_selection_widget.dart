import 'package:flutter/material.dart';
import '../../../const/colors.dart';

class FilterPriceSelectionWidget extends StatefulWidget {
  const FilterPriceSelectionWidget(Object object, {Key? key}) : super(key: key);

  @override
  State<FilterPriceSelectionWidget> createState() =>
      _FilterPriceSelectionWidgetState();
}

class _FilterPriceSelectionWidgetState
    extends State<FilterPriceSelectionWidget> {
  RangeValues currentPriceValues = const RangeValues(0, 5000000);
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      min: 0,
      max: 5000000,
      divisions: 10,
      activeColor: darkgreen,
      labels: RangeLabels(
        currentPriceValues.start.round().toString(),
        currentPriceValues.end.round().toString(),
      ),
      onChanged: (RangeValues? rangeValues) {
        setState(
          () {
            currentPriceValues = rangeValues!;
          },
        );
      },
      values: currentPriceValues,
    );
  }
}
