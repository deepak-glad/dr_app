import 'dart:convert';

PdfModel pdfModelFromJson(String str) => PdfModel.fromJson(json.decode(str));

String pdfModelToJson(PdfModel data) => json.encode(data.toJson());

class PdfModel {
  PdfModel({
    required this.code,
    required this.success,
    required this.message,
    required this.pdfList,
  });

  String? code;
  String? success;
  String? message;
  List<PdfList> pdfList;

  factory PdfModel.fromJson(Map<String, dynamic> json) => PdfModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        pdfList: List<PdfList>.from(
            json["PDF_list"].map((x) => PdfList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "PDF_list": List<dynamic>.from(pdfList.map((x) => x.toJson())),
      };
}

class PdfList {
  PdfList({
    required this.pdfId,
    required this.serviceId,
    required this.title,
    required this.pdf,
  });

  String? pdfId;
  String? serviceId;
  String? title;
  String? pdf;

  factory PdfList.fromJson(Map<String, dynamic> json) => PdfList(
        pdfId: json["pdf_id"],
        serviceId: json["service_id"],
        title: json["title"],
        pdf: json["pdf"],
      );

  Map<String, dynamic> toJson() => {
        "pdf_id": pdfId,
        "service_id": serviceId,
        "title": title,
        "pdf": pdf,
      };
}
