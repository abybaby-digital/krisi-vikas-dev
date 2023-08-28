import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/other_screens/make_payment_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../notification/notification.dart';
import '../notification/notifications_screen.dart';

class SelectAddonsScreen extends StatelessWidget {
  const SelectAddonsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text("Krishi Vikas"),
        actions: [
          IconButton(
            onPressed: () {
              goto(
                context,
                NotificationsPage(),
              );
            },
            icon: const Icon(
              Icons.notifications,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 70,
            width: double.infinity,
            color: Colors.green.shade300,
            child: const Text(
              "Select Addons",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          buildAddon("Featured Post", "1 Ad Posts", "5 times more leads",
              "INR 599", context),
          const SizedBox(
            height: 15,
          ),
          buildAddon("Extra Validity", "1 Ad Posts", "3 times more leads",
              "INR 399", context),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: width * 0.48,
                  color: kPrimaryColor,
                  alignment: Alignment.center,
                  child: const Text(
                    "Rs.3500",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MakePaymentScreen(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: width * 0.48,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildAddon(
      String package, String adPost, String leads, String price, context) {
    return InkWell(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectAddonsScreen()));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            child: Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    package,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Text(
                          adPost,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        leads,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                trailing: const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    "Valid for 30 days",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 5,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 50,
              width: 130,
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
