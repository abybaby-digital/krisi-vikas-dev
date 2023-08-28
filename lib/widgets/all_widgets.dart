import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:krishivikas/Screens/other_screens/image_to_full_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/screens/other_screens/image_to_full_screen_slider.dart';

///BoxDecoration With BorderWidth And BorderRadius
BoxDecoration boxDecoration(double borderWidth, double borderRadius) {
  return BoxDecoration(
    border: Border.all(width: borderWidth),
    borderRadius: BorderRadius.circular(borderRadius),
  );
}

OutlineInputBorder customOutlineBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Colors.grey.shade400,
      width: 1.5,
    ),
  );
}

///Barlow-Regular
Widget barlowRegular({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Regular
Widget barlowRegularForHome({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Bold Style
Widget barlowBold({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Barlow",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Bold Style
Widget barlowBoldForHome({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: maxLine,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Barlow",
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Thin Style
Widget barlowThin({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    maxLines: 20,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: "Barlow",
      fontWeight: FontWeight.w100,
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Extra Light Style
Widget barlowExtraLight({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    maxLines: 1,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w200,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow- Light Style
Widget barlowLight({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w300,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Yeseva One Style
Widget yesevaOneRegular({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    maxLines: 1,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
      fontFamily: "YesevaOne",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Medium Style
Widget barlowMedium({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    // maxLines: 1,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Black Style
Widget barlowBlack({
  String text = "",
  double size = 10,
  Color? color,
}) {
  return Text(
    text,
    maxLines: 1,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w900,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Semi Bold Style
Widget barlowSemiBold({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    maxLines: maxLine,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Barlow-Semi Bold Style
Widget barlowSemiBoldForSubCat({
  String text = "",
  double size = 10,
  Color? color,
  int? maxLine,
}) {
  return Text(
    text,
    maxLines: maxLine,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w600,
      fontFamily: "Barlow",
      fontStyle: FontStyle.normal,
    ),
  );
}

///Navigate Push
goto(BuildContext context, Widget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
  );
}

///Navigate Without Back
gotoWithoutBack(
  BuildContext context,
  Widget nextScreen,
) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => nextScreen,
    ),
  );
}

///Navigate Untill Remove
gotoUtillBack(
  BuildContext context,
  Widget nextScreen,
) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
      (route) => false);
}

///Pop Navigate
goBack(BuildContext context) {
  Navigator.of(context).pop();
}

///SnackBar
showSnackbar(
  BuildContext context,
  String content,
) {
  print(content);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: darkgreen,
      content: barlowBold(
        text: content,
        size: 16,
        color: white,
      ),
    ),
  );
}

///Vertical Space
Widget VSpace(
  double h,
) {
  return SizedBox(
    height: h,
  );
}

///Horizontal Space
Widget HSpace(
  double w,
) {
  return SizedBox(
    width: w,
  );
}

///Custom Indicator
Widget progressIndicator(BuildContext context) {
  return Center(
    child: Container(
      width: 30,
      child: LinearProgressIndicator(
        backgroundColor: grey,
        color: black,
        minHeight: 2,
      ),
    ),
  );
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

///Custom TextField
Widget CustomTextfield(
  TextEditingController controller,
  String hintText,
  String labelText,
  String errorText,
  TextInputType keyboardType,
) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 15,
      top: 8,
      right: 15,
    ),
    child: TextFormField(
      keyboardType: keyboardType,
      cursorColor: grey,
      controller: controller,
      validator: RequiredValidator(
        errorText: errorText,
      ),
      decoration: InputDecoration(
        label: barlowRegular(
          text: labelText,
          size: 15,
          color: grey,
        ),
        contentPadding: EdgeInsets.only(left: 15),
        hintText: hintText,
        enabledBorder: customOutlineBorder(),
        focusedBorder: customOutlineBorder(),
        errorBorder: customOutlineBorder(),
        focusedErrorBorder: customOutlineBorder(),
      ),
    ),
  );
}

///Cache Image For Sliders.
sliderImage(String url, BuildContext context) {
  // ignore: unnecessary_null_comparison
  if (url != null) {
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.fill,
        httpHeaders: {'Referer': ''},
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fill,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/banner_placeholder.png',
          ),
        ),
        errorWidget: (context, url, error) => Image(
          fit: BoxFit.cover,
          image: AssetImage(
            'assets/banner_placeholder.png',
          ),
        ),
      );
    } else {
      return Image(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/banner_placeholder.png',
        ),
      );
    }
  } else {
    return Image(
      fit: BoxFit.cover,
      image: AssetImage(
        'assets/banner_placeholder.png',
      ),
    );
  }
}

///Cache Image For Banners.
setCloudImageFull(String url, BuildContext context) {
  // ignore: unnecessary_null_comparison
  if (url != null) {
    // print("banner slider data");
    // print(url);
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: url,
        width: fullWidth(context),
        height: fullHeight(context) * 0.22,
        httpHeaders: {'Referer': ''},
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/placeholder.png',
          ),
        ),
        errorWidget: (context, url, error) => Image(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/placeholder.png',
          ),
        ),
      );
    } else {
      return Image(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/placeholder.png',
        ),
      );
    }
  } else {
    return Image(
      fit: BoxFit.cover,
      image: AssetImage(
        'assets/placeholder.png',
      ),
    );
  }
}

