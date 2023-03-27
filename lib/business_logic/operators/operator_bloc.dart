import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/OperatorResponse.dart';
import '../../data/repos/SharedRepository.dart';
import '../sharebloc/shared_bloc.dart';

part 'operator_event.dart';
part 'operator_state.dart';

class OperatorBloc extends Bloc<OperatorEvent, OperatorState> {
  final SharedRepository sharedRepository;

  OperatorBloc({required this.sharedRepository}) : super(OperatorInitial()) {
    on<GetOperatorList>((event, emit) async {
      emit(LoadingOperatorState());

      try {
        print("Helllo_----Oeprator-----");
        OperatorResponse? response = await sharedRepository.getOperators(event.agentId);
        if (response != null && response?.responseCode == 200) {
          print("Helllo_------Oeprator-----");
          emit(OperatorSuccessState(response));
        }
        else {
          print("Helllo_-----Oeprator-----");
          emit(ErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(ErrorState("Something went wrong $e"));
      }
    });
  }
}
