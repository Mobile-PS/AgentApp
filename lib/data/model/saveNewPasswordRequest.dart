// To parse this JSON data, do
//
//     final saveNewPasswordRequest = saveNewPasswordRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SaveNewPasswordRequest saveNewPasswordRequestFromJson(String str) => SaveNewPasswordRequest.fromJson(json.decode(str));

String saveNewPasswordRequestToJson(SaveNewPasswordRequest data) => json.encode(data.toJson());

class SaveNewPasswordRequest {
  SaveNewPasswordRequest({
    required this.username,
    required this.agentId,
    required this.newPassword,
    required this.confirmPassword,
    required this.otp,
  });

  String username;
  int agentId;
  String newPassword;
  String confirmPassword;
  String otp;

  factory SaveNewPasswordRequest.fromJson(Map<String, dynamic> json) => SaveNewPasswordRequest(
    username: json["username"],
    agentId: json["agent_id"],
    newPassword: json["new_password"],
    confirmPassword: json["confirm_password"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "agent_id": agentId,
    "new_password": newPassword,
    "confirm_password": confirmPassword,
    "otp": otp,
  };
}
