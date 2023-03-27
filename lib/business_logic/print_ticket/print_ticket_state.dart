part of 'print_ticket_bloc.dart';

@immutable
abstract class PrintTicketState  extends Equatable{

}

class PrintTicketInitial extends PrintTicketState {
  @override
  List<Object?> get props => [];
}



class PrintLoadingState extends PrintTicketState {
  @override
  List<Object?> get props => [];
}

class PrintSuccessState extends PrintTicketState{

 final GetTicketInfoByPnrResponse ticketInfoByPnrResponse;
  PrintSuccessState(this.ticketInfoByPnrResponse);
  @override
  List<Object?> get props =>[ticketInfoByPnrResponse];

}

class PrintErrorState extends PrintTicketState {
  final String error;
  PrintErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
