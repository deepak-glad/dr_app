// To parse this JSON data, do
//
//     final keyModel = keyModelFromJson(jsonString);

import 'dart:convert';

KeyModel keyModelFromJson(String str) => KeyModel.fromJson(json.decode(str));

String keyModelToJson(KeyModel data) => json.encode(data.toJson());

class KeyModel {
  KeyModel({
    required this.code,
    required this.success,
    required this.message,
    required this.gatewayList,
  });

  String? code;
  String? success;
  String? message;
  List<GatewayList> gatewayList;

  factory KeyModel.fromJson(Map<String, dynamic> json) => KeyModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        gatewayList: List<GatewayList>.from(
            json["gateway_list"].map((x) => GatewayList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "gateway_list": List<dynamic>.from(gatewayList.map((x) => x.toJson())),
      };
}

class GatewayList {
  GatewayList({
    required this.id,
    required this.key,
    required this.secret,
  });

  String? id;
  String? key;
  String? secret;

  factory GatewayList.fromJson(Map<String, dynamic> json) => GatewayList(
        id: json["id"],
        key: json["key"],
        secret: json["secret"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "secret": secret,
      };
}
