// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  bool response;
  String message;
  List<DatumCategory> data;
  String error;

  Category({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    response: json["response"],
    message: json["message"],
    data: List<DatumCategory>.from(json["data"].map((x) => DatumCategory.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DatumCategory {
  int id;
  int sequence;
  String category;
  String icon;
  int status;
  String lnBn;
  String lnHn;
  DateTime createdAt;
  DateTime updatedAt;

  DatumCategory({
    required this.id,
    required this.sequence,
    required this.category,
    required this.icon,
    required this.status,
    required this.lnBn,
    required this.lnHn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DatumCategory.fromJson(Map<String, dynamic> json) => DatumCategory(
    id: json["id"],
    sequence: json["sequence"],
    category: json["category"],
    icon: json["icon"],
    status: json["status"],
    lnBn: json["ln_bn"],
    lnHn: json["ln_hn"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sequence": sequence,
    "category": category,
    "icon": icon,
    "status": status,
    "ln_bn": lnBn,
    "ln_hn": lnHn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
