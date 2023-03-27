class BusRoute {

  BusRoute();
  BusRoute.params({
    required this.routeId,
    required this.routeViaCityId,
    required this.routeName,
    required this.source,
    required this.sourceName,
    required this.destinationName,
    required this.buslayoutId,
    required this.operatorId,
    required this.operatorName,
    required this.inquiryNo,
    required this.inquiryEmail,
    required this.label,
    required this.routeId1,
    required this.routeViaCityId1,
    required this.coachId,
    required this.coachNumber,
    required this.destination,
    required this.date,
    required this.arrivalTime,
    required this.departureTime,
    required this.totalSeat,
    required this.availableSeat,
    required this.fare,
    required this.busType,
  });

  late int routeId;
  late int routeViaCityId;
  late String routeName;
  late int source;
  late String sourceName;
  late String destinationName;
  late int buslayoutId;
  late  int operatorId;
  late  String operatorName;
  late String inquiryNo;
  late String inquiryEmail;
  late String label;
  late int routeId1;
  late int routeViaCityId1;
  late int coachId;
  late String coachNumber;
  late int destination;
  late DateTime date;
  late String arrivalTime;
  late String departureTime;
  late String totalSeat;
  late int availableSeat;
  var fare;
  late String busType;

  factory BusRoute.fromJson(Map<String, dynamic> json) => BusRoute.params(
    routeId: json["routeId"],
    routeViaCityId: json["routeViaCityId"],
    routeName: json["routeName"],
    source: json["source"],
    sourceName: json["sourceName"],
    destinationName: json["destinationName"],
    buslayoutId: json["buslayoutId"],
    operatorId: json["operatorId"],
    operatorName: json["operatorName"],
    inquiryNo: json["inquiryNo"],
    inquiryEmail: json["inquiryEmail"],
    label: json["label"],
    routeId1: json["routeId1"],
    routeViaCityId1: json["routeViaCityId1"],
    coachId: json["coachId"],
    coachNumber: json["coachNumber"],
    destination: json["destination"],
    date: DateTime.parse(json["date"]),
    arrivalTime: json["arrivalTime"],
    departureTime: json["departureTime"],
    totalSeat: json["totalSeat"],
    availableSeat: json["availableSeat"],
    fare: json["fare"],
    busType: json["busType"],
  );

  Map<String, dynamic> toJson() => {
    "routeId": routeId,
    "routeViaCityId": routeViaCityId,
    "routeName": routeName,
    "source": source,
    "sourceName": sourceName,
    "destinationName": destinationName,
    "buslayoutId": buslayoutId,
    "operatorId": operatorId,
    "operatorName": operatorName,
    "inquiryNo": inquiryNo,
    "inquiryEmail": inquiryEmail,
    "label": label,
    "routeId1": routeId1,
    "routeViaCityId1": routeViaCityId1,
    "coachId": coachId,
    "coachNumber": coachNumber,
    "destination": destination,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "arrivalTime": arrivalTime,
    "departureTime": departureTime,
    "totalSeat": totalSeat,
    "availableSeat": availableSeat,
    "fare": fare,
    "busType": busType,
  };


}
