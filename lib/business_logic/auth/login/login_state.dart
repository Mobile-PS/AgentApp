

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ticket_agent/data/model/login_response.dart';


@immutable
abstract class LoginState extends Equatable {}

class InitialState extends LoginState{
  @override
  List<Object?> get props => [];

}

class LoginLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class Logined extends LoginState{
  LoginResponse loginResponse;
  Logined(this.loginResponse);

  @override
  List<Object?> get props =>[];

}

class LoginError extends LoginState {
  final String error;
  LoginError(this.error);
  @override
  List<Object?> get props => [error];
}
