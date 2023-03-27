part of 'agentprofile_bloc.dart';

@immutable
abstract class AgentProfileState extends Equatable{

}

class AgentProfileInitial extends AgentProfileState {
  @override
  List<Object?> get props => [];
}

class LoadingAgentProfileState extends AgentProfileState {
  @override
  List<Object?> get props => [];
}

class AgentProfileSuccessState extends AgentProfileState {
  AgentProfileSuccessState(this.value);
  AgentProfileResponse value;
  @override
  List<Object?> get props => [value];
}

class ErrorState extends AgentProfileState {
  final String error;
  ErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
