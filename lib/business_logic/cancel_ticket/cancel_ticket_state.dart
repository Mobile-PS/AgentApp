

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/model/CancleTicketResponse.dart';

@immutable
abstract class CancelTicketState extends Equatable {}

class CancelTicketInitial extends CancelTicketState {
  @override
  List<Object?> get props => [];
}

class CancelLoadingState extends CancelTicketState {
  @override
  List<Object?> get props => [];
}

class CancelSuccessState extends CancelTicketState{

  final CancleTicketResponse cancelTicketResponse;
  CancelSuccessState(this.cancelTicketResponse);
  @override
  List<Object?> get props =>[cancelTicketResponse];

}

class CancelErrorState extends CancelTicketState {
  final String error;
  CancelErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

