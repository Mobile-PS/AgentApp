part of 'manifest_bloc.dart';

@immutable
abstract class ManifestState {}

class ManifestInitial extends ManifestState {
  @override
  List<Object?> get props => [];
}

class ManifestLoadingState extends ManifestState {
  @override
  List<Object?> get props => [];
}

 class ManifestSuccessState extends ManifestState{

  late final ReservationChartDetailsResponce reservationChartDetailsResponce;
  ManifestSuccessState(this.reservationChartDetailsResponce);
  @override
  List<Object?> get props =>[reservationChartDetailsResponce];

}

class ManifestErrorState extends  ManifestState {
  final String error;
  ManifestErrorState(this.error);
  @override
  List<Object?> get props => [error];
}



