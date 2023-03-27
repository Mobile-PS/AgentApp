

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/business_logic/operators/operator_bloc.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/changePasswordResponse.dart';
import 'package:ticket_agent/data/model/forgotPasswordResponse.dart';
import '../../data/repos/LoginRepository.dart';
import '../../data/repos/SharedRepository.dart';

part 'forgotPassword_event.dart';
part 'forgotPassword_state.dart';

class  ForgotPasswordBloc extends Bloc<forgotPasswordEvent, ForgotPasswordState> {
  final LoginRepository loginRepository;

  ForgotPasswordBloc({required this.loginRepository}) : super(ForgotPasswordInitial()) {

    on<ForgotPasswordCall>((event, emit) async {

      emit(LoadingforgotPasswordState());

      try {
        print("Helllo_----Oeprator-----1");
        ForgotPasswordResponse? response = await loginRepository.forgotpasswordUser(event.username);
        if (response != null && response?.responseCode == 200) {
          print("Helllo_------Oeprator-----2");
          emit(ForgotPasswordSuccessState(response));
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



