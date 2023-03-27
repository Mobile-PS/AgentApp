part of 'operator_bloc.dart';

@immutable
abstract class OperatorEvent extends Equatable{

}


class GetOperatorList extends OperatorEvent
{
  final int agentId;
  GetOperatorList(this.agentId);

  @override
  List<Object?> get props => [];

}


