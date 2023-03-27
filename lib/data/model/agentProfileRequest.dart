// To parse this JSON data, do
//
//     final agentProfileRequest = agentProfileRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AgentProfileRequest agentProfileRequestFromJson(String str) => AgentProfileRequest.fromJson(json.decode(str));

String agentProfileRequestToJson(AgentProfileRequest data) => json.encode(data.toJson());

class AgentProfileRequest {
  AgentProfileRequest({
    required this.agentId,
  });

  int agentId;

  factory AgentProfileRequest.fromJson(Map<String, dynamic> json) => AgentProfileRequest(
    agentId: json["agent_id"],
  );

  Map<String, dynamic> toJson() => {
    "agent_id": agentId,
  };
}
