part of 'savenewpassword_bloc.dart';

@immutable
abstract class  SaveNewPasswordState extends Equatable{

}

class SaveNewPasswordInitial extends SaveNewPasswordState {
  @override
  List<Object?> get props => [];
}

class LoadingsavenewpasswordState extends SaveNewPasswordState {
  @override
  List<Object?> get props => [];
}

class SaveNewPasswordSuccessState extends SaveNewPasswordState {
  SaveNewPasswordSuccessState(this.value);
  SaveNewPasswordResponse value;
  @override
  List<Object?> get props => [value];
}


class ErrorState extends SaveNewPasswordState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
