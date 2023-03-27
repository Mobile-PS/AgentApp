
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/data/model/CancleTicketResponse.dart';

import '../../data/repos/TicketInfoRepository.dart';
import 'cancel_ticket_event.dart';
import 'cancel_ticket_state.dart';


class CancelTicketBloc extends Bloc<CancelTicketEvent, CancelTicketState> {
  final TicketInfoRepository repository;
  CancelTicketBloc(this.repository) : super(CancelTicketInitial()) {
    on<CancelTicket>((event, emit) async {

      emit(CancelLoadingState());

      try {

        CancleTicketResponse? response = await repository.cancelTicket(event.pnr, event.agentId);
        if (response != null && response?.responseCode == 200) {
          emit(CancelSuccessState(response));
        }
        else {
          emit(CancelErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(CancelErrorState("Something went wrong $e"));
      }

    });
  }
}
