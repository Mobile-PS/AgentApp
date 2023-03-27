part of 'booking_bloc.dart';

@immutable
abstract class bookingEvent {}

class initEvent extends bookingEvent {}

class Getbooking extends bookingEvent {
  BookingRequest bookingRequest;
  Getbooking(this.bookingRequest);
}