class Subscriptions {
  List<Data>? data;
  String? code;
  String? message;

  Subscriptions({this.data, this.code, this.message});

  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return Subscriptions(
      data: json['plan_list'] != null
          ? (json['plan_list'] as List).map((i) => Data.fromJson(i)).toList()
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
      data['plan_list'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {

  String? plan_name;
  String? service_name;
  String? amount;
  String? subscribe_end_date;
  String? plan_status;

  Data(
      {
      this.plan_name,
      this.service_name,
      this.amount,
      this.subscribe_end_date,
      this.plan_status,
      });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      plan_name: json['plan_name'],
      service_name: json['service_name'],
      amount: json['amount'],
      subscribe_end_date: json['subscribe_end_date'],
      plan_status: json['plan_status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_name'] = this.plan_name;
    data['service_name'] = this.service_name;
    data['amount'] = this.amount;
    data['subscribe_end_date'] = this.subscribe_end_date;
    data['plan_status'] = this.plan_status;
    return data;
  }
}
