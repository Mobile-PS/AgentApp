part of 'bus_route_bloc.dart';

@immutable
abstract class BusRouteState {}

class BusRouteInitial extends BusRouteState {}


class LoadingState extends BusRouteState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends BusRouteState {

  SuccessState(this.value);
  BusRouteResponse value;


  @override
  List<Object?> get props => [value];
}


class ErrorState extends BusRouteState {
  final String error;

  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class BusDetailsLoadingState extends BusRouteState {
  @override
  List<Object?> get props => [];
}

class BusDetailsSuccessState extends BusRouteState {
  BusDetailsSuccessState(this.value);
  BusDetailResponse value;

  @override
  List<Object?> get props => [value];
}


class BusDetailsErrorState extends BusRouteState {
  final String error;
  BusDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


class BoardingLoadingState extends BusRouteState {
  @override
  List<Object?> get props => [];
}

class BoardingSuccessState extends BusRouteState {
  BoardingSuccessState(this.value);
  BoardingPointsResponse value;

  @override
  List<Object?> get props => [value];
}


class BoardingErrorState extends BusRouteState {
  final String error;
  BoardingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

