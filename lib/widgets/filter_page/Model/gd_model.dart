// To parse this JSON data, do
//
//     final gdModel = gdModelFromJson(jsonString);

import 'dart:convert';

GdModel gdModelFromJson(String str) => GdModel.fromJson(json.decode(str));

String gdModelToJson(GdModel data) => json.encode(data.toJson());

class GdModel {
  bool response;
  String message;
  List<DatumGd> data;
  String error;

  GdModel({
    required this.response,
    required this.message,
    required this.data,
    required this.error,
  });

  factory GdModel.fromJson(Map<String, dynamic> json) => GdModel(
    response: json["response"],
    message: json["message"],
    data: List<DatumGd>.from(json["data"].map((x) => DatumGd.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "response": response,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "error": error,
  };
}

class DatumGd {
  int id;
  String categoryId;
  String userId;
  int userTypeId;
  dynamic roleId;
  String? name;
  String? companyName;
  String mobile;
  String? email;
  dynamic gender;
  String? address;
  int zipcode;
  String? deviceId;
  String? firebaseToken;
  String createdAtUser;
  String photo;
  String datumSet;
  String type;
  String brandId;
  String modelId;
  String? title;
  String brandName;
  String modelName;
  dynamic specification;
  String? yearOfPurchase;
  String? rcAvailable;
  String? nocAvailable;
  String? registrationNo;
  String? description;
  String leftImage;
  String rightImage;
  String frontImage;
  String backImage;
  String meterImage;
  String tyreImage;
  String price;
  String? rentType;
  String isNegotiable;
  int pincode;
  int countryId;
  int stateId;
  int districtId;
  int cityId;
  String stateName;
  String districtName;
  String cityName;
  String latlong;
  dynamic adReport;
  int status;
  String createdAt;
  dynamic updatedAt;
  int viewLead;
  int callLead;
  int msgLead;
  int wishlistStatus;

  DatumGd({
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
    this.deviceId,
    this.firebaseToken,
    required this.createdAtUser,
    required this.photo,
    required this.datumSet,
    required this.type,
    required this.brandId,
    required this.modelId,
    this.title,
    required this.brandName,
    required this.modelName,
    required this.specification,
    this.yearOfPurchase,
    this.rcAvailable,
    this.nocAvailable,
    this.registrationNo,
    this.description,
    required this.leftImage,
    required this.rightImage,
    required this.frontImage,
    required this.backImage,
    required this.meterImage,
    required this.tyreImage,
    required this.price,
    this.rentType,
    required this.isNegotiable,
    required this.pincode,
    required this.countryId,
    required this.stateId,
    required this.districtId,
    required this.cityId,
    required this.stateName,
    required this.districtName,
    required this.cityName,
    required this.latlong,
    this.adReport,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    required this.viewLead,
    required this.callLead,
    required this.msgLead,
    required this.wishlistStatus,
  });

  factory DatumGd.fromJson(Map<String, dynamic> json) => DatumGd(
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
    deviceId: json["device_id"],
    firebaseToken: json["firebase_token"],
    createdAtUser: json["created_at_user"],
    photo: json["photo"],
    datumSet: json["set"],
    type: json["type"],
    brandId: json["brand_id"],
    modelId: json["model_id"],
    title: json["title"],
    brandName: json["brand_name"],
    modelName: json["model_name"],
    specification: json["specification"],
    yearOfPurchase: json["year_of_purchase"],
    rcAvailable: json["rc_available"],
    nocAvailable: json["noc_available"],
    registrationNo: json["registration_no"],
    description: json["description"],
    leftImage: json["left_image"],
    rightImage: json["right_image"],
    frontImage: json["front_image"],
    backImage: json["back_image"],
    meterImage: json["meter_image"],
    tyreImage: json["tyre_image"],
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
    latlong: json["latlong"],
    adReport: json["ad_report"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    viewLead: json["view_lead"],
    callLead: json["call_lead"],
    msgLead: json["msg_lead"],
    wishlistStatus: json["wishlist_status"],
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
    "device_id": deviceId,
    "firebase_token": firebaseToken,
    "created_at_user": createdAtUser,
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
    "rc_available": rcAvailable,
    "noc_available": nocAvailable,
    "registration_no": registrationNo,
    "description": description,
    "left_image": leftImage,
    "right_image": rightImage,
    "front_image": frontImage,
    "back_image": backImage,
    "meter_image": meterImage,
    "tyre_image": tyreImage,
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
    "latlong": latlong,
    "ad_report": adReport,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "view_lead": viewLead,
    "call_lead": callLead,
    "msg_lead": msgLead,
    "wishlist_status": wishlistStatus,
  };
}
