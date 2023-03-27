part of 'print_ticket_bloc.dart';

@immutable
abstract class PrintTicketEvent  extends Equatable{




  PrintTicketEvent();

  @override
  List<Object?> get props => [];

}

class GetTicketDetailsByPNR extends PrintTicketEvent {
  final String pnr;
  final String lang;
  final String agentType;

  GetTicketDetailsByPNR(this.pnr, this.lang, this.agentType);
}
