class MaintenanceModel {
  bool? response;
  String? message;
  String? error;

  MaintenanceModel({this.response, this.message, this.error});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}