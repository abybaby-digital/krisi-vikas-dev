import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/other_screens/select_addons_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/screens/notification/notifications_screen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../notification/notification.dart';

class SelectPackageScreen extends StatelessWidget {
  const SelectPackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 140,
            width: double.infinity,
            color: Colors.green.shade300,
            child: Column(
              children: const [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Select a Package",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Post more ads & ads get boosted to the top every few days\nPackages are valid for 30 days\nReach upto 3 times more buyers",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          buildPackage(
            "Package Name - 1",
            "10 Ad Posts",
            "5 times more leads",
            "INR 2999",
            context,
          ),
          const SizedBox(
            height: 15,
          ),
          buildPackage(
            "Package Name - 2",
            "5 Ad Posts",
            "3 times more leads",
            "INR 1999",
            context,
          ),
          const SizedBox(
            height: 15,
          ),
          buildPackage(
            "Package Name - 3",
            "3 Ad Posts",
            "2 times more leads",
            "INR 999",
            context,
          )
        ],
      ),
    );
  }

  buildPackage(
      String package, String adPost, String leads, String price, context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectAddonsScreen(),
          ),
        );
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    package,
                    style: const TextStyle(
                      fontSize: 20,
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
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                        ),
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
          ),
        ],
      ),
    );
  }
}
