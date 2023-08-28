import 'package:intl/intl.dart';

class AppFonts {
  ///Barlow Fonts
  static const barlowRegular = "assets/fonts/Barlow-Regular.ttf";
  static const barlowBold = "assets/fonts/Barlow-Bold.ttf";
  static const barlowLight = "assets/fonts/Barlow-Light.ttf";
  static const barlowBlack = "assets/fonts/Barlow-Black.ttf";
  static const barlowMedium = "assets/fonts/Barlow-Medium.ttf";
  static const barlowExtraLight = "assets/fonts/Barlow-ExtraLight.ttf";
  static const barlowThin = "assets/fonts/Barlow-Thin.ttf";
  static const barlowSemiBold = "assets/fonts/Barlow-SemiBold.ttf";

  ///Yeseva One Fonts
  static const yesevaOneRegular =
      "assets/fonts/yeseva_one/YesevaOne-Regular.ttf";

  ///Dateformatter Variable
  static var newDate;

  ///Date Formatter
  static dateFormatChanged(date) {
    // var d = date.split("")[0].toString();
    // newDate = DateFormat("dd-MM-yyyy").format(
    //   DateTime.parse(
    //     date,
    //   ),
    // );
    newDate = date;
  }
}
