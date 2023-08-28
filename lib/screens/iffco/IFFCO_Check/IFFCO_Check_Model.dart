class IFFCO_Check_Model {
  bool? response;
  String? message;
  String? image;
  String? error;

  IFFCO_Check_Model({this.response, this.message, this.image, this.error});

  IFFCO_Check_Model.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    image = json['image'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    data['image'] = this.image;
    data['error'] = this.error;
    return data;
  }
}