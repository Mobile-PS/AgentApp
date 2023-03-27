// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BusDetailResponse welcomeFromJson(String str) =>
    BusDetailResponse.fromJson(json.decode(str));

String welcomeToJson(BusDetailResponse data) => json.encode(data.toJson());

class BusDetailResponse {
  BusDetailResponse({
    this.responseCode,
    this.responseMessage,
    this.bookSeatList,
    this.rowCount,
    this.discount,
    this.columnCount,
    this.fare,
    this.totalSeat,
    this.amenities,
    this.label,
    this.routeId1,
    this.routeViaId1,
    this.busName,
    this.busNo,
    this.startId,
    this.stopId,
    this.insuranceAmount,
    this.busLayout,
  });

  int? responseCode;
  String? responseMessage;
  List<dynamic>? bookSeatList;
  int? rowCount;
  String? discount;
  int? columnCount;
  double? fare;
  String? totalSeat;
  Amenities? amenities;
  String? label;
  int? routeId1;
  int? routeViaId1;
  String? busName;
  String? busNo;
  int? startId;
  int? stopId;
  double? insuranceAmount;
  List<BusLayout>? busLayout;

  factory BusDetailResponse.fromJson(Map<String, dynamic> json) =>
      BusDetailResponse(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        bookSeatList: json["bookSeatList"] == null
            ? null
            : List<dynamic>.from(json["bookSeatList"].map((x) => x)),
        rowCount: json["rowCount"],
        discount: json["discount"],
        columnCount: json["columnCount"],
        fare: double.parse(json["fare"].toString()),
        totalSeat: json["totalSeat"],
        amenities: Amenities.fromJson(json["amenities"]),
        label: json["label"],
        routeId1: json["routeId1"],
        routeViaId1: json["routeViaId1"],
        busName: json["busName"],
        busNo: json["busNo"],
        startId: json["startId"],
        stopId: json["stopId"],
        insuranceAmount: json["insuranceAmount"],
        busLayout: List<BusLayout>.from(
            json["busLayout"].map((x) => BusLayout.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "bookSeatList": List<dynamic>.from(bookSeatList!.map((x) => x)),
        "rowCount": rowCount,
        "discount": discount,
        "columnCount": columnCount,
        "fare": fare,
        "totalSeat": totalSeat,
        "amenities": amenities!.toJson(),
        "label": label,
        "routeId1": routeId1,
        "routeViaId1": routeViaId1,
        "busName": busName,
        "busNo": busNo,
        "startId": startId,
        "stopId": stopId,
        "insuranceAmount": insuranceAmount,
        "busLayout": List<dynamic>.from(busLayout!.map((x) => x.toJson())),
      };
}

class Amenities {
  Amenities({
    this.wifi,
    this.ac,
    this.video,
  });

  String? wifi;
  String? ac;
  String? video;

  factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        wifi: json["wifi"],
        ac: json["ac"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "wifi": wifi,
        "ac": ac,
        "video": video,
      };
}

class BusLayout {
  BusLayout({
    this.seatType,
    this.rowNo,
    this.colNo,
    this.seatNo,
    this.isSeat,
    this.seatFare,
  });

  String? seatType;
  String? rowNo;
  String? colNo;
  String? seatNo;
  bool? isSeat;
  double? seatFare;

  factory BusLayout.fromJson(Map<String, dynamic> json) => BusLayout(
        seatType: json["seatType"],
        rowNo: json["rowNo"],
        colNo: json["colNo"],
        seatNo: json["seatNO"],
        isSeat: json["isSeat"],
        seatFare: json["seatFare"],
      );

  Map<String, dynamic> toJson() => {
        "seatType": seatType,
        "rowNo": rowNo,
        "colNo": colNo,
        "seatNO": seatNo,
        "isSeat": isSeat,
        "seatFare": seatFare,
      };
}
