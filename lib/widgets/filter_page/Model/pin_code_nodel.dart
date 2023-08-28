// To parse this JSON data, do
//
//     final pinCodeModal = pinCodeModalFromJson(jsonString);

import 'dart:convert';

PinCodeModal pinCodeModalFromJson(String str) => PinCodeModal.fromJson(json.decode(str));

String pinCodeModalToJson(PinCodeModal data) => json.encode(data.toJson());

class PinCodeModal {
  bool response;
  String message;
  List<PinCodeDatum> data;
  String error;

  PinCodeModal({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory PinCodeModal.fromJson(Map<String, dynamic> json) => PinCodeModal(
    response: json["response"],
    message: json["message"],
    data: List<PinCodeDatum>.from(json["data"].map((x) => PinCodeDatum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class PinCodeDatum {
  int countryId;
  String countryName;
  int stateId;
  String stateName;
  int districtId;
  String districtName;
  int cityId;
  String cityName;
  String latitude;
  String longitude;

  PinCodeDatum({
    required this.countryId,
    required this.countryName,
    required this.stateId,
    required this.stateName,
    required this.districtId,
    required this.districtName,
    required this.cityId,
    required this.cityName,
    required this.latitude,
    required this.longitude,
  });

  factory PinCodeDatum.fromJson(Map<String, dynamic> json) => PinCodeDatum(
    countryId: json["country_id"],
    countryName: json["country_name"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    districtId: json["district_id"],
    districtName: json["district_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "country_id": countryId,
    "country_name": countryName,
    "state_id": stateId,
    "state_name": stateName,
    "district_id": districtId,
    "district_name": districtName,
    "city_id": cityId,
    "city_name": cityName,
    "latitude": latitude,
    "longitude": longitude,
  };
}
