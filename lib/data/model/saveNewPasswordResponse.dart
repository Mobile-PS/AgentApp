// To parse this JSON data, do
//
//     final saveNewPasswordResponse = saveNewPasswordResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaveNewPasswordResponse saveNewPasswordResponseFromJson(String str) => SaveNewPasswordResponse.fromJson(json.decode(str));

String saveNewPasswordResponseToJson(SaveNewPasswordResponse data) => json.encode(data.toJson());

class SaveNewPasswordResponse {
  SaveNewPasswordResponse({
    required this.responseCode,
    required this.responseMessage,
  });

  int responseCode;
  String responseMessage;

  factory SaveNewPasswordResponse.fromJson(Map<String, dynamic> json) => SaveNewPasswordResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
  };
}
