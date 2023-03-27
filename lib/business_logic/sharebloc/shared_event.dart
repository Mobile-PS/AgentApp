part of 'shared_bloc.dart';

abstract class SharedEvent extends Equatable {
  const SharedEvent();


}

class SuccessEvent extends SharedEvent
{
  @override
  List<Object?> get props => [];

}

class CityLoadEvent extends SharedEvent
{
  @override
  List<Object?> get props => [];

}


