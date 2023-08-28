import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/notification/notifications_screen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../notification/notification.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: barlowBold(
            text: appTitle.tr,
            color: white,
            size: 20,
          ),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 140,
              width: width,
              color: Colors.green.shade300,
              child: Column(
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Post more Ads & Auto Boost",
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    children: [
                      buildTopAd(
                        "100 Ads",
                        "4,499",
                      ),
                      buildTopAd(
                        "50 Ads",
                        "2,799",
                      ),
                      buildTopAd(
                        "10 Ads",
                        "1,199",
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Feature Ad",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.check,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Get noticed with 'FEATURED' tag in a top position",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.check,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Package available for 30 days",
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Feature Ads for 30 Days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.check,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Reach up to 10 times more buyers",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildTopAd(
                            "10 Ads",
                            "1,799",
                          ),
                          buildTopAd(
                            "6 Ads",
                            "999",
                          ),
                          buildTopAd(
                            "3 Ads",
                            "599",
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Feature Ads for 7 Days",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.check,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Reach up to 4 times more buyers",
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildTopAd(
                            "10 Ads",
                            "1,399",
                          ),
                          buildTopAd(
                            "6 Ads",
                            "599",
                          ),
                          buildTopAd(
                            "3 Ads",
                            "299",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopAd(String ads, String price) {
    bool valu = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 135,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                    value: valu,
                    onChanged: (va) {
                      setState(() {
                        valu = va!;
                      });
                    }),
                Text(
                  ads,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 1.5,
            ),
            const Spacer(),
            Text(
              "₹ $price",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
