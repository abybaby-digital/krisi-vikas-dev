// To parse this JSON data, do
//
//     final priceModel = priceModelFromJson(jsonString);

import 'dart:convert';

PriceModel priceModelFromJson(String str) => PriceModel.fromJson(json.decode(str));

String priceModelToJson(PriceModel data) => json.encode(data.toJson());

class PriceModel {
  bool response;
  String message;
  List<PriceDatum> data;
  String error;

  PriceModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory PriceModel.fromJson(Map<String, dynamic> json) => PriceModel(
    response: json["response"],
    message: json["message"],
    data: List<PriceDatum>.from(json["data"].map((x) => PriceDatum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class PriceDatum {
  int tractorCount;
  int goodsVehicleCount;
  int harvesterCount;
  int implementsCount;
  int tyresCount;
  int seedsCount;
  int pesticidesCount;
  int fertilizersCount;

  PriceDatum({
    required this.tractorCount,
    required this.goodsVehicleCount,
    required this.harvesterCount,
    required this.implementsCount,
    required this.tyresCount,
    required this.seedsCount,
    required this.pesticidesCount,
    required this.fertilizersCount,
  });

  factory PriceDatum.fromJson(Map<String, dynamic> json) => PriceDatum(
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
