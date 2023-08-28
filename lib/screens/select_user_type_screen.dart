import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/enter_details_screen.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:selectable_container/selectable_container.dart';
import 'notification/notifications_screen.dart';

class SelectUserType extends StatefulWidget {
  final String? where;
  SelectUserType(this.where);

  @override
  State<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends State<SelectUserType> {
  bool dealer = false;

  bool individual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: appTitle.tr,
          color: white,
          size: 20,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     goto(
          //       context,
          //       NotificationsScreen(),
          //     );
          //   },
          //   icon: Icon(
          //     Icons.notifications,
          //     color: white,
          //   ),
          // )
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            width: double.infinity,
            color: greenShade300,
            child: barlowBold(
              text: whoAreYou.tr,
              color: white,
              size: 23,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SelectableContainer(
                unselectedBorderColor: Colors.transparent,
                selectedBorderColor: darkgreen,
                selected: dealer,
                onValueChanged: (value) {
                  setState(
                    () {
                      dealer = value;
                      individual = false;
                    },
                  );
                },
                child: Container(
                  height: fullWidth(context) * 0.36,
                  width: fullWidth(context) * 0.36,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: grey,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        AppImages.dealer,
                        height: fullWidth(context) * 0.18,
                        width: fullWidth(context) * 0.18,
                      ),
                      barlowBold(
                        text: dealerValue.tr,
                        color: black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
              SelectableContainer(
                unselectedBorderColor: Colors.transparent,
                selectedBorderColor: darkgreen,
                selected: individual,
                onValueChanged: (value) {
                  setState(
                    () {
                      individual = value;
                      dealer = false;
                    },
                  );
                },
                child: Container(
                  height: fullWidth(context) * 0.36,
                  width: fullWidth(context) * 0.36,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: grey,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        AppImages.individual,
                        height: fullWidth(context) * 0.18,
                        width: fullWidth(context) * 0.18,
                      ),
                      barlowBold(
                        text: individualValue.tr,
                        color: black,
                        size: 24,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  darkgreen,
                ),
                fixedSize: MaterialStateProperty.all(
                  Size(
                    fullWidth(context),
                    45,
                  ),
                ),
              ),
              onPressed: () {
                if (individual || dealer) {
                  int userTypeId = individual ? 1 : 2;
                  gotoWithoutBack(
                    context,
                    EnterUserDetails(userTypeId, widget.where),
                  );
                } else {
                  showSnackbar(
                    context,
                    selectUserType.tr,
                  );
                }
              },
              child: barlowBold(
                text: next.tr,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
