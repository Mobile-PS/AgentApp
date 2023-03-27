// To parse this JSON data, do
//
//     final changePasswordResponse = changePasswordResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangePasswordResponse changePasswordResponseFromJson(String str) => ChangePasswordResponse.fromJson(json.decode(str));

String changePasswordResponseToJson(ChangePasswordResponse data) => json.encode(data.toJson());

class ChangePasswordResponse {
  ChangePasswordResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.agentId,
  });

  int responseCode;
  String responseMessage;
  int agentId;

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) => ChangePasswordResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    agentId: json["agent_id"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "agent_id": agentId,
  };
}
