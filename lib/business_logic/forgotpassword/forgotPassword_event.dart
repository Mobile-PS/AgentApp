part of 'forgotPassword_bloc.dart';

@immutable
abstract class forgotPasswordEvent extends Equatable{

}


class ForgotPasswordCall extends forgotPasswordEvent
{

  final String username;
  ForgotPasswordCall(this.username);

  @override
  List<Object?> get props => [];

}


