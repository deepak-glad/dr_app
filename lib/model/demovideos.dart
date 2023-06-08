class DemoVideos {
  List<Data>? data;
  String? code;
  String? message;

  DemoVideos({this.data, this.code, this.message});

  factory DemoVideos.fromJson(Map<String, dynamic> json) {
    return DemoVideos(
      data: json['video_list'] != null
          ? (json['video_list'] as List).map((i) => Data.fromJson(i)).toList()
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
      data['video_list'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  String? title;
  String? service_id;
  String? video_id;
  String? description;
  String? language;
  String? video;
  String? thumnail;
  String? content_type;

  Data(
      {
      this.title,
      this.service_id,
      this.video_id,
      this.description,
      this.language,
      this.video,
      this.thumnail,
      this.content_type,
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      service_id: json['service_id'],
      video_id: json['video_id'],
      description: json['description'],
      language: json['language'],
      video: json['video'],
      thumnail: json['thumnail'],
      content_type: json['content_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['service_id'] = this.service_id;
    data['video_id'] = this.video_id;
    data['description'] = this.description;
    data['language'] = this.language;
    data['video'] = this.video;
    data['thumnail'] = this.thumnail;
    data['content_type'] = this.content_type;
    return data;
  }
}
