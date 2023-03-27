import 'package:meta/meta.dart';
import 'dart:convert';

ReservationChartDetailsResponce reservationChartDetailsResponceFromJson(String str) => ReservationChartDetailsResponce.fromJson(json.decode(str));

String reservationChartDetailsResponceToJson(ReservationChartDetailsResponce data) => json.encode(data.toJson());

class ReservationChartDetailsResponce {
  ReservationChartDetailsResponce({
    required this.responseCode,
    required this.responseMessage,
    required this.list,
    required this.busDetails,
  });

  int responseCode;
  String responseMessage;
  List<ListElement> list;
  BusDetails busDetails;

  factory ReservationChartDetailsResponce.fromJson(Map<String, dynamic> json) => ReservationChartDetailsResponce(
    responseCode: json["responseCode"],
    responseMessage: json["responseMessage"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    busDetails: BusDetails.fromJson(json["busDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "responseMessage": responseMessage,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "busDetails": busDetails.toJson(),
  };

  reservationChartDetails(int routeId, String date, int routeViaCityId) {}
}

class BusDetails {
  BusDetails({
    required this.capacity,
    required this.route,
    required this.bus,
    required this.busNo,
    required this.busclass,
    required this.registrationNo,
    required this.driver,
    required this.conductor,
    required this.noOfPassenger,
    required this.date,
    required this.departureTime,
    required this.busDetailsOperator,
    required this.company,
    required this.delay,
    required this.actualdepartureTime,
    required this.shortName,
    required this.totalSeat,
    required this.driverId,
    required this.conductorId,
    required this.coachId,
    required this.inquiryNo,
    required this.inquiryEmail,
  });

  String capacity;
  String route;
  String bus;
  String busNo;
  String busclass;
  String registrationNo;
  String driver;
  String conductor;
  String noOfPassenger;
  String date;
  String departureTime;
  String busDetailsOperator;
  String company;
  String delay;
  String actualdepartureTime;
  String shortName;
  String totalSeat;
  int driverId;
  int conductorId;
  int coachId;
  int inquiryNo;
  String inquiryEmail;

  factory BusDetails.fromJson(Map<String, dynamic> json) => BusDetails(
    capacity: json["capacity"],
    route: json["route"],
    bus: json["bus"],
    busNo: json["busNo"],
    busclass: json["busclass"],
    registrationNo: json["registrationNo"],
    driver: json["driver"],
    conductor: json["conductor"],
    noOfPassenger: json["noOfPassenger"],
    date: json["date"],
    departureTime: json["departureTime"],
    busDetailsOperator: json["operator"],
    company: json["company"],
    delay: json["delay"],
    actualdepartureTime: json["actualdepartureTime"],
    shortName: json["shortName"],
    totalSeat: json["totalSeat"],
    driverId: json["driverId"],
    conductorId: json["conductorId"],
    coachId: json["coachId"],
    inquiryNo: json["inquiryNo"],
    inquiryEmail: json["inquiryEmail"],
  );

  Map<String, dynamic> toJson() => {
    "capacity": capacity,
    "route": route,
    "bus": bus,
    "busNo": busNo,
    "busclass": busclass,
    "registrationNo": registrationNo,
    "driver": driver,
    "conductor": conductor,
    "noOfPassenger": noOfPassenger,
    "date": date,
    "departureTime": departureTime,
    "operator": busDetailsOperator,
    "company": company,
    "delay": delay,
    "actualdepartureTime": actualdepartureTime,
    "shortName": shortName,
    "totalSeat": totalSeat,
    "driverId": driverId,
    "conductorId": conductorId,
    "coachId": coachId,
    "inquiryNo": inquiryNo,
    "inquiryEmail": inquiryEmail,
  };
}

class ListElement {
  ListElement({
    required this.display,
    required this.seatNo,
    required this.bording,
    required this.droping,
    required this.ticketBookingDate,
    required this.pnr,
    required this.ticketDetailsId,
    required this.ticketId,
    required this.seatFare,
    required this.firstName,
    required this.lastName,
    required this.passContact,
    required this.startCity,
    required this.stopCity,
    required this.seller,
    required this.bookStatus,
    required this.rowId,
  });

  dynamic display;
  String seatNo;
  String bording;
  Droping droping;
  String ticketBookingDate;
  String pnr;
  int ticketDetailsId;
  String ticketId;
  String seatFare;
  Droping firstName;
  String lastName;
  String passContact;
  String startCity;
  String stopCity;
  String seller;
  BookStatus bookStatus;
  int rowId;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    display: json["display"],
    seatNo: json["seatNo"],
    bording: json["bording"],
    droping: dropingValues.map[json["droping"]]!,
    ticketBookingDate: json["ticket_booking_date"],
    pnr: json["pnr"],
    ticketDetailsId: json["ticket_details_id"],
    ticketId: json["ticketId"],
    seatFare: json["seatFare"],
    firstName: dropingValues.map[json["firstName"]]!,
    lastName: json["lastName"],
    passContact: json["passContact"],
    startCity: json["startCity"],
    stopCity: json["stopCity"],
    seller: json["seller"],
    bookStatus: bookStatusValues.map[json["bookStatus"]]!,
    rowId: json["rowId"],
  );

  Map<String, dynamic> toJson() => {
    "display": display,
    "seatNo": seatNo,
    "bording": bording,
    "droping": dropingValues.reverse[droping],
    "ticket_booking_date": ticketBookingDate,
    "pnr": pnr,
    "ticket_details_id": ticketDetailsId,
    "ticketId": ticketId,
    "seatFare": seatFare,
    "firstName": dropingValues.reverse[firstName],
    "lastName": lastName,
    "passContact": passContact,
    "startCity": startCity,
    "stopCity": stopCity,
    "seller": seller,
    "bookStatus": bookStatusValues.reverse[bookStatus],
    "rowId": rowId,
  };
}

enum BookStatus { AVAILABLE }

final bookStatusValues = EnumValues({
  "Available": BookStatus.AVAILABLE
});

enum Droping { EMPTY }

final dropingValues = EnumValues({
  " ": Droping.EMPTY
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
