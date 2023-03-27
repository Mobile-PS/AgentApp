

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/business_logic/operators/operator_bloc.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/changePasswordResponse.dart';
import 'package:ticket_agent/data/model/forgotPasswordResponse.dart';
import '../../data/model/saveNewPasswordResponse.dart';
import '../../data/repos/LoginRepository.dart';
import '../../data/repos/SharedRepository.dart';

part 'savenewpassword_event.dart';
part 'savenewpassword_state.dart';

class  SaveNewPasswordBloc extends Bloc<saveNewPasswordEvent, SaveNewPasswordState> {
  final LoginRepository loginRepository;

  SaveNewPasswordBloc({required this.loginRepository}) : super(SaveNewPasswordInitial()) {

    on<SaveNewPasswordCall>((event, emit) async {

      emit(LoadingsavenewpasswordState());

      try {
        print("Helllo_----Oeprator-----1");
        SaveNewPasswordResponse? response = await loginRepository.getSavePasswordApi(event.username,
        event.agentId,event.newPassword,event.confirmPassword,event.otp);
        if (response != null && response?.responseCode == 200) {
          print("Helllo_------Oeprator-----2");
          emit(SaveNewPasswordSuccessState(response));
        }
        else {
          print("Helllo_-----Oeprator-----3");
          emit(ErrorState("Something went wrong"));
        }
      }
      catch (e) {
        emit(ErrorState("Something went wrong $e"));
      }
    });
  }
}



