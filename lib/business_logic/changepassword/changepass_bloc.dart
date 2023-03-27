import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/business_logic/operators/operator_bloc.dart';
import 'package:ticket_agent/data/model/OperatorResponse.dart';
import 'package:ticket_agent/data/model/changePasswordResponse.dart';
import '../../data/repos/LoginRepository.dart';
import '../../data/repos/SharedRepository.dart';

part 'changepass_event.dart';
part 'changepass_state.dart';

class ChangePassBloc extends Bloc<ChangePassEvent, ChangePassState> {
  final LoginRepository loginRepository;

  ChangePassBloc({required this.loginRepository}) : super(ChangePassInitial()) {
    on<ChangePasswordCall>((event, emit) async {
      emit(LoadingChangePassState());

      try {
        print("Helllo_----Oeprator-----1");
        ChangePasswordResponse? response =
            await loginRepository.changepasswordUser(event.agentId.toString(),
                event.username, event.oldPassword, event.newPassword);
        if (response != null && response?.responseCode == 200) {
          print("Helllo_------Oeprator-----2");
          emit(ChangePassSuccessState(response));
        } else {
          print("Helllo_-----Oeprator-----3");
          emit(ErrorState("Something went wrong"));
        }
      } catch (e) {
        emit(ErrorState("Something went wrong $e"));
      }
    });
  }
}
