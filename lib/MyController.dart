

import 'package:get/get.dart';
import 'package:ticket_agent/data/model/BordingPointsResponce.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/data/model/BusRoute.dart';

import 'data/model/PassangerInfoModel.dart';
import 'data/model/booking_req.dart';
import 'data/model/city_response.dart';
import 'data/model/seat_number.dart';

class MyController extends GetxController
{
  BusRoute? selectedBus;
  CityItem? source;
  CityItem? destination;
  int selectedIndex = 0;
  int? boardingItemSelected;
  int? droppingItemSelected;
  IngPoint? selectedBoardingPoint;
  IngPoint? selectedDroppingPoint;
  bool isManifest = false;
  String busType ="all";
  var selectedDate;
  int operatorId=0;
  RxSet<SeatNumber> selectedSeats = RxSet();
  Rx<BusDetailResponse> response= BusDetailResponse().obs;
  List<PassengerList> passangerList = List.empty(growable: true);
  List<BusLayout> selectedList = List.empty(growable: true);
  String seatno = "";




}