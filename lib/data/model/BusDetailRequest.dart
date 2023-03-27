import 'package:meta/meta.dart';
import 'dart:convert';

BusDetailRequest busDetailRequestFromJson(String str) => BusDetailRequest.fromJson(json.decode(str));

String busDetailRequestToJson(BusDetailRequest data) => json.encode(data.toJson());

class BusDetailRequest {
  BusDetailRequest({
    required this.agentId,
    required this.agentType,
    required this.arrivalTime,
    required this.busLayoutId,
    required this.coachId,
    required this.date,
    required this.departureTime,
    required this.endId,
    required this.label,
    required this.lang,
    required this.routeId,
    required this.routeId1,
    required this.routeViacityId,
    required this.routeViacityId1,
    required this.startId,
  });

  final int agentId;
  final String agentType;
  final String arrivalTime;
  final String busLayoutId;
  final String coachId;
  final DateTime date;
  final String departureTime;
  final String endId;
  final String label;
  final String lang;
  final String routeId;
  final String routeId1;
  final String routeViacityId;
  final int routeViacityId1;
  final String startId;

  factory BusDetailRequest.fromJson(Map<String, dynamic> json) => BusDetailRequest(
    agentId: json["agentId"],
    agentType: json["agent_type"],
    arrivalTime: json["arrivalTime"],
    busLayoutId: json["busLayoutId"],
    coachId: json["coachId"],
    date: DateTime.parse(json["date"]),
    departureTime: json["departureTime"],
    endId: json["endId"],
    label: json["label"],
    lang: json["lang"],
    routeId: json["routeId"],
    routeId1: json["routeId1"],
    routeViacityId: json["routeViacityId"],
    routeViacityId1: json["routeViacityId1"],
    startId: json["startId"],
  );

  Map<String, dynamic> toJson() => {
    "agentId": agentId,
     "agent_type": agentType,
    "arrivalTime": arrivalTime,
    "busLayoutId": busLayoutId,
    "coachId": coachId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "departureTime": departureTime,
    "endId": endId,
    "label": label,
    "lang": lang,
    "routeId": routeId,
    "routeId1": routeId1,
    "routeViacityId": routeViacityId,
    "routeViacityId1": routeViacityId1,
    "startId": startId,
  };
}
