// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) => BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) => json.encode(data.toJson());

class BookingResponse {
  BookingResponse({
    this.responseCode,
    this.responseMessage,
    this.ticketId,
    this.refId,
    this.insuranceTotal,
    this.total,
    this.grandTotal,
  });

  int? responseCode;
  String? responseMessage;
  int? ticketId;
  dynamic? refId;
  dynamic? insuranceTotal;
  int? total;
  int? grandTotal;

  factory BookingResponse.fromJson(Map<String, dynamic> json) => BookingResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    ticketId: json["ticketId"],
    refId: json["refId"],
    insuranceTotal: json["insuranceTotal"],
    total: json["total"],
    grandTotal: json["grandTotal"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "ticketId": ticketId,
    "refId": refId,
    "insuranceTotal": insuranceTotal,
    "total": total,
    "grandTotal": grandTotal,
  };
}
