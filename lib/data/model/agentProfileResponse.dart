// To parse this JSON data, do
//
//     final agentProfileResponse = agentProfileResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AgentProfileResponse agentProfileResponseFromJson(String str) => AgentProfileResponse.fromJson(json.decode(str));

String agentProfileResponseToJson(AgentProfileResponse data) => json.encode(data.toJson());

class AgentProfileResponse {
  AgentProfileResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.agentId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.email,
    required this.contactNo,
    required this.agentType,
  });

  int responseCode;
  String responseMessage;
  int agentId;
  String firstName;
  String lastName;
  String address;
  String email;
  String contactNo;
  String agentType;

  factory AgentProfileResponse.fromJson(Map<String, dynamic> json) => AgentProfileResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    agentId: json["agent_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    address: json["address"],
    email: json["email"],
    contactNo: json["contact_no"],
    agentType: json["agent_type"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "agent_id": agentId,
    "first_name": firstName,
    "last_name": lastName,
    "address": address,
    "email": email,
    "contact_no": contactNo,
    "agent_type": agentType,
  };
}
