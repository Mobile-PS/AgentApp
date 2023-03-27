

import 'package:meta/meta.dart';
import 'dart:convert';

SaveTicketResponse saveTicketResponseFromJson(String str) => SaveTicketResponse.fromJson(json.decode(str));

String saveTicketResponseToJson(SaveTicketResponse data) => json.encode(data.toJson());

class SaveTicketResponse {
  SaveTicketResponse({
    required this.responseCode,
    required this.responseMessage,
    required this.ticketId,
    required this.refId,
    required this.insuranceTotal,
    required this.total,
    required this.grandTotal,
  });

  final int responseCode;
  final String responseMessage;
  final int ticketId;
  final dynamic refId;
  final int insuranceTotal;
  final int total;
  final int grandTotal;

  factory SaveTicketResponse.fromJson(Map<String, dynamic> json) => SaveTicketResponse(
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
