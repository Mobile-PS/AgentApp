// To parse this JSON data, do
//
//     final busRouteResponse = busRouteResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:ticket_agent/data/model/BusRoute.dart';

BusRouteResponse busRouteResponseFromJson(String str) => BusRouteResponse.fromJson(json.decode(str));

String busRouteResponseToJson(BusRouteResponse data) => json.encode(data.toJson());

class BusRouteResponse {
  BusRouteResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.list,
  });

  final int responseCode;
  final String responseMessage;
  final List<BusRoute> list;

  factory BusRouteResponse.fromJson(Map<String, dynamic> json) => BusRouteResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    list: List<BusRoute>.from(json["list"].map((x) => BusRoute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

