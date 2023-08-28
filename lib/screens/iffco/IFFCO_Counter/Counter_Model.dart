class IffcoCounter {
  final int id;
  final String slNo;
  final String name;
  final String code;
  final String? groupName;
  final String gstNo;
  final String address;
  final String blockName;
  final String state;
  final String district;
  final String? city;
  final String pincode;
  final String? latLong;
  final String mobileNo;
  final String? phoneNo;
  final String sale;
  final String warehousing;
  final String tptn;
  final String consignee;
  final String handling;
  final String? tinNo;
  final String iffcoSocNo;
  final String? stateName;
  final String districtName;
  final String image;

  IffcoCounter({
    required this.id,
    required this.slNo,
    required this.name,
    required this.code,
    this.groupName,
    required this.gstNo,
    required this.address,
    required this.blockName,
    required this.state,
    required this.district,
    this.city,
    required this.pincode,
    this.latLong,
    required this.mobileNo,
    this.phoneNo,
    required this.sale,
    required this.warehousing,
    required this.tptn,
    required this.consignee,
    required this.handling,
    this.tinNo,
    required this.iffcoSocNo,
    this.stateName,
    required this.districtName,
    required this.image,
  });

  factory IffcoCounter.fromJson(Map<String, dynamic> json) {
    return IffcoCounter(
      id: json['id'],
      slNo: json['sl_no'],
      name: json['name'],
      code: json['code'],
      groupName: json['group_name'],
      gstNo: json['gst_no'],
      address: json['address'],
      blockName: json['block_name'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
      pincode: json['pincode'],
      latLong: json['lat_long'],
      mobileNo: json['mobile_no'],
      phoneNo: json['phone_no'],
      sale: json['sale'],
      warehousing: json['warehousing'],
      tptn: json['tptn'],
      consignee: json['consignee'],
      handling: json['handling'],
      tinNo: json['tin_no'],
      iffcoSocNo: json['iffco_soc_no'],
      stateName: json['state_name'],
      districtName: json['district_name'],
      image: json['image'],
    );
  }
}
