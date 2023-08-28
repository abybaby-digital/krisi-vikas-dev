import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../notification/notification.dart';

class MakePaymentScreen extends StatelessWidget {
  
  const MakePaymentScreen({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Make Payment",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 14,
              left: 14,
              right: 14,
              bottom: 7,
            ),
            child: Container(
                height: 90,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "Total Payable Amount",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View summary",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      "₹3500",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 14,
              right: 14,
            ),
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "Redeem your Discount Voucher",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 35,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Coupon Code",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Redeem",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.green,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              left: 14,
              right: 14,
            ),
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: ListTile(
                leading: const Icon(Icons.person),
                title: const Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Text(
                    "Add a Refferal Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 35,
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Refferal Code",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Apply",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.green,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 14,
              top: 15,
            ),
            child: Text(
              "Select payment method",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 4,
                  )
                ],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  buildPaymentMethod(
                    Icons.credit_card,
                    Colors.orange,
                    "Debit / Credit card",
                    "Visa, Mastercard, Maestro & more",
                    Icons.arrow_forward_ios,
                  ),
                  buildPaymentMethod(
                    Icons.card_giftcard,
                    Colors.red,
                    "EMI",
                    "No cost EMI - Debit & Credit cards",
                    Icons.arrow_forward_ios,
                  ),
                  buildPaymentMethod(
                    Icons.house_outlined,
                    Colors.orange,
                    "Net Banking",
                    "All Indians banks",
                    Icons.arrow_forward_ios,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentMethod(
    IconData leading,
    Color iconColor,
    String title,
    String subtitle,
    IconData trailing,
  ) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          leading,
          size: 30,
          color: iconColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
        ),
        trailing: Icon(
          trailing,
        ),
      ),
    );
  }
}
