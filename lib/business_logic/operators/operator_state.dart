part of 'operator_bloc.dart';

@immutable
abstract class OperatorState extends Equatable{

}

class OperatorInitial extends OperatorState {
  @override
  List<Object?> get props => [];
}

class LoadingOperatorState extends OperatorState {
  @override
  List<Object?> get props => [];
}

class OperatorSuccessState extends OperatorState {
  OperatorSuccessState(this.value);
  OperatorResponse value;
  @override
  List<Object?> get props => [value];
}

class ErrorState extends OperatorState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
