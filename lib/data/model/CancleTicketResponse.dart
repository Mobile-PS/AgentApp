import 'package:meta/meta.dart';
import 'dart:convert';

CancleTicketResponse cancleTicketResponseFromJson(String str) => CancleTicketResponse.fromJson(json.decode(str));

String cancleTicketResponseToJson(CancleTicketResponse data) => json.encode(data.toJson());

class CancleTicketResponse {
  CancleTicketResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.fine,
    required this.passengerList,
  });

  int responseCode;
  String responseMessage;
  int fine;
  dynamic passengerList;

  factory CancleTicketResponse.fromJson(Map<String, dynamic> json) => CancleTicketResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    fine: json["fine"],
    passengerList: json["passengerList"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "fine": fine,
    "passengerList": passengerList,
  };
}