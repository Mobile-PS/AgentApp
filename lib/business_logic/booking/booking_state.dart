part of 'booking_bloc.dart';

@immutable
abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoadingState extends BookingState {
  @override
  List<Object?> get props => [];
}

class BookingSuccessState extends BookingState {
  BookingResponse bookingResponse;
  BookingSuccessState(this.bookingResponse);

  @override
  List<Object?> get props => [bookingResponse];
}

class BookingErrorState extends BookingState {
  final String error;

  BookingErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
