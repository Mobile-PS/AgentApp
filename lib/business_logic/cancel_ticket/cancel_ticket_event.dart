

import 'package:flutter/material.dart';

@immutable
abstract class CancelTicketEvent {


CancelTicketEvent();

@override
List<Object?> get props => [];

}

class CancelTicket extends CancelTicketEvent {
  final String pnr;
  final int agentId;

  CancelTicket(this.pnr, this.agentId);
}