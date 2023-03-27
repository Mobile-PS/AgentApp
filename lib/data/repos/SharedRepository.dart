

import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/city_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/services/ApiClient.dart';

import '../model/bus_layout_filter_response.dart';

class SharedRepository {

  final _client = ApiClient();

  Future<BusLayoutFilterResponse?> getBusFilters() {
    return _client.getBusLayoutFilters();
  }


  Future<OperatorResponse?> getOperators(int agentId) {
    return _client.getOperatorList(agentId);
  }
  Future<CityResponse?> getCities() {
    return _client.getCities();
  }


}
