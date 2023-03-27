

import 'package:ticket_agent/business_logic/booking/booking_bloc.dart';
import 'package:ticket_agent/data/model/BookingResponse.dart';
import 'package:ticket_agent/data/model/BordingPointsResponce.dart';
import 'package:ticket_agent/data/model/BusDetailRequest.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/data/model/BusRouteResponse.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';

import '../model/bus_layout_filter_response.dart';

class BusRouteRepository {

  final _client = ApiClient();

  Future<BusRouteResponse?>  getBusRoutes(int agentId, String busType,String date , int destination ,String lang, int operatorId,int source) {
    return _client.getBusRoutes(agentId, busType, date, destination, lang, operatorId, source);
  }


  Future<BusDetailResponse?>  getBusDetails(BusDetailRequest busDetailRequest) {
    return _client.getBusDetailsApi(busDetailRequest);
  }

  Future<BoardingPointsResponse?>  getBoardingPoints(String routeID , String startId,String stopId) {
    return _client.bordingPointsApi(routeID,startId,stopId);
  }
  Future<BookingResponse?>  saveTicketDetails(BookingRequest request) {
    return _client.BookingApi(request);
  }

}
