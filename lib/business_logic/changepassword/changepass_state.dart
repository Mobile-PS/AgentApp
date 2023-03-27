part of 'changepass_bloc.dart';

@immutable
abstract class ChangePassState extends Equatable{

}

class ChangePassInitial extends ChangePassState {
  @override
  List<Object?> get props => [];
}

class LoadingChangePassState extends ChangePassState {
  @override
  List<Object?> get props => [];
}

class ChangePassSuccessState extends ChangePassState {
  ChangePassSuccessState(this.value);
  ChangePasswordResponse value;
  @override
  List<Object?> get props => [value];
}

class ErrorState extends ChangePassState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
