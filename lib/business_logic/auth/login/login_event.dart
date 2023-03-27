


import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class initEvent extends LoginEvent {}

class Create extends LoginEvent {
  final String username;
  final String password;

  Create(this.username, this.password);
}