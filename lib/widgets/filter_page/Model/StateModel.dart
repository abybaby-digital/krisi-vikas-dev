// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool response;
  String message;
  List<StateDatum> data;
  String error;

  StateModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    response: json["response"],
    message: json["message"],
    data: List<StateDatum>.from(json["data"].map((x) => StateDatum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class StateDatum {
  int id;
  String countryId;
  String stateName;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  int tractorCount;
  int goodsVehicleCount;
  int harvesterCount;
  int implementsCount;
  int tyresCount;
  int seedsCount;
  int pesticidesCount;
  int fertilizersCount;

  StateDatum({
    required this.id,
    required this.countryId,
    required this.stateName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.tractorCount,
    required this.goodsVehicleCount,
    required this.harvesterCount,
    required this.implementsCount,
    required this.tyresCount,
    required this.seedsCount,
    required this.pesticidesCount,
    required this.fertilizersCount,
  });

  factory StateDatum.fromJson(Map<String, dynamic> json) => StateDatum(
    id: json["id"],
    countryId: json["country_id"],
    stateName: json["state_name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "country_id": countryId,
    "state_name": stateName,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
