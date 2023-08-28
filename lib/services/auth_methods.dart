import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:krishivikas/Screens/account/check_zipcode_screen.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/screens/account/login_screen.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../language/language_key.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithGoogle(
    BuildContext context,
    int zip,
  ) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
//
      final GoogleSignInAuthentication googleAuth =
          await result!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
//
      if (result != null) {
        UserData.phoneNumber = "";

        // UserData.loginMethod = 2;

        UserData.email = result.email;
        SharedPreferencesFunctions().saveUserZipcode(zip);
        SharedPreferencesFunctions().saveGmailUserId(
          int.parse(
            result.id,
          ),
        );
        SharedPreferencesFunctions().saveUserEmail(result.email);
        SharedPreferencesFunctions().saveUserName(
          result.displayName.toString(),
        );

        SharedPreferencesFunctions().saveUserProfileImage(
          result.photoUrl.toString(),
        );

        gotoWithoutBack(
          context,
          CheckZipcodeScreen(int.parse(result.id)),
        );
        showSnackbar(context, welcomeTitle.tr);
      } else {
        showSnackbar(context, errorMessage.tr);
      }
    } catch (e) {
      showSnackbar(
        context,
        e.toString(),
      );
    }
  }

  ///Phone Logout
  Future logoutFromPhone() async {
    await FirebaseAuth.instance.signOut();
  }

  ///Gmail Logout
  Future logOutFromGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    UserData.email = "";
    UserData.phoneNumber = "";
  }

  ///Facebook SignOut
  Future<void> facebookSignOut() async {
    await FacebookAuth.instance.logOut();
    await _auth.signOut();

    UserData.email = "";
    UserData.phoneNumber = "";
  }

  Future getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser;
  }

  ///Facebook SignIn Method -To Login With Facebook Id And Password and Store Email,Name,Photo Into FireStore And SharedPrefrences.
  Future signInWithFaceBook(BuildContext context, int zip) async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]);
    if (loginResult.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();

      final facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      await FirebaseFirestore.instance.collection('users').add({
        'email': userData['email'],
        'imageUrl': userData['picture']['data']['url'],
        'name': userData['name'],
        'facebook_id': userData['id']
      });
      showSnackbar(context, "Facebook Login Sucesssfull");
      SharedPreferencesFunctions()
          .saveFacebookUserId(int.parse(userData['id']));
      SharedPreferencesFunctions().saveUserZipcode(zip);
      SharedPreferencesFunctions().saveUserEmail(userData['email']);
      SharedPreferencesFunctions().saveUserName(userData['name']);
      SharedPreferencesFunctions()
          .saveUserProfileImage(userData['picture']['data']['url']);

      gotoWithoutBack(
        context,
        CheckZipcodeScreen(int.parse(userData['id'])),
      );
    } else {
      gotoWithoutBack(
        context,
        LoginScreen(),
      );
      showSnackbar(
        context,
        errorMessage.tr,
      );
    }
  }
}
