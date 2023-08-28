import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/filter/filtter_widget/filter_checkbox.dart';
import 'package:krishivikas/const/utils.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../../models/filter_validation.dart';

// ignore: must_be_immutable
class FilterMenuItemWidget extends StatefulWidget {
  List<FilterValidation> filterType;
  String filterMenu;
  FilterMenuItemWidget(this.filterType, this.filterMenu);

  @override
  State<FilterMenuItemWidget> createState() => FilterMenuItemWidgetState();
}

class FilterMenuItemWidgetState extends State<FilterMenuItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.filterType.isNotEmpty)
        ? commonCheckBoxList(
            context,
            widget.filterType,
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: progressIndicator(context),
            ),
          );
  }

  Widget commonCheckBoxList(
      BuildContext context, List<FilterValidation> filterType) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return FilterCheckBox(
              checkBoxTitle: filterType[index],
              onTap: (value) {
                (widget.filterMenu == "Brand" || widget.filterMenu == "Model")
                    ? setState(
                        () {
                          filterType[index].isCheck = value ?? false;
                          if (widget.filterMenu == "Brand") {
                            if (Utils.selectionBrand
                                .contains(filterType[index].id)) {
                              Utils.selectionBrand.remove(filterType[index].id);
                            } else {
                              Utils.selectionBrand.add(filterType[index].id);
                            }
                          } else {
                            if (Utils.selectionModel
                                .contains(filterType[index].id)) {
                              Utils.selectionModel.remove(filterType[index].id);
                            } else {
                              Utils.selectionModel.add(filterType[index].id);
                            }
                          }
                        },
                      )
                    : setState(
                        () {
                          // filterType.forEach((element) {
                          //   element.isCheck = false;
                          // });
                          filterType[index].isCheck = value ?? false;

                          if (widget.filterMenu == "District") {
                            SharedPreferencesFunctions()
                                .saveDistrictId(filterType[index].id);
                          }

                          // if (widget.filterMenu == "State") {
                          //   SharedPreferencesFunctions()
                          //       .saveFilterStateId(filterType[index].id);
                          // } else if (widget.filterMenu == "District") {
                          //   SharedPreferencesFunctions()
                          //       .saveDistrictId(filterType[index].id);
                          // }
                        },
                      );
              },
            );
          },
          itemCount: filterType.length,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
