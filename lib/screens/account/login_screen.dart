import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/account/check_zipcode_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/auth_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool codeSent = false;

  bool showLoginCPI = false;

  bool isLogin = false;

  String otpMsg = "";

  String phoneNumber = "";

  String verificationCode = "";

  TextEditingController phoneNumberController = new TextEditingController();

  String? deviceTokenId;

  FocusNode focusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController pinPutController = new TextEditingController();

  FocusNode pinPutFocusNode = new FocusNode();

  bool showOtpCPI = false;

  int zip = 000000;

  @override
  void initState() {
    super.initState();
    doThisOnLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: codeSent ? OtpWidget() : LoginWidget(),
        ),
      ),
    );
  }

  Widget LoginWidget() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 21,
                top: 100,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barlowBold(
                    text: signUpOrLogin.tr,
                    size: 22,
                    color: black,
                  )
                ],
              ),
            ),
            VSpace(10),
            Padding(
              padding: EdgeInsets.only(
                left: 21,
              ),
              child: barlowRegular(
                text: confirmationCodeSent.tr,
                size: 17,
                color: black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 21,
                right: 15,
                top: 35,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 4,
                    ),
                    child: barlowBold(
                      text: "+91",
                      color: black,
                      size: 23,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: phoneNumberController,
                      focusNode: focusNode,
                      onChanged: (value) {
                        phoneNumber = value;
                        if (value.length == 10) {
                          focusNode.unfocus();
                        }
                        setState(() {});
                      },
                      validator: MultiValidator(
                        [
                          MinLengthValidator(
                            10,
                            errorText: tenDigitPhoneNo.tr,
                          ),
                          RequiredValidator(
                            errorText: requiredFields.tr,
                          ),
                        ],
                      ),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 23,
                        fontStyle: FontStyle.normal,
                        fontFamily: "Barlow",
                        fontWeight: FontWeight.bold,
                        color: grey,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        hintText: "999-999-9999",
                        hintStyle: TextStyle(
                          fontSize: 23,
                          fontStyle: FontStyle.normal,
                          fontFamily: "Barlow",
                          fontWeight: FontWeight.bold,
                          color: greyShade400,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            showLoginCPI
                ? Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        height: 45,
                        width: fullWidth(context) * 0.90,
                        decoration: BoxDecoration(
                          color: darkgreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: white,
                          ),
                        ),
                      ),

                      // child: ElevatedButton(
                      //   style: ButtonStyle(
                      //     fixedSize: MaterialStateProperty.all(
                      //       Size(
                      //         fullWidth(context) * 0.90,
                      //         45,
                      //       ),
                      //     ),
                      //     backgroundColor: MaterialStateProperty.all(
                      //       darkgreen,
                      //     ),
                      //   ),
                      //   label: CircularProgressIndicator(
                      //     color: white,
                      //   ),
                      //   icon: Icon(
                      //     (Platform.isAndroid)
                      //         ? Icons.arrow_back
                      //         : Icons.arrow_back_ios_new_rounded,
                      //   ),
                      //   onPressed: () {}, child: null,
                      // ),
                    ),

                    // Center(
                    //     child: CircularProgressIndicator(
                    //       color: white,
                    //     ),
                    //   ),
                  )
                : Center(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              showLoginCPI = true;
                            });
                            UserData.phoneNumber = phoneNumber;
                            UserData.email = "";
                            UserData.loginMethod = 1;
                            SharedPreferencesFunctions()
                                .saveUserPhoneNumber(phoneNumber);
                            SharedPreferencesFunctions().saveUserZipcode(zip);

                            verifyPhoneNumber();
                            await Future.delayed(Duration(seconds: 8), () {
                              print("saveUserPhoneNumber");
                              if (mounted) {
                                setState(
                                  () {
                                    codeSent = true;
                                    decT();
                                  },
                                );
                              }
                            });
                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(
                              fullWidth(context) * 0.90,
                              45,
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            darkgreen,
                          ),
                        ),
                        label: barlowBold(
                          text: continues.tr,
                          size: 17,
                          color: white,
                        ),
                        icon: Icon(
                          (Platform.isAndroid)
                              ? Icons.arrow_back
                              : Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Center(
                child: barlowMedium(
                  text: termsPolicy.tr,
                  size: 13,
                  color: grey,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 35,
            // ),
            // Center(
            //   child: barlowBold(
            //     text: connectUsing.tr,
            //     color: grey,
            //     size: 16,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         // UserData.loginMethod = 3;
            //         setState(() {
            //           isLogin = true;
            //         });
            //         AuthMethods().signInWithFaceBook(
            //           context,
            //           zip,
            //         );
            //       },
            //       child: (isLogin == false)
            //           ? Container(
            //               height: 40,
            //               width: fullWidth(context) * 0.31,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(8),
            //                 color: blueShade700,
            //               ),
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Icon(
            //                     Icons.facebook_outlined,
            //                     color: white,
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(8.0),
            //                     child: barlowBold(
            //                       text: facebookLogin.tr,
            //                       size: 15,
            //                       color: white,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             )
            //           : progressIndicator(context),
            //     ),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     InkWell(
            //       onTap: () {
            //         // UserData.loginMethod = 2;
            //         AuthMethods().signInWithGoogle(
            //           context,
            //           zip,
            //         );
            //       },
            //       child: Container(
            //         height: 40,
            //         width: fullWidth(context) * 0.31,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(8),
            //           color: red,
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(
            //               Icons.g_mobiledata,
            //               color: white,
            //             ),
            //             Padding(
            //               padding: EdgeInsets.all(8.0),
            //               child: barlowBold(
            //                 text: googleLogin.tr,
            //                 size: 15,
            //                 color: white,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  doThisOnLaunch() async {
    Position position = await ApiMethods().getGeoLocationPosition();
    double lat = position.latitude;
    double long = position.longitude;
    List<Placemark> placemarks = await placemarkFromCoordinates(
      lat,
      long,
    );
    zip = int.parse(
      placemarks[0].postalCode ?? "000000",
    );
  }

  Future<void> verifyPhoneNumber() async {
    focusNode.unfocus();
    // setState(
    //   () {
    //     showLoginCPI = true;
    //   },
    // );

    await auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        UserCredential result = await auth.signInWithCredential(
          phoneAuthCredential,
        );
        otpMsg = phoneAuthCredential.smsCode!;
        // ignore: unused_local_variable
        User? user = result.user;

        // ignore: unnecessary_null_comparison
        if (result != null) {
          gotoWithoutBack(
            context,
            CheckZipcodeScreen(1),
          );
          showSnackbar(
            context,
            welcomeTitle.tr,
          );
        } else {
          setState(
            () {
              showLoginCPI = false;
            },
          );
          showSnackbar(
            context,
            errorMessage.tr,
          );
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        showSnackbar(
          context,
          e.message.toString(),
        );

        setState(
          () {
            showLoginCPI = false;
          },
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationCode = verificationId;

        // codeSent = true;
        showLoginCPI = false;

        setState(() {});
      },
      codeAutoRetrievalTimeout: (String? verificationId) {
        verificationCode = verificationId!;
      },
      timeout: Duration(seconds: 60),
    );
  }

  Future<void> verifyPin(String pin) async {
    setState(
      () {
        showOtpCPI = true;
      },
    );
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationCode,
      smsCode: pin,
    );

    try {
      UserCredential result = await auth.signInWithCredential(credential);
      // ignore: unused_local_variable
      User? user = result.user;
      // ignore: unnecessary_null_comparison
      if (result != null) {
        gotoWithoutBack(
          context,
          CheckZipcodeScreen(1),
        );
        showSnackbar(
          context,
          welcomeTitle.tr,
        );
      } else {
        setState(() {
          showLoginCPI = false;
        });
        showSnackbar(
          context,
          errorMessage.tr,
        );
      }
    } on FirebaseException catch (e) {
      setState(() {
        showOtpCPI = false;
      });
      showSnackbar(
        context,
        e.message.toString(),
      );
    }
  }

  int t = 60;
  decT() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (this.mounted) {
        setState(() {
          if (t > 0) {
            t -= 1;
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  Widget OtpWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100),
          barlowBold(
            text: enterOtp.tr,
            size: 28,
            color: black,
          ),
          VSpace(10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: otpSent.tr,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Barlow",
                    fontStyle: FontStyle.normal,
                    color: black,
                  ),
                ),
                TextSpan(
                  text: phoneNumber,
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Barlow",
                    fontStyle: FontStyle.normal,
                    color: blue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          PinPut(
            fieldsCount: 6,
            focusNode: pinPutFocusNode,
            controller: pinPutController,
            submittedFieldDecoration: boxDecoration(2, 5),
            selectedFieldDecoration: boxDecoration(2, 5),
            followingFieldDecoration: boxDecoration(1, 5),
            textStyle: TextStyle(
              fontSize: 20,
              fontFamily: "Barlow",
              fontStyle: FontStyle.normal,
            ),
            pinAnimationType: PinAnimationType.scale,
            eachFieldHeight: 43,
          ),
          VSpace(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              barlowRegular(
                text: notRecieveOtp.tr,
                size: 15,
                color: black,
              ),
              (t == 0)
                  ? InkWell(
                      onTap: () {
                        if (t == 0) {
                          setState(() {
                            t = 60;
                            decT();
                          });

                          verifyPhoneNumber();
                        }
                      },
                      child: barlowBold(
                        text: resendOtp.tr,
                        size: 18,
                        color: blue,
                      ))
                  : SizedBox(),
              barlowRegular(
                text: inValue.tr + " " + t.toString() + " " + secondValue.tr,
                size: 15,
                color: black,
              )
            ],
          ),
          SizedBox(height: 50),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(darkgreen),
              fixedSize: MaterialStateProperty.all(
                Size(
                  fullWidth(context),
                  45,
                ),
              ),
            ),
            onPressed: () {
              verifyPin(pinPutController.text);
            },
            child: showOtpCPI
                ? CircularProgressIndicator(
                    color: white,
                  )
                : barlowBold(
                    text: verifyOtp.tr,
                    size: 20,
                    color: white,
                  ),
          ),
        ],
      ),
    );
  }
}
