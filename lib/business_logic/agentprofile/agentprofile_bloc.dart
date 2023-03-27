

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/business_logic/operators/operator_bloc.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/agentProfileResponse.dart';
import 'package:ticket_agent/data/model/changePasswordResponse.dart';
import 'package:ticket_agent/data/model/forgotPasswordResponse.dart';
import '../../data/repos/LoginRepository.dart';
import '../../data/repos/SharedRepository.dart';

part 'agentprofile_event.dart';
part 'agentprofile_state.dart';

class  AgentProfileBloc extends Bloc<AgentProfileEvent, AgentProfileState> {
  final LoginRepository loginRepository;

  AgentProfileBloc({required this.loginRepository}) : super(AgentProfileInitial()) {

    on<AgentProfileCall>((event, emit) async {

      emit(LoadingAgentProfileState());

      try {
        AgentProfileResponse? response = await loginRepository.getAgentProfile(event.agentId);
        if (response != null && response?.responseCode == 200) {
          emit(AgentProfileSuccessState(response));
        }
        else {
          emit(ErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(ErrorState("Something went wrong $e"));
      }
    });
  }
}



