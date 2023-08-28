import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Screens/account/login_screen.dart';
import '../../services/save_user_info.dart';

class DisableScreen extends StatefulWidget {
  const DisableScreen({Key? key}) : super(key: key);

  @override
  State<DisableScreen> createState() => _DisableScreenState();
}

class _DisableScreenState extends State<DisableScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Disable"),
        centerTitle: true,
        backgroundColor: darkgreen,
        actions: [
          IconButton(
            onPressed: () async {
              var telUrl =  Uri.parse('tel:8100975657');
              if (await canLaunchUrl(telUrl)) {
                await launchUrl(telUrl,mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $telUrl';
              }
            },
            icon: Icon(
              Icons.call,
              color: white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("If you choose to disable your account, please be aware that it will remain deactivated until further action is taken. Once your account is disabled, you will no longer have access to its features and functionalities."),
              SizedBox(height: 15,),
              Text("Disabling your account can be a temporary measure if you wish to take a break or step away from using Krishi Vikas. It provides you with the option to reactivate your account at a later time when you are ready to resume using our services."),
              SizedBox(height: 15,),
              Text("However, it's important to note that if your account remains disabled for an extended period, typically 90 days or more, our system may automatically initiate the permanent deletion process. This is done to maintain the security and efficiency of our platform, as inactive accounts can pose potential risks."),
              SizedBox(height: 15,),
              Text("If you wish to prevent permanent deletion, it is advisable to log in to your disabled account within the specified timeframe or reach out to our support team for assistance. They can guide you on the necessary steps to reactivate your account or provide further clarification regarding the process."),
              SizedBox(height: 15,),
              Text("We understand that circumstances may arise that lead users to disable their accounts, and we respect your decision. Should you have any questions or concerns about account deactivation or reactivation, please don't hesitate to contact us. We are here to help and ensure a smooth experience for our users."),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: ()async{
                    print('${UserData.phoneNumber}');
                    await ApiMethods().UserEnable('${UserData.phoneNumber}', baseUrl+user_enable).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("Welcome Back to Krishi Vikas. Kindly Login Again"),
                          backgroundColor: darkgreen,
                        ),
                      );
                      FirebaseAuth.instance.signOut().then((value) {
                        gotoWithoutBack(context, LoginScreen(),);
                      });
                    });
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkgreen,
                ),
                  child: Text("Enable Account"),
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().then((value) {
                      gotoWithoutBack(context, LoginScreen());
                    });
                  },
                  child: Text("Back to Login Screen"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkgreen,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
