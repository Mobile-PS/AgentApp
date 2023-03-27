import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_agent/data/model/login_response.dart';
import 'package:ticket_agent/data/repos/LoginRepository.dart';
import 'login_event.dart';
import 'login_state.dart';



  class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(InitialState()) {

  on<Create>((event, emit) async {

  emit(LoginLoading());
 // await Future.delayed(const Duration(seconds: 1));
  try {
    LoginResponse? loginResponse =  await loginRepository.loginUser( event.username,event.password);

    if(loginResponse!=null && loginResponse.responseCode ==200)
      {
        emit(Logined(loginResponse));
      }
    else
      {
        emit(LoginError("Enter valid details"));
      }

  } catch (e) {
  emit(LoginError(e.toString()));
  }
  });

  }
  }
