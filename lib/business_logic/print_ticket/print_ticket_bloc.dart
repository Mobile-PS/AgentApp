import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ticket_agent/data/model/GetTicketInfoByPNRResponse.dart';

import '../../data/repos/TicketInfoRepository.dart';

part 'print_ticket_event.dart';
part 'print_ticket_state.dart';

class PrintTicketBloc extends Bloc<PrintTicketEvent, PrintTicketState> {
  final TicketInfoRepository repository;
  PrintTicketBloc(this.repository) : super(PrintTicketInitial()) {
    on<GetTicketDetailsByPNR>((event, emit) async {
      emit(PrintLoadingState());

      try {

        GetTicketInfoByPnrResponse? response = await repository.getTicketInfoByPNR(event.pnr,event.lang,event.agentType);
        if (response != null && response?.responseCode == 200) {
          emit(PrintSuccessState(response));
        }
        else {
          emit(PrintErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(PrintErrorState("Something went wrong $e"));
      }

    });
  }
}
