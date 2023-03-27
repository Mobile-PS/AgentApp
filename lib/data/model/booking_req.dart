// To parse this JSON data, do
//
//     final bookingRequest = bookingRequestFromJson(jsonString);

import 'dart:convert';

import 'PassangerInfoModel.dart';

BookingRequest bookingRequestFromJson(String str) =>
    BookingRequest.fromJson(json.decode(str));

String bookingRequestToJson(BookingRequest data) => json.encode(data.toJson());

class BookingRequest {
  BookingRequest({
    this.agentType,
    this.insuranceTieup,
    this.label,
    this.lang,
    this.masterrouteId,
    this.masterrouteviaId,
    this.operatorName,
    this.passengerList,
    this.primaryInfo,
  });

  String? agentType;
  bool? insuranceTieup;
  String? label;
  String? lang;
  int? masterrouteId;
  int? masterrouteviaId;
  String? operatorName;
  List<PassengerList>? passengerList;
  PrimaryInfo? primaryInfo;

  factory BookingRequest.fromJson(Map<String, dynamic> json) => BookingRequest(
        agentType: json["agent_type"],
        insuranceTieup: json["insuranceTieup"],
        label: json["label"],
        lang: json["lang"],
        masterrouteId: json["masterrouteId"],
        masterrouteviaId: json["masterrouteviaId"],
        operatorName: json["operatorName"],
        passengerList: List<PassengerList>.from(
            json["passengerList"].map((x) => PassengerList.fromJson(x))),
        primaryInfo: PrimaryInfo.fromJson(json["primaryInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "agent_type": agentType,
        "insuranceTieup": insuranceTieup,
        "label": label,
        "lang": lang,
        "masterrouteId": masterrouteId,
        "masterrouteviaId": masterrouteviaId,
        "operatorName": operatorName,
        "passengerList": List.from(passengerList!.map((x) => x.toJson())),
        "primaryInfo": primaryInfo?.toJson(),
      };
}

class PassengerList {
  PassengerList.param(this.id);

  PassengerList({
    this.id,
    required this.email,
    required this.firstName,
    required this.gender,
    required this.idProofType,
    this.insurance,
    this.insuranceAmount,
    required this.lastName,
    required this.mobileNo,
    this.nominee,
    this.nomineeNumber,
    this.seatFare,
    required this.seatNo,
    required this.seatType,
    this.type,
  });

  int? id;
  String? email;
  String? firstName;
  String? gender;
  String? idProofType;
  String? insurance;
  int? insuranceAmount;
  String? lastName;
  String? mobileNo;
  String? nominee;
  String? nomineeNumber;
  int? seatFare;
  String? seatNo;
  String? seatType;
  String? type;

  factory PassengerList.fromJson(Map<String, dynamic> json) => PassengerList(
        email: json['email'],
        firstName: json['firstName'],
        gender: json['gender'],
        idProofType: json['idProofType'],
        insurance: json['insurance'],
        insuranceAmount: json['insuranceAmount'],
        lastName: json['lastName'],
        mobileNo: json['mobileNo'],
        nominee: json['nominee'],
        nomineeNumber: json['nominee_number'],
        seatFare: json['seat_fare'],
        seatNo: json['seat_No'],
        seatType: json['seat_type'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "idProofType": idProofType,
        "insurance": insurance,
        "insuranceAmount": insuranceAmount,
        "lastName": lastName,
        "mobileNo": mobileNo,
        "nominee": nominee,
        "nominee_number": nomineeNumber,
        "seat_fare": seatFare,
        "seat_No": seatNo,
        "seat_type": seatType,
        "type": type,
        "gender": gender,
      };
}

class PrimaryInfo {
  PrimaryInfo({
    this.agentId,
    this.arrivalTime,
    this.departureTime,
    this.discount,
    this.dropPoint,
    this.isOperator,
    this.operatorId,
    this.passengerId,
    this.paymentGateway,
    this.paymentSource,
    this.pickPoint,
    this.fkRouteid,
    this.fkRouteViaCityId,
    this.seatCount,
    this.bseatsList,
    this.startCityId,
    this.stopCityId,
    this.totalFare,
    this.ticketSource,
    this.ticketStatus,
    this.tripDate,
  });

  int? agentId;
  String? arrivalTime;
  String? departureTime;
  int? discount;
  int? dropPoint;
  bool? isOperator;
  int? operatorId;
  int? passengerId;
  String? paymentGateway;
  String? paymentSource;
  int? pickPoint;
  int? fkRouteid;
  int? fkRouteViaCityId;
  int? seatCount;
  String? bseatsList;
  int? startCityId;
  int? stopCityId;
  int? totalFare;
  String? ticketSource;
  String? ticketStatus;
  DateTime? tripDate;

  factory PrimaryInfo.fromJson(Map<String, dynamic> json) => PrimaryInfo(
        agentId: json["agent_id"],
        arrivalTime: json["arrival_time"],
        departureTime: json["departure_time"],
        discount: json["discount"],
        dropPoint: json["drop_point"],
        isOperator: json["is_operator"],
        operatorId: json["operator_id"],
        passengerId: json["passenger_id"],
        paymentGateway: json["payment_gateway"],
        paymentSource: json["payment_source"],
        pickPoint: json["pick_point"],
        fkRouteid: json["fk_routeid"],
        fkRouteViaCityId: json["fk_route_via_city_Id"],
        seatCount: json["seat_count"],
        bseatsList: json["bseats_list"],
        startCityId: json["start_city_id"],
        stopCityId: json["stop_city_id"],
        totalFare: json["total_fare"],
        ticketSource: json["ticket_source"],
        ticketStatus: json["ticket_status"],
        tripDate: DateTime.parse(json["trip_date"]),
      );

  Map<String, dynamic> toJson() => {
        "agent_id": agentId,
        "arrival_time": arrivalTime,
        "departure_time": departureTime,
        "discount": discount,
        "drop_point": dropPoint,
        "is_operator": isOperator,
        "operator_id": operatorId,
        "passenger_id": passengerId,
        "payment_gateway": paymentGateway,
        "payment_source": paymentSource,
        "pick_point": pickPoint,
        "fk_routeid": fkRouteid,
        "fk_route_via_city_Id": fkRouteViaCityId,
        "seat_count": seatCount,
        "bseats_list": bseatsList,
        "start_city_id": startCityId,
        "stop_city_id": stopCityId,
        "total_fare": totalFare,
        "ticket_source": ticketSource,
        "ticket_status": ticketStatus,
        "trip_date":
            "${tripDate!.year.toString().padLeft(4, '0')}-${tripDate!.month.toString().padLeft(2, '0')}-${tripDate!.day.toString().padLeft(2, '0')}",
      };
}
