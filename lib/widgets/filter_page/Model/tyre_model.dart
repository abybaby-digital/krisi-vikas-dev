// To parse this JSON data, do
//
//     final tyreFilterModal = tyreFilterModalFromJson(jsonString);

import 'dart:convert';

TyreFilterModal tyreFilterModalFromJson(String str) => TyreFilterModal.fromJson(json.decode(str));

String tyreFilterModalToJson(TyreFilterModal data) => json.encode(data.toJson());

class TyreFilterModal {
  bool response;
  String message;
  List<Tyre> data;
  String error;

  TyreFilterModal({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory TyreFilterModal.fromJson(Map<String, dynamic> json) => TyreFilterModal(
    response: json["response"],
    message: json["message"],
    data: List<Tyre>.from(json["data"].map((x) => Tyre.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class Tyre {
  int id;
  String categoryId;
  int userId;
  int userTypeId;
  dynamic roleId;
  String name;
  String? companyName;
  String mobile;
  dynamic email;
  dynamic gender;
  String? address;
  int zipcode;
  String createdAtUser;
  String? deviceId;
  String? firebaseToken;
  String photo;
  String type;
  int brandId;
  int modelId;
  dynamic title;
  String brandName;
  String modelName;
  String? position;
  String price;
  String? description;
  String? image1;
  String? image2;
  String? image3;
  String? isNegotiable;
  int countryId;
  int stateId;
  int districtId;
  int cityId;
  String stateName;
  String districtName;
  String cityName;
  int wishlistStatus;
  int pincode;
  String latlong;
  dynamic isFeatured;
  dynamic validTill;
  dynamic adReport;
  int status;
  String createdAt;
  DateTime? updatedAt;

  Tyre({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.userTypeId,
    this.roleId,
    required this.name,
    this.companyName,
    required this.mobile,
    this.email,
    this.gender,
    this.address,
    required this.zipcode,
    required this.createdAtUser,
    this.deviceId,
    this.firebaseToken,
    required this.photo,
    required this.type,
    required this.brandId,
    required this.modelId,
    this.title,
    required this.brandName,
    required this.modelName,
    this.position,
    required this.price,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.isNegotiable,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.cityId,
    required this.stateName,
    required this.districtName,
    required this.cityName,
    required this.wishlistStatus,
    required this.pincode,
    required this.latlong,
    this.isFeatured,
    this.validTill,
    this.adReport,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });

  factory Tyre.fromJson(Map<String, dynamic> json) => Tyre(
    id: json["id"],
    categoryId: json["category_id"],
    userId: json["user_id"],
    userTypeId: json["user_type_id"],
    roleId: json["role_id"],
    name: json["name"],
    companyName: json["company_name"],
    mobile: json["mobile"],
    email: json["email"],
    gender: json["gender"],
    address: json["address"],
    zipcode: json["zipcode"],
    createdAtUser: json["created_at_user"],
    deviceId: json["device_id"],
    firebaseToken: json["firebase_token"],
    photo: json["photo"],
    type: json["type"],
    brandId: json["brand_id"],
    modelId: json["model_id"],
    title: json["title"],
    brandName: json["brand_name"],
    modelName: json["model_name"],
    position: json["position"],
    price: json["price"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    isNegotiable: json["is_negotiable"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    districtId: json["district_id"],
    cityId: json["city_id"],
    stateName: json["state_name"],
    districtName: json["district_name"],
    cityName: json["city_name"],
    wishlistStatus: json["wishlist_status"],
    pincode: json["pincode"],
    latlong: json["latlong"],
    isFeatured: json["is_featured"],
    validTill: json["valid_till"],
    adReport: json["ad_report"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "user_id": userId,
    "user_type_id": userTypeId,
    "role_id": roleId,
    "name": name,
    "company_name": companyName,
    "mobile": mobile,
    "email": email,
    "gender": gender,
    "address": address,
    "zipcode": zipcode,
    "created_at_user": createdAtUser,
    "device_id": deviceId,
    "firebase_token": firebaseToken,
    "photo": photo,
    "type": type,
    "brand_id": brandId,
    "model_id": modelId,
    "title": title,
    "brand_name": brandName,
    "model_name": modelName,
    "position": position,
    "price": price,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "is_negotiable": isNegotiable,
    "country_id": countryId,
    "state_id": stateId,
    "district_id": districtId,
    "city_id": cityId,
    "state_name": stateName,
    "district_name": districtName,
    "city_name": cityName,
    "wishlist_status": wishlistStatus,
    "pincode": pincode,
    "latlong": latlong,
    "is_featured": isFeatured,
    "valid_till": validTill,
    "ad_report": adReport,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}
