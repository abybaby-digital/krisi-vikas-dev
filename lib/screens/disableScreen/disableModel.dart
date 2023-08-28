class DisableModel {
  bool? response;
  String? message;
  String? data;
  String? error;

  DisableModel({this.response, this.message, this.data, this.error});

  DisableModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    data['data'] = this.data;
    data['error'] = this.error;
    return data;
  }
}