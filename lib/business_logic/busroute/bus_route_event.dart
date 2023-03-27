part of 'bus_route_bloc.dart';

@immutable
abstract class BusRouteEvent {}

class initEvent extends BusRouteEvent {}

class getBusRoute extends BusRouteEvent {
  int agentId;
  String busType;
  String date;

  int destination;

  String lang;
  int operatorId;
  int source;

  getBusRoute(this.agentId, this.busType, this.date, this.destination,
      this.lang, this.operatorId, this.source);
}

class GetBusDetails extends BusRouteEvent {
  BusDetailRequest busDetailRequest;
  GetBusDetails(this.busDetailRequest);
}

class GetBoardingData extends BusRouteEvent {
  String routeID ;
  String startId;
  String stopId;

  GetBoardingData(this.routeID, this.startId, this.stopId);
}
