// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

Search brandFromJson(String str) => Search.fromJson(json.decode(str));

String brandToJson(Search data) => json.encode(data.toJson());

class Search {
  bool response;
  String message;
  List<DatumSearch> data;
  String error;

  Search({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    response: json["response"],
    message: json["message"],
    data: List<DatumSearch>.from(json["data"].map((x) => DatumSearch.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DatumSearch {
  int id;
  int searchId;
  int stringId;
  String keyword;

  DatumSearch({
    required this.id,
    required this.searchId,
    required this.stringId,
    required this.keyword,
  });

  factory DatumSearch.fromJson(Map<String, dynamic> json) => DatumSearch(
    id: json["id"],
    searchId: json["search_id"],
    stringId: json["string_id"],
    keyword: json["keyword"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "search_id": searchId,
    "string_id": stringId,
    "keyword": keyword,
  };
}
