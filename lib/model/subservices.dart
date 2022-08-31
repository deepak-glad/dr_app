class SubService {
  List<Data> data;
  String code;
  String message;

  SubService({this.data, this.code, this.message});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      data: json['SubServiceList'] != null
          ? (json['SubServiceList'] as List).map((i) => Data.fromJson(i)).toList()
          : null,
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['SubServiceList'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  String sub_category_id;
  String service_id;
  String image;
  String sub_category_name;

  Data(
      {
      this.sub_category_id,
      this.service_id,
      this.image,
      this.sub_category_name,
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      sub_category_id: json['sub_category_id'],
      service_id: json['service_id'],
      image: json['image'],
      sub_category_name: json['sub_category_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_category_id'] = this.sub_category_id;
    data['service_id'] = this.service_id;
    data['image'] = this.image;
    data['sub_category_name'] = this.sub_category_name;
    return data;
  }
}
