part of 'agentprofile_bloc.dart';

@immutable
abstract class AgentProfileEvent extends Equatable{

}


class AgentProfileCall extends AgentProfileEvent
{
  final int agentId;

  AgentProfileCall(this.agentId);
  @override
  List<Object?> get props => [];

}


