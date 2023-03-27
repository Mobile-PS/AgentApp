import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticket_agent/data/repos/TicketInfoRepository.dart';

import '../../../data/model/ReservationChartDetailsResponce.dart';

part 'manifest_event.dart';
part 'manifest_state.dart';

class ManifestBloc extends Bloc<ManifestEvent, ManifestState> {
  final TicketInfoRepository repository;
  ManifestBloc(this.repository) : super(ManifestInitial()) {
    on<Manifest>((event, emit) async {

      emit(ManifestLoadingState());

      try {

        ReservationChartDetailsResponce? response = await repository.reservationChartDetails(event.routeId, event.date,event.routeViaCityId);
        if (response != null && response?.responseCode == 200) {
          emit(ManifestSuccessState(response));
        }
        else {
          emit(ManifestErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(ManifestErrorState("Something went wrong $e"));
      }

    });
  }
}

