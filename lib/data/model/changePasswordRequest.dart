
// To parse this JSON data, do
//
//     final changePasswordReqest = changePasswordReqestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChangePasswordReqest changePasswordReqestFromJson(String str) => ChangePasswordReqest.fromJson(json.decode(str));

String changePasswordReqestToJson(ChangePasswordReqest data) => json.encode(data.toJson());

class ChangePasswordReqest {
  ChangePasswordReqest({
    required this.agentId,
    required this.username,
    required this.oldPassword,
    required this.newPassword,
  });

  int agentId;
  String username;
  String oldPassword;
  String newPassword;

  factory ChangePasswordReqest.fromJson(Map<String, dynamic> json) => ChangePasswordReqest(
    agentId: json["agent_id"],
    username: json["username"],
    oldPassword: json["old_password"],
    newPassword: json["new_password"],
  );

  Map<String, dynamic> toJson() => {
    "agent_id": agentId,
    "username": username,
    "old_password": oldPassword,
    "new_password": newPassword,
  };
}
