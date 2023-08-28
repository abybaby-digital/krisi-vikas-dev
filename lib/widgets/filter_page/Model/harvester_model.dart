// To parse this JSON data, do
//
//     final harvesterModel = harvesterModelFromJson(jsonString);

import 'dart:convert';

HarvesterModel harvesterModelFromJson(String str) => HarvesterModel.fromJson(json.decode(str));

String harvesterModelToJson(HarvesterModel data) => json.encode(data.toJson());

class HarvesterModel {
  bool response;
  String message;
  List<DatumHar> data;
  String error;

  HarvesterModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory HarvesterModel.fromJson(Map<String, dynamic> json) => HarvesterModel(
    response: json["response"],
    message: json["message"],
    data: List<DatumHar>.from(json["data"].map((x) => DatumHar.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DatumHar {
  int id;
  int categoryId;
  int userId;
  int userTypeId;
  dynamic roleId;
  String? name;
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
  String datumSet;
  String type;
  int brandId;
  int modelId;
  String? title;
  String? brandName;
  String modelName;
  dynamic specification;
  String? yearOfPurchase;
  String? cropType;
  String? cuttingWith;
  String? powerSource;
  dynamic specId;
  String? description;
  String leftImage;
  String rightImage;
  String frontImage;
  String backImage;
  int price;
  String? rentType;
  String isNegotiable;
  int pincode;
  int countryId;
  int stateId;
  int districtId;
  int cityId;
  String? stateName;
  String? districtName;
  String? cityName;
  int wishlistStatus;
  String latlong;
  dynamic adReport;
  int status;
  String createdAt;
  dynamic updatedAt;
  int viewLead;
  int callLead;
  int msgLead;

  DatumHar({
    required this.id,
    required this.categoryId,
    required this.userId,
    required this.userTypeId,
    this.roleId,
    this.name,
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
    required this.datumSet,
    required this.type,
    required this.brandId,
    required this.modelId,
    this.title,
    this.brandName,
    required this.modelName,
    required this.specification,
    this.yearOfPurchase,
    this.cropType,
    this.cuttingWith,
    this.powerSource,
    this.specId,
    this.description,
    required this.leftImage,
    required this.rightImage,
    required this.frontImage,
    required this.backImage,
    required this.price,
    this.rentType,
    required this.isNegotiable,
    required this.pincode,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.cityId,
    this.stateName,
    this.districtName,
    this.cityName,
    required this.wishlistStatus,
    required this.latlong,
    this.adReport,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.viewLead,
    required this.callLead,
    required this.msgLead,
  });

  factory DatumHar.fromJson(Map<String, dynamic> json) => DatumHar(
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
    datumSet: json["set"]!,
    type: json["type"]!,
    brandId: json["brand_id"],
    modelId: json["model_id"],
    title: json["title"],
    brandName: json["brand_name"],
    modelName: json["model_name"],
    specification: json["specification"],
    yearOfPurchase: json["year_of_purchase"],
    cropType: json["crop_type"],
    cuttingWith: json["cutting_with"],
    powerSource: json["power_source"],
    specId: json["spec_id"],
    description: json["description"],
    leftImage: json["left_image"],
    rightImage: json["right_image"],
    frontImage: json["front_image"],
    backImage: json["back_image"],
    price: json["price"],
    rentType: json["rent_type"],
    isNegotiable: json["is_negotiable"],
    pincode: json["pincode"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    districtId: json["district_id"],
    cityId: json["city_id"],
    stateName: json["state_name"],
    districtName: json["district_name"],
    cityName: json["city_name"],
    wishlistStatus: json["wishlist_status"],
    latlong: json["latlong"],
    adReport: json["ad_report"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    viewLead: json["view_lead"],
    callLead: json["call_lead"],
    msgLead: json["msg_lead"],
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
    "set": datumSet,
    "type": type,
    "brand_id": brandId,
    "model_id": modelId,
    "title": title,
    "brand_name": brandName,
    "model_name": modelName,
    "specification": specification,
    "year_of_purchase": yearOfPurchase,
    "crop_type": cropType,
    "cutting_with": cuttingWith,
    "power_source": powerSource,
    "spec_id": specId,
    "description": description,
    "left_image": leftImage,
    "right_image": rightImage,
    "front_image": frontImage,
    "back_image": backImage,
    "price": price,
    "rent_type": rentType,
    "is_negotiable": isNegotiable,
    "pincode": pincode,
    "country_id": countryId,
    "state_id": stateId,
    "district_id": districtId,
    "city_id": cityId,
    "state_name": stateName,
    "district_name": districtName,
    "city_name": cityName,
    "wishlist_status": wishlistStatus,
    "latlong": latlong,
    "ad_report": adReport,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "view_lead": viewLead,
    "call_lead": callLead,
    "msg_lead": msgLead,
  };
}
