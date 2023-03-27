

import 'package:ticket_agent/data/model/GetTicketInfoByPNRResponse.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';

import '../model/CancleTicketResponse.dart';
import '../model/CancleTicketResponse.dart';
import '../model/ReservationChartDetailsResponce.dart';
import '../model/bus_layout_filter_response.dart';

class TicketInfoRepository {

  final _client = ApiClient();

  Future<GetTicketInfoByPnrResponse?> getTicketInfoByPNR(String pnr , String lang , String agentType) {
    return _client.getTicketInfoByPNR(pnr,lang,agentType);
  }


  Future<CancleTicketResponse?> cancelTicket(String pnr , int agentId) {
    return _client.cancelTicketApi(pnr,agentId);
  }

  Future<ReservationChartDetailsResponce?> reservationChartDetails(int routeId,String date,int routeViaCityId) {
    return _client.reservationChartDetailsApi(routeId,date,routeViaCityId);
  }



}
