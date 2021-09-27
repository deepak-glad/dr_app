class Services {
  List<Data> data;
  String code;
  String message;

  Services({this.data, this.code, this.message});

  factory Services.fromJson(Map<String, dynamic> json) {
    return Services(
      data: json['ServiceList'] != null
          ? (json['ServiceList'] as List).map((i) => Data.fromJson(i)).toList()
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
      data['ServiceList'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  String title;
  String id;
  String image;

  Data(
      {
      this.title,
      this.id,
      this.image,
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      id: json['id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['image'] = this.image;
    return data;
  }
}
