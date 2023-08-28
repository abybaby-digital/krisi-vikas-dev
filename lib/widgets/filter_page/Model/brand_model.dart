// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

class Brand {
  bool response;
  String message;
  List<BrandDatum> data;
  String error;

  Brand({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    response: json["response"],
    message: json["message"],
    data: List<BrandDatum>.from(json["data"].map((x) => BrandDatum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class BrandDatum {
  int id;
  String name;
  String logo;
  int popular;
  int status;
  String createdAt;
  String updatedAt;

  BrandDatum({
    required this.id,
    required this.name,
    required this.logo,
    required this.popular,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BrandDatum.fromJson(Map<String, dynamic> json) => BrandDatum(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    popular: json["popular"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "popular": popular,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
