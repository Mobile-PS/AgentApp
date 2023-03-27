// To parse this JSON data, do
//
//     final operatorResponse = operatorResponseFromJson(jsonString);

import 'dart:convert';

OperatorResponse operatorResponseFromJson(String str) =>
    OperatorResponse.fromJson(json.decode(str));

String operatorResponseToJson(OperatorResponse data) =>
    json.encode(data.toJson());

class OperatorResponse {
  OperatorResponse();

  OperatorResponse.params({
    required this.responseCode,
    required this.responseMessage,
    required this.operatorList,
  });

  late int responseCode;
  late String responseMessage;
  late List<OperatorList> operatorList;

  factory OperatorResponse.fromJson(Map<String, dynamic> json) =>
      OperatorResponse.params(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        operatorList: List<OperatorList>.from(
            json["operatorList"].map((x) => OperatorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "operatorList": List<dynamic>.from(operatorList.map((x) => x.toJson())),
      };
}

class OperatorList {
  OperatorList({
    required this.operatorId,
    required this.operatorName,
  });

  int operatorId;
  String operatorName;

  @override
  bool operator ==(dynamic other)
  {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OperatorList &&
            other.operatorId == operatorId &&
            other.operatorName == operatorName);

  }


  @override
  int get hashCode => super.hashCode;

  factory OperatorList.fromJson(Map<String, dynamic> json) => OperatorList(
        operatorId: json["operator_id"],
        operatorName: json["operator_name"],
      );

  Map<String, dynamic> toJson() => {
        "operator_id": operatorId,
        "operator_name": operatorName,
      };
}
