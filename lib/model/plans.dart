class PlanModel {
  List<Data>? data;
  String? code;
  String? message;

  PlanModel({this.data, this.code, this.message});

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      data: json['PackageList'] != null
          ? (json['PackageList'] as List).map((i) => Data.fromJson(i)).toList()
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
      data['PackageList'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  String? title;
  String? id;
  String? image;
  String? amount;
  String? description;
  String? valid_from;
  String? status;

  Data(
      {
      this.title,
      this.id,
      this.image,
      this.amount,
      this.description,
      this.valid_from,
      this.status,
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      id: json['id'],
      image: json['image'],
      amount: json['amount'],
      description: json['description'],
      valid_from: json['valid_from'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['image'] = this.image;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['valid_from'] = this.valid_from;
    data['status'] = this.status;
    return data;
  }
}
