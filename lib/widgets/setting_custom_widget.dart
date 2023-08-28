import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class SettingCustomWidget extends StatelessWidget {
  final String? title;

  final bool isSwitch;

  final Function(bool?)? onTap;

  final String? message;

  final String? settingIcon;

  SettingCustomWidget({
    Key? key,
    this.title = "",
    this.isSwitch = false,
    this.onTap,
    this.message = "",
    this.settingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: fullHeight(context) * 0.08,
      decoration: BoxDecoration(
        border: Border.all(
          color: grey,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              HSpace(20),
              Image.asset(
                settingIcon!,
                width: 25,
                height: 25,
              ),
              HSpace(20),
              barlowSemiBold(
                text: title!,
                size: 17,
                color: grey,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: Row(
              children: [
                Switch(
                  activeColor: darkgreen,
                  inactiveTrackColor: darkgreen,
                  value: isSwitch,
                  onChanged: onTap,
                ),
                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  preferBelow: false,
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                  ),
                  message: message!,
                  child: Icon(
                    Icons.info_outline_rounded,
                    color: darkgreen,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
