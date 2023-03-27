part of 'forgotPassword_bloc.dart';

@immutable
abstract class  ForgotPasswordState extends Equatable{

}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class LoadingforgotPasswordState extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordSuccessState extends ForgotPasswordState {
  ForgotPasswordSuccessState(this.value);
  ForgotPasswordResponse value;
  @override
  List<Object?> get props => [value];
}


class ErrorState extends ForgotPasswordState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
