

import 'package:meta/meta.dart';
import 'dart:convert';

ForgotPasswordResponse forgotPasswordResponseFromJson(String str) => ForgotPasswordResponse.fromJson(json.decode(str));

String forgotPasswordResponseToJson(ForgotPasswordResponse data) => json.encode(data.toJson());

class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.username,
    required this.id,
  });

  int responseCode;
  String responseMessage;
  String username;
  int id;

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => ForgotPasswordResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    username: json["username"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "username": username,
    "id": id,
  };
}
