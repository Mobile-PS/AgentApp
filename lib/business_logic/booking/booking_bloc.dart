
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticket_agent/data/model/BookingResponse.dart';
import 'package:ticket_agent/data/model/BordingPointsResponce.dart';
import 'package:ticket_agent/data/model/BusDetailRequest.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/data/model/booking_req.dart';
import 'package:ticket_agent/data/repos/BusRouteRepository.dart';

import '../../data/model/BookingResponse.dart';
import '../../data/model/BusRouteResponse.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';
import '../../data/model/booking_req.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<bookingEvent, BookingState> {
  BusRouteRepository repo;

  BookingBloc(this.repo) : super(BookingInitial()) {

    on<Getbooking>((event, emit) async {
      emit(BookingLoadingState());
      try
          {
            BookingResponse? resp = await repo.saveTicketDetails(event.bookingRequest);

                if(resp!=null && resp.responseCode ==200)
                  {
                    emit(BookingSuccessState(resp));
                  }
                else
                  {
                    emit(BookingErrorState("Something went wrong"));
                  }
          }
          catch(e)
      {
        emit(BookingErrorState("Something went wrong $e"));
      }

    });

  }
}
