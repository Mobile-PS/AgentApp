import 'package:meta/meta.dart';
import 'dart:convert';

BoardingPointsResponse bordingPointsResponceFromJson(String str) => BoardingPointsResponse.fromJson(json.decode(str));

String bordingPointsResponceToJson(BoardingPointsResponse data) => json.encode(data.toJson());

class BoardingPointsResponse {
  BoardingPointsResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.boardingPoint,
    required this.droppingPoint,
  });

  final int responseCode;
  final String responseMessage;
  final List<IngPoint> boardingPoint;
  final List<IngPoint> droppingPoint;

  factory BoardingPointsResponse.fromJson(Map<String, dynamic> json) => BoardingPointsResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    boardingPoint: List<IngPoint>.from(json["boardingPoint"].map((x) => IngPoint.fromJson(x))),
    droppingPoint: List<IngPoint>.from(json["droppingPoint"].map((x) => IngPoint.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "boardingPoint": List<dynamic>.from(boardingPoint.map((x) => x.toJson())),
    "droppingPoint": List<dynamic>.from(droppingPoint.map((x) => x.toJson())),
  };
}

class IngPoint {
  IngPoint({
    required this.location,
    required this.address,
    required this.arrivalTime,
    required this.ispick,
    required this.contactPerson,
    required this.contactNo,
    required this.pointId,
    required this.selected,
  });

  final String location;
  final String address;
  final String arrivalTime;
  final String ispick;
  final String contactPerson;
  final String contactNo;
  final int pointId;
  final bool selected;

  factory IngPoint.fromJson(Map<String, dynamic> json) => IngPoint(
    location: json["location"],
    address: json["address"],
    arrivalTime: json["arrivalTime"],
    ispick: json["ispick"],
    contactPerson: json["contactPerson"],
    contactNo: json["contactNo"],
    pointId: json["pointId"],
    selected: json["selected"],
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "address": address,
    "arrivalTime": arrivalTime,
    "ispick": ispick,
    "contactPerson": contactPerson,
    "contactNo": contactNo,
    "pointId": pointId,
    "selected": selected,
  };
}
