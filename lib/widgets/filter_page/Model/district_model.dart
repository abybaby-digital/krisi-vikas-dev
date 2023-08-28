// To parse this JSON data, do
//
//     final districtModel = districtModelFromJson(jsonString);

import 'dart:convert';

DistrictModel districtModelFromJson(String str) => DistrictModel.fromJson(json.decode(str));

String districtModelToJson(DistrictModel data) => json.encode(data.toJson());

class DistrictModel {
  bool response;
  String message;
  List<DistrictDatum> data;
  String error;

  DistrictModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) => DistrictModel(
    response: json["response"],
    message: json["message"],
    data: List<DistrictDatum>.from(json["data"].map((x) => DistrictDatum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DistrictDatum {
  int id;
  String districtName;
  String latitude;
  String longitude;
  int tractorCount;
  int goodsVehicleCount;
  int harvesterCount;
  int implementsCount;
  int tyresCount;
  int seedsCount;
  int pesticidesCount;
  int fertilizersCount;

  DistrictDatum({
    required this.id,
    required this.districtName,
    required this.latitude,
    required this.longitude,
    required this.tractorCount,
    required this.goodsVehicleCount,
    required this.harvesterCount,
    required this.implementsCount,
    required this.tyresCount,
    required this.seedsCount,
    required this.pesticidesCount,
    required this.fertilizersCount,
  });

  factory DistrictDatum.fromJson(Map<String, dynamic> json) => DistrictDatum(
    id: json["id"],
    districtName: json["district_name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    tractorCount: json["tractor_count"],
    goodsVehicleCount: json["goods_vehicle_count"],
    harvesterCount: json["harvester_count"],
    implementsCount: json["implements_count"],
    tyresCount: json["tyres_count"],
    seedsCount: json["seeds_count"],
    pesticidesCount: json["pesticides_count"],
    fertilizersCount: json["fertilizers_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "district_name": districtName,
    "latitude": latitude,
    "longitude": longitude,
    "tractor_count": tractorCount,
    "goods_vehicle_count": goodsVehicleCount,
    "harvester_count": harvesterCount,
    "implements_count": implementsCount,
    "tyres_count": tyresCount,
    "seeds_count": seedsCount,
    "pesticides_count": pesticidesCount,
    "fertilizers_count": fertilizersCount,
  };
}
