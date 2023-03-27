// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BusLayoutFilterResponse {
  BusLayoutFilterResponse({
      this.responseCode,
      this.responseMessage,
      this.busTypeList
  });

  int? responseCode;
  String? responseMessage;
  List<BusTypeList>? busTypeList;

  factory BusLayoutFilterResponse.fromJson(String str) => BusLayoutFilterResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusLayoutFilterResponse.fromMap(Map<String, dynamic> json) => BusLayoutFilterResponse(
    responseCode: json["responseCode"] == null ? null : json["responseCode"],
    responseMessage: json["responseMessage"] == null ? null : json["responseMessage"],
    busTypeList: json["busTypeList"] == null ? null : List<BusTypeList>.from(json["busTypeList"].map((x) => BusTypeList.fromMap(x))),

  );



  Map<String, dynamic> toMap() => {
    "responseCode": responseCode == null ? null : responseCode,
    "responseMessage": responseMessage == null ? null : responseMessage,
    "busTypeList": busTypeList == null ? null : List<dynamic>.from(busTypeList!.map((x) => x.toMap()))
  };
}

class BusTypeList extends Equatable
{
  int? busId;

  BusTypeList({
      this.busId,
      this.busType});

  String? busType;

  @override
  bool operator ==(dynamic other)
      {
  return identical(this, other) ||
  (other.runtimeType == runtimeType &&
  other is BusTypeList &&
  other.busId == busId &&
  other.busType == busType);

      }

  @override
  int get hashCode => super.hashCode;

  factory BusTypeList.fromJson(String str) => BusTypeList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BusTypeList.fromMap(Map<String, dynamic> json) => BusTypeList(
      busId: json["bus_id"] == null ? null : json["bus_id"],
      busType: json["bus_type"] == null ? null : json["bus_type"]
  );

  Map<String, dynamic> toMap() => {
    "bus_id": busId == null ? null : busId,
    "bus_type": busType == null ? null : busType,
  };

  @override
  List<Object?> get props => [busId];

}
