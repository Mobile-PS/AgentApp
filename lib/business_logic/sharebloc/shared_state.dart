part of 'shared_bloc.dart';

abstract class SharedState extends Equatable {
  const SharedState();
}

class SharedInitial extends SharedState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SharedState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends SharedState {
  SuccessState(this.value);

  BusLayoutFilterResponse value;

  @override
  List<Object?> get props => [value];
}

class CityLoadedState extends SharedState {
  CityLoadedState(this.value);
  CityResponse value;
  @override
  List<Object?> get props => [value];
}


class ErrorState extends SharedState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