///Cache Network Image Custom Widget
Widget CachedNetworkImg(
    String url, double w, double h, String assetImage, BuildContext context) {
  return InkWell(
    onTap: () {
      goto(
        context,
        ImageToFullScreen(url),
      );
    },
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: w,
      height: h,
      placeholder: (context, url) {
        return Center(
          child: Text("Loading"),
        );
      },
      errorWidget: (context, url, dynamic) {
        return Center(
          child: Image.asset(
            assetImage,
            width: w * 0.50,
            fit: BoxFit.cover,
          ),
        );
      },
    ),
  );
}

///Cache Network Image Custom Widget for tractor screen
Widget CachedNetworkImgForSlider(String url, double w, double h,
    String assetImage, List sliderList, indexData, BuildContext context) {
  return InkWell(
    onTap: () {
      goto(
        context,
        ImageToFullScreenSlider(
            urlData: url, SliderListData: sliderList, IndexData: indexData),
      );
    },
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: w,
      height: h,
      placeholder: (context, url) {
        return Center(
          child: Text("Loading"),
        );
      },
      errorWidget: (context, url, dynamic) {
        return Center(
          child: Image.asset(
            assetImage,
            width: w * 0.50,
            fit: BoxFit.cover,
          ),
        );
      },
    ),
  );
}

///Cache Image With Size.
Widget CachedNetworkImgWithSize({
  String url = "",
  double w = 0.0,
  double h = 0.0,
  BuildContext? context,
}) {
  return InkWell(
    onTap: () {
      goto(
        context!,
        ImageToFullScreen(
          url,
        ),
      );
    },
    child: CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: 50,
      height: 50,
      placeholder: (context, url) {
        return Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            image: DecorationImage(
              image: AssetImage(
                'assets/placeholder.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      errorWidget: (context, url, dynamic) {
        return Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10,
              ),
              image: DecorationImage(
                image: AssetImage(
                  'assets/placeholder.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    ),
  );
}

///Cache Image For Banners.
setImageForBrandAndModel(String url, BuildContext context) {
  // ignore: unnecessary_null_comparison
  if (url != null) {
    if (url.length > 0) {
      return CachedNetworkImage(
        imageUrl: url,
        width: 70,
        height: 50,
        httpHeaders: {'Referer': ''},
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Image(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/placeholder.png',
          ),
        ),
        errorWidget: (context, url, error) => Image(
          fit: BoxFit.fitWidth,
          image: AssetImage(
            'assets/placeholder.png',
          ),
        ),
      );
    } else {
      return Image(
        fit: BoxFit.cover,
        image: AssetImage(
          'assets/placeholder.png',
        ),
      );
    }
  } else {
    return Image(
      fit: BoxFit.cover,
      image: AssetImage(
        'assets/placeholder.png',
      ),
    );
  }
}

Widget getStatusButtonForMyPost(int status, String TypeData) {
  if (TypeData == "mypost") {
    if (status == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 18,
          width: 80,
          color: green,
          child: Center(
            child: barlowBold(
              text: "Approved",
              color: white,
              size: 14,
            ),
          ),
        ),
      );
    } else if (status == 2) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 18,
          width: 80,
          color: red,
          child: Center(
            child: barlowBold(
              text: "Rejected",
              color: white,
              size: 14,
            ),
          ),
        ),
      );
    }else if (status == 3) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 18,
          width: 80,
          color: Colors.grey,
          child: Center(
            child: barlowBold(
              text: "Disabled",
              color: white,
              size: 14,
            ),
          ),
        ),
      );
    }
    else if (status == 4) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 18,
          width: 80,
          color: Colors.blue,
          child: Center(
            child: barlowBold(
              text: "Sold",
              color: white,
              size: 14,
            ),
          ),
        ),
      );
    }
    //for rejected
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 18,
        width: 75,
        color: orange,
        child: Center(
          child: barlowBold(
            text: "Pending",
            color: white,
            size: 14,
          ),
        ),
      ),
    );
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: 1,
      width: 1,
      color: white,
    ),
  );
}

// Rejected
// Pending
