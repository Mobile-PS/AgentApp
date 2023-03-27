import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/bus_layout_filter_response.dart';
import 'package:ticket_agent/data/model/city_response.dart';

import '../../data/repos/SharedRepository.dart';

part 'shared_event.dart';
part 'shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  final SharedRepository sharedRepository;

  SharedBloc({required this.sharedRepository}) : super(SharedInitial()) {

    on<SuccessEvent>((event, emit) async {
      print("Helllo_-----------");
      emit(LoadingState());
      try{
        print("Helllo_---------4--");
        BusLayoutFilterResponse? busLayoutFilterResponse = await sharedRepository.getBusFilters();

        if(busLayoutFilterResponse!=null && busLayoutFilterResponse?.responseCode ==200)
          {

            print("Helllo_-----2------");
            emit(SuccessState(busLayoutFilterResponse));
          }
        else
          {
            print("Helllo_------1-----");
            emit(ErrorState("Something went wrong"));
          }

      }
      catch (e)
      {
        print("Helllo_----e-------");
        emit(ErrorState(e.toString()));
      }



    });

    on<CityLoadEvent>((event, emit) async {
      emit(LoadingState());
      try{
        print("Helllo_----city1-----");
        CityResponse? response = await sharedRepository.getCities();
        if(response!=null && response?.responseCode ==200)
        {
          print("Helllo_------city2-----");
          emit(CityLoadedState(response));
        }
        else
        {
          print("Helllo_-----city3-----");
          emit(ErrorState("Something went wrong"));
        }

      }
      catch (e)
      {
        print("Helllo_----city4------");
        emit(ErrorState(e.toString()));
      }



    });

  }





}
