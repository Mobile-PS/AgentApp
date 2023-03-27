// To parse this JSON data, do
//
//     final getTicketInfoByPnrResponse = getTicketInfoByPnrResponseFromJson(jsonString);

import 'dart:convert';

GetTicketInfoByPnrResponse? getTicketInfoByPnrResponseFromJson(String str) => GetTicketInfoByPnrResponse.fromJson(json.decode(str));

String getTicketInfoByPnrResponseToJson(GetTicketInfoByPnrResponse? data) => json.encode(data!.toJson());

class GetTicketInfoByPnrResponse {
  GetTicketInfoByPnrResponse({
    this.responseCode,
    this.responseMessage,
    this.pnr,
    this.rctvnum,
    this.paymentSource,
    this.operatorName,
    this.seatCount,
    this.busName,
    this.busNo,
    this.busType,
    this.totalSeats,
    this.ticketBookingDate,
    this.ticketBookingTime,
    this.tripDate,
    this.departureTime,
    this.ticketStatus,
    this.bseatsList,
    this.pickPoint,
    this.dropPoint,
    this.startCity,
    this.stopCity,
    this.name,
    this.description,
    this.inquiryNo,
    this.inquiryEmail,
    this.insuranceTotal,
    this.totalFare,
    this.netFare,
    this.signature,
    this.passenger,
  });

  int? responseCode;
  String? responseMessage;
  String? pnr;
  dynamic rctvnum;
  String? paymentSource;
  String? operatorName;
  String? seatCount;
  String? busName;
  String? busNo;
  String? busType;
  String? totalSeats;
  DateTime? ticketBookingDate;
  String? ticketBookingTime;
  DateTime? tripDate;
  String? departureTime;
  String? ticketStatus;
  String? bseatsList;
  String? pickPoint;
  String? dropPoint;
  String? startCity;
  String? stopCity;
  dynamic name;
  String? description;
  int? inquiryNo;
  String? inquiryEmail;
  dynamic? insuranceTotal;
  dynamic? totalFare;
  dynamic? netFare;
  dynamic signature;
  List<Passenger?>? passenger;

  factory GetTicketInfoByPnrResponse.fromJson(Map<String, dynamic> json) => GetTicketInfoByPnrResponse(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    pnr: json["pnr"],
    rctvnum: json["rctvnum"],
    paymentSource: json["paymentSource"],
    operatorName: json["operatorName"],
    seatCount: json["seat_count"],
    busName: json["busName"],
    busNo: json["busNo"],
    busType: json["bus_type"],
    totalSeats: json["total_seats"],
    ticketBookingDate: DateTime.parse(json["ticket_booking_date"]),
    ticketBookingTime: json["ticket_booking_time"],
    tripDate: DateTime.parse(json["trip_date"]),
    departureTime: json["departure_time"],
    ticketStatus: json["ticket_status"],
    bseatsList: json["bseats_list"],
    pickPoint: json["pick_point"],
    dropPoint: json["drop_point"],
    startCity: json["start_city"],
    stopCity: json["stop_city"],
    name: json["name"],
    description: json["description"],
    inquiryNo: json["inquiryNo"],
    inquiryEmail: json["inquiryEmail"],
    insuranceTotal: json["insuranceTotal"],
    totalFare: json["total_fare"],
    netFare: json["net_fare"],
    signature: json["signature"],
    passenger: json["passenger"] == null ? [] : List<Passenger?>.from(json["passenger"]!.map((x) => Passenger.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "pnr": pnr,
    "rctvnum": rctvnum,
    "paymentSource": paymentSource,
    "operatorName": operatorName,
    "seat_count": seatCount,
    "busName": busName,
    "busNo": busNo,
    "bus_type": busType,
    "total_seats": totalSeats,
    "ticket_booking_date": "${ticketBookingDate!.year.toString().padLeft(4, '0')}-${ticketBookingDate!.month.toString().padLeft(2, '0')}-${ticketBookingDate!.day.toString().padLeft(2, '0')}",
    "ticket_booking_time": ticketBookingTime,
    "trip_date": "${tripDate!.year.toString().padLeft(4, '0')}-${tripDate!.month.toString().padLeft(2, '0')}-${tripDate!.day.toString().padLeft(2, '0')}",
    "departure_time": departureTime,
    "ticket_status": ticketStatus,
    "bseats_list": bseatsList,
    "pick_point": pickPoint,
    "drop_point": dropPoint,
    "start_city": startCity,
    "stop_city": stopCity,
    "name": name,
    "description": description,
    "inquiryNo": inquiryNo,
    "inquiryEmail": inquiryEmail,
    "insuranceTotal": insuranceTotal,
    "total_fare": totalFare,
    "net_fare": netFare,
    "signature": signature,
    "passenger": passenger == null ? [] : List<dynamic>.from(passenger!.map((x) => x!.toJson())),
  };
}

class Passenger {
  Passenger({
    this.id,
    this.ticketId,
    this.firstName,
    this.mobileNo,
    this.email,
    this.idProofType,
    this.idProofNo,
    this.type,
    this.lastName,
    this.seatNo,
    this.seatFare,
    this.seatType,
    this.insurance,
    this.insuranceAmount,
    this.nominee,
    this.nomineeNumber,
    this.policyNumber,
    this.gender,
  });

  int? id;
  int? ticketId;
  String? firstName;
  String? mobileNo;
  String? email;
  dynamic idProofType;
  dynamic idProofNo;
  String? type;
  String? lastName;
  String? seatNo;
  int? seatFare;
  String? seatType;
  dynamic insurance;
  dynamic insuranceAmount;
  dynamic nominee;
  dynamic nomineeNumber;
  dynamic policyNumber;
  dynamic gender;

  factory Passenger.fromJson(Map<String, dynamic> json) => Passenger(
    id: json["id"],
    ticketId: json["ticket_id"],
    firstName: json["firstName"],
    mobileNo: json["mobileNo"],
    email: json["email"],
    idProofType: json["idProofType"],
    idProofNo: json["idProofNo"],
    type: json["type"],
    lastName: json["lastName"],
    seatNo: json["seat_No"],
    seatFare: json["seat_fare"],
    seatType: json["seat_type"],
    insurance: json["insurance"],
    insuranceAmount: json["insuranceAmount"],
    nominee: json["nominee"],
    nomineeNumber: json["nominee_number"],
    policyNumber: json["policy_number"],
    gender: json["gender"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ticket_id": ticketId,
    "firstName": firstName,
    "mobileNo": mobileNo,
    "email": email,
    "idProofType": idProofType,
    "idProofNo": idProofNo,
    "type": type,
    "lastName": lastName,
    "seat_No": seatNo,
    "seat_fare": seatFare,
    "seat_type": seatType,
    "insurance": insurance,
    "insuranceAmount": insuranceAmount,
    "nominee": nominee,
    "nominee_number": nomineeNumber,
    "policy_number": policyNumber,
    "gender": gender,
  };
}
