
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ticket_agent/data/model/BordingPointsResponce.dart';
import 'package:ticket_agent/data/model/BusDetailRequest.dart';
import 'package:ticket_agent/data/model/BusDetailResponse.dart';
import 'package:ticket_agent/data/repos/BusRouteRepository.dart';

import '../../data/model/BusRouteResponse.dart';

part 'bus_route_event.dart';
part 'bus_route_state.dart';

class BusRouteBloc extends Bloc<BusRouteEvent, BusRouteState> {
  BusRouteRepository repo;

  BusRouteBloc(this.repo) : super(BusRouteInitial()) {


    on<getBusRoute>((event, emit) async {
      emit(LoadingState());
      try
          {
            BusRouteResponse? resp = await repo.getBusRoutes(event.agentId, event.busType, event.date, event.destination, event.lang, event.operatorId, event.source);

                if(resp!=null && resp.responseCode ==200)
                  {
                    emit(SuccessState(resp));
                  }
                else
                  {
                    emit(ErrorState("Something went wrong"));
                  }
          }
          catch(e)
      {
        emit(ErrorState("Something went wrong $e"));
      }

    });

    on<GetBusDetails>((event, emit) async {
      emit(BusDetailsLoadingState());

      try
      {
        BusDetailResponse? resp = await repo.getBusDetails(event.busDetailRequest);

        if(resp!=null && resp.responseCode ==200)
        {
          print("myresp $resp");
          emit(BusDetailsSuccessState(resp));
        }
        else
        {
          emit(BusDetailsErrorState("Something went wrong"));
        }
      }
      catch(e)
      {
        emit(BusDetailsErrorState("Something went wrong $e"));
      }

    });

    on<GetBoardingData>((event, emit) async {
      emit(BoardingLoadingState());
      try
      {
        BoardingPointsResponse? resp = await repo.getBoardingPoints(event.routeID,event.startId,event.stopId);

        if(resp!=null && resp.responseCode ==200)
        {

          print("testing ##### ${resp.responseCode}");
          emit(BoardingSuccessState(resp));
        }
        else
        {
          emit(BoardingErrorState("Something went wrong"));
        }
      }
      catch(e)
      {
        emit(BoardingErrorState("Something went wrong $e"));
      }

    });
  }
}
