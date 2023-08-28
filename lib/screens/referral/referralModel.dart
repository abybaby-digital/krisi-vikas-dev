class ReferralModel {
  bool? response;
  String? flag;
  String? message;
  int? data;
  String? error;

  ReferralModel(
      {this.response, this.flag, this.message, this.data, this.error});

  ReferralModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    flag = json['flag'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['flag'] = this.flag;
    data['message'] = this.message;
    data['data'] = this.data;
    data['error'] = this.error;
    return data;
  }
}