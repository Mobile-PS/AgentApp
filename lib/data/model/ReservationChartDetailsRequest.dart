import 'package:meta/meta.dart';
import 'dart:convert';

ReservationChartDetailsRequest reservationChartDetailsRequestFromJson(String str) => ReservationChartDetailsRequest.fromJson(json.decode(str));

String reservationChartDetailsRequestToJson(ReservationChartDetailsRequest data) => json.encode(data.toJson());

class ReservationChartDetailsRequest {
  ReservationChartDetailsRequest({
    required this.routeId,
    required this.date,
    required this.routeViaCityId,
  });

  int routeId;
  DateTime date;
  int routeViaCityId;

  factory ReservationChartDetailsRequest.fromJson(Map<String, dynamic> json) => ReservationChartDetailsRequest(
    routeId: json["routeId"],
    date: DateTime.parse(json["date"]),
    routeViaCityId: json["routeViaCityId"],
  );

  Map<String, dynamic> toJson() => {
    "routeId": routeId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "routeViaCityId": routeViaCityId,
  };
}
