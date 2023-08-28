import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/api_methods.dart';

import '../Screens/tractor/data.dart';
import '../const/api_urls.dart';
import '../const/colors.dart';
import '../const/distance_calculation.dart';
import '../services/save_user_info.dart';
import 'all_widgets.dart';


Widget ShowDistanceHorizontal(double? lat, double? long, String d) {
  if(lat==null||long==null)
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.locationArrow,size: 12,color: Colors.grey,),
          SizedBox(width: 3,),
          barlowRegularForHome(
            text: "Distance not available",
            color: grey,
            size: 13,
            maxLine: 1,
          ),
        ],
      ),
    );

  List<String> latlong = d.split(',');
  double end_lat = double.parse(latlong[0]);
  double end_long = double.parse(latlong[1]);

  double distance = calculateDistance(end_lat,end_long,UserData.lat!,UserData.long!);

  return Padding(
    padding: const EdgeInsets.only(left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(FontAwesomeIcons.locationArrow,size: 12,color: Colors.grey,),
        SizedBox(width: 3,),
        barlowRegularForHome(
          text: "${distance.toStringAsFixed(2)} km",
          color: grey,
          size: 13,
          maxLine: 1,
        ),
      ],
    ),
  );
}

Widget ShowDistanceVertical(double? lat, double? long, String d) {
  if(lat==null||long==null)
    return Padding(
      padding: const EdgeInsets.only(top: 4,left: 1),
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.locationArrow,size: 12,color: Colors.grey,),
          SizedBox(width: 6,),
          barlowRegularForHome(
            text: "Distance not available",
            color: grey,
            size: 13,
            maxLine: 1,
          ),
        ],
      ),
    );
  List<String> latlong = d.split(',');
  double end_lat = double.parse(latlong[0]);
  double end_long = double.parse(latlong[1]);

  double distance = calculateDistance(end_lat,end_long,UserData.lat!,UserData.long!);
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FaIcon(FontAwesomeIcons.locationArrow,size: 12,color: Colors.grey,),
        SizedBox(width: 2,),
        barlowRegularForHome(
          text: "${distance.toStringAsFixed(2)} km",
          color: Colors.black87,
          size: 13,
          maxLine: 1,
        ),
      ],
    ),
  );
}

Widget ShowDistanceText(double? lat, double? long, String d) {
  if(lat==null||long==null)
    return Text("Not Available");

  List<String> latlong = d.split(',');
  double end_lat = double.parse(latlong[0]);
  double end_long = double.parse(latlong[1]);

  double distance = calculateDistance(end_lat,end_long,UserData.lat!,UserData.long!);
  return Text("${distance.toStringAsFixed(2)} km");
}
